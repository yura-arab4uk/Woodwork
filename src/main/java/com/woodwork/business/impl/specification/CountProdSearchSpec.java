package com.woodwork.business.impl.specification;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.SqlSpecification;

public class CountProdSearchSpec implements SqlSpecification {

	private String sql;
	private SqlConverter sqlConverter = new SqlConverter();
	private String q;
	private String prices;
	private String condition;
	private String list;
	

	public CountProdSearchSpec(String q, String prices, String condition, String list) {
		this.q = q;
		this.prices = prices;
		this.condition = condition;
		this.list = list;
	}



		@Override
	    public String toSqlQuery() {
			sql = "SELECT COUNT(product.id) as count FROM product WHERE enabled=1 ";
			sql = sqlConverter.addFilters(sql, prices, condition);
			sql = sqlConverter.addSearch(sql,"product", q);
			sql = sqlConverter.addList(sql, list);
			return sql;
	    }
	}
	

