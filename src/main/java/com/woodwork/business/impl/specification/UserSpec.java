package com.woodwork.business.impl.specification;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.SqlSpecification;

public class UserSpec implements SqlSpecification {

	private String sql;
	private SqlConverter sqlConverter = new SqlConverter();
	private String q;
	private String order;
	private Integer page;
	private Integer pAmount;
		
	public UserSpec(String q, String order, Integer page, Integer pAmount) {
		this.q = q;
		this.order = order;
		this.page = page;
		this.pAmount = pAmount;
	}



		@Override
	    public String toSqlQuery() {
			sql = "SELECT user.id,user.email,user.login,user.phone_number,user.firstname,user.lastname,user.enabled FROM user WHERE true";
			sql = sqlConverter.addSearch(sql, "user", q);
			sql = sqlConverter.addOrderBy(sql, order);
			sql = sqlConverter.addLimit(sql, page, pAmount);
	        return sql;
	    }
	}
	

