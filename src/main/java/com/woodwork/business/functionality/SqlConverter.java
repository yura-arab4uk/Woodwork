package com.woodwork.business.functionality;

import java.util.Collection;
import java.util.List;

import com.woodwork.entities.Category;
import com.woodwork.entities.Item;

public class SqlConverter {

	public String addValues(String sql, Object[] values) {

		for (int i = 1; i < values.length; i += 2) {
			if (values[i - 1] != null && values[i - 1] != "") {
				sql = sql + " and " + values[i - 1] + "='" + values[i]+"'";
			}

		}
		return sql;
	}

	public String addList(Collection<? extends Item> items) {

		StringBuilder sqlList = new StringBuilder();
		sqlList.append("(");
		for (Item item : items) {
			sqlList.append(item.getId());
			sqlList.append(",");
		}
		sqlList.deleteCharAt(sqlList.length() - 1);
		sqlList.append(")");
		return sqlList.toString();

	}
	
	public String addFilters(String sql,String prices,String condition) {
		
		if (condition!=null) {
			sql+=" and product.condition="+"\""+condition+"\"";
		}
		if (prices!=null) {
			String array[] = prices.split(",");
			sql+=" and product.price BETWEEN "+array[0]+" and "+array[1];
		}
        return sql;

	}

	public String addCategories(String sql,List<Category> items,Integer catId) {
		//якщо категорія має підкатегорії, то вибрати продукти з них
				if (items.size()!=0) sql+=" and product.category_id IN "+addList(items);
				else {
					sql+=" and product.category_id="+catId;
				}
			return sql;
	}
	
	public String addSearch(String sql,String tableName,String search) {
		if (search!=null)
		{
			String name = "name";
			if (tableName.equals("user")) name="firstname";
			else name="name";
				sql+=" and "+tableName+"."+name+" LIKE '%"+search+"%'";
			
		}		 				
			return sql;
	}
	
	public String addLimit(String sql, Integer page,Integer pAmount) {
		Integer limitOffset = (page - 1) * pAmount;
		sql+=" LIMIT "+limitOffset+","+pAmount;
		return sql;
	}
	
	public String addList(String sql,String list) {
		if (list!=null)
		sql+=" and product.category_id IN ("+list+")";
		return sql;
	}
	
	public String addIfNotNull(String sql,Object field,Object value) {
		if (value!=null) {
			sql+=","+field+"=";
			if (value instanceof String)
			sql+="'"+value+"'";
			else sql+=value;
		}
		return sql;
	}
	
	public String addWhereId(String sql,Integer id) {
			sql+=" WHERE id="+id;
		return sql;
	}
	
	public String addOrderBy(String sql,String order) {
		if (order!=null)	sql+=" ORDER BY "+order;
	return sql;
}
	
}
