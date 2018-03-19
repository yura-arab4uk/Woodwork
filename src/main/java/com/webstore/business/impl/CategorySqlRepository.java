package com.webstore.business.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.webstore.business.functionality.SqlConverter;
import com.webstore.business.impl.specification.ByFieldSpec;
import com.webstore.business.service.CategoryRepository;
import com.webstore.business.service.SqlRepository;
import com.webstore.entities.Category;

@Service("cRepository")
public class CategorySqlRepository extends SqlRepository<Category> implements CategoryRepository  {
	
	private SqlConverter sqlConverter;
	
	public CategorySqlRepository(){
		super(Category.class);
	}

	@Override
	public void add(Iterable<Category> items) {
		
            for (Category c : items) {
            	jdbcTemplate.update(
        				"insert into category values (?,?,?,?)",
        				new Object[]{null,c.getName(),c.getParent(),1});
              
            }

	}

	@Override
	public void update(Category c) {
		sqlConverter = new SqlConverter();
		String sql = "update category set ";
		Object [][] category = {
		{"name", c.getName()},
		{"parent", c.getParent()},
		{"enabled", c.getEnabled()}
		};
		for (Object [] o:category) {
			sql=sqlConverter.addIfNotNull(sql, o[0], o[1]);
		}
		sql=sql.replace("set ,", "set ");
		sql=sqlConverter.addWhereId(sql, c.getId());
		
		jdbcTemplate.update(sql);
		
	}
	
	@Override
	public void remove(Category c) {
		List<List<Category>> subCategories=getAllSubCategories(c.getId());
		List<Category> sub_s= new ArrayList<>();
		sub_s.addAll(subCategories.get(0));
		sub_s.addAll(subCategories.get(1));
		int i=0;
		for (Category sc:sub_s) {
			if (i>=subCategories.get(0).size())
			{
			jdbcTemplate.update("update product set enabled=0 where category_id="+sc.getId());
			jdbcTemplate.update("update woodwork.order"
					+ " inner join product on woodwork.order.product_id=product.id"
					+ " inner join category on product.category_id=category.id"
					+ " set woodwork.order.status_id=?,woodwork.order.status_description=?"
					+ " where category.id=?",
					new Object[]{4,"We are not producing this product anymore",sc.getId()});
			jdbcTemplate.update("update product_has_property "
					+ "inner join product on product.id=product_has_property.product_id "
					+ "inner join category on product.category_id=category.id "
					+ "set product_has_property.enabled='0' where category.id="+sc.getId());
			}
			jdbcTemplate.update("update category set enabled=0 where id="+sc.getId());
			jdbcTemplate.update("update category_has_property "
					+ "inner join category on category_has_property.category_id=category.id "
					+ "set category_has_property.enabled='0' where category.id="+sc.getId());
		i++;
		}
		
	}
	
	@Override
	public Set<Category> getParents(Integer id){
		Set<Category> catSet = new TreeSet<>();
		Category category=query(new ByFieldSpec("category","enabled","1","id",id)).get(0);
		Integer c1levelId =  jdbcTemplate.queryForObject(
				"SELECT c.id as firstId FROM category c where enabled=1 and id=(SELECT MIN(category.id) FROM category where enabled=1)",new RowMapper<Integer>() {
					
					@Override
					public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
					return rs.getInt("firstId");
					}
				});
		catSet.add(category);
		while (category.getParent()>=c1levelId) {
			category = query(new ByFieldSpec("category","enabled","1","id",category.getParent())).get(0);
			catSet.add(category);
		}
		
		return catSet;
	}
	//returns including the one with parameter value
	@Override
	public List<List<Category>> getAllSubCategories(Integer id){
		sqlConverter = new SqlConverter();
		Map<Integer, Set<Category>>  orderedCat_s=getCategories();
		Category category = query(new ByFieldSpec("category","enabled","1","id",id)).get(0);
		
		List<Category> categories = new ArrayList<>();
		List<Category> cat_sWithSub_s = new ArrayList<>();
		List<Category> justCat_s = new ArrayList<>();
		List<List<Category>> result = new ArrayList<>();
		if (orderedCat_s.get(category.getId())!=null){
			cat_sWithSub_s.add(category);
		} else justCat_s.add(category);
		categories.add(category);
		
		while (categories.size()!=0) {
			
			categories = jdbcTemplate.query("SELECT * FROM category WHERE parent IN "+sqlConverter.addList(categories),new BeanPropertyRowMapper<Category>(Category.class));
			if (categories.size()!=0) 
				{
				for (Category c:categories) {
					if (orderedCat_s.get(c.getId())!=null){
						cat_sWithSub_s.add(c);
					} else justCat_s.add(c);
				}
				}
		}
		result.add(cat_sWithSub_s);
		result.add(justCat_s);
		return result;
	}
	
	//returns Map<Parent,List<Category>>
	@Override
	public Map<Integer,Set<Category>> getCategories () {
		return jdbcTemplate.query("select * from category where enabled=1 order by parent asc",new ResultSetExtractor<Map<Integer, Set<Category>>>() {

			public Map<Integer,Set<Category>> extractData(ResultSet rs) throws SQLException {
				Map<Integer,Set<Category>> map = new TreeMap<>();
				Set<Category> set = new TreeSet<>();
				Integer currentParent=-1;
				while (rs.next()) {
					Category category = new Category();
					category.setId(rs.getInt("id"));
					category.setName(rs.getString("name"));
					category.setEnabled(rs.getInt("enabled"));
					category.setParent(rs.getInt("parent"));
					
					if (!currentParent.equals(rs.getInt("parent")))
					{
						set = new TreeSet<>();
						set.add(category);
						currentParent=rs.getInt("parent");
						map.put(currentParent,set);
					} else set.add(category);
					
				}
				return map;
			}
			}
			);
	}
	
	@Override
	public List<Category> getLastCategories () {
		sqlConverter = new SqlConverter();
		Map<Integer,Set<Category>> allCategories = getCategories ();
		//id's that have subs 
		Set<Integer> keys=allCategories.keySet();
		List<Category> categories = new ArrayList<>();
		for (Integer id:keys) {
			Category c=new Category();
			c.setId(id);
			categories.add(c);
		}
		List<Category> lastCategories = 
	jdbcTemplate.query("select * from category where enabled=1 AND id NOT IN "+
	sqlConverter.addList(categories),new BeanPropertyRowMapper<Category>(Category.class));
	return lastCategories;
	}
	
}
