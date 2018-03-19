package com.webstore.business.impl.specification;

import com.webstore.business.functionality.SqlConverter;
import com.webstore.business.service.SqlSpecification;

public class ProductSearchSpec implements SqlSpecification {

	private String sql;
	private SqlConverter sqlConverter = new SqlConverter();
	private String q;
	private String prices;
	private String condition;
	private String list;
	private Integer page;
	private Integer pAmount;
	
	public ProductSearchSpec(String q, String prices, String condition, String list, Integer page, Integer pAmount) {
		this.q = q;
		this.prices = prices;
		this.condition = condition;
		this.list = list;
		this.page = page;
		this.pAmount = pAmount;
	}


		@Override
	    public String toSqlQuery() {
			sql = "SELECT * FROM product WHERE enabled=1 ";
			sql = sqlConverter.addFilters(sql, prices, condition);
			sql = sqlConverter.addSearch(sql,"product", q);
			sql = sqlConverter.addList(sql, list);
			sql = sqlConverter.addLimit(sql, page, pAmount);
			return sql;
	    }
	}
	

