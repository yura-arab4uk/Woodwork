package com.woodwork.business.impl.specification;

import java.util.List;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.SqlSpecification;
import com.woodwork.entities.Category;

public class CountProductsSpec implements SqlSpecification {

	private String sql;
	private SqlConverter sqlConverter = new SqlConverter();
	private List<Category> items;
	private String prices;
	private String condition;
	private Integer catId;
	
	
		public CountProductsSpec(List<Category> items,String prices, String condition, Integer catId ) {
			
			this.items = items;
			this.prices = prices;
			this.condition = condition;
			this.catId = catId;
			
}


		@Override
	    public String toSqlQuery() {
			sql = "SELECT COUNT(product.id) as count FROM product WHERE enabled=1 ";
			sql = sqlConverter.addFilters(sql, prices, condition);
			sql = sqlConverter.addCategories(sql,items,catId);
	        return sql;
	    }
	}
	

