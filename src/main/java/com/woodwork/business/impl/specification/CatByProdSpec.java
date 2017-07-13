package com.woodwork.business.impl.specification;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.SqlSpecification;

public class CatByProdSpec implements SqlSpecification {

	private String sql;
	private SqlConverter sqlConverter = new SqlConverter();
	private String q;
	private String prices;
	private String condition;
	
		
	public CatByProdSpec(String q, String prices, String condition) {
		this.q = q;
		this.prices = prices;
		this.condition = condition;
	}


		@Override
	    public String toSqlQuery() {
			sql = "SELECT DISTINCT(c.id),c.name,c.parent,c.enabled FROM category c INNER JOIN product ON"
					+ " c.id=product.category_id WHERE product.enabled=1 ";
			sql = sqlConverter.addFilters(sql, prices, condition);
			sql = sqlConverter.addSearch(sql,"product", q);
			return sql;
	    }
	}
	

