package com.webstore.business.impl.specification;

import com.webstore.business.functionality.SqlConverter;
import com.webstore.business.service.SqlSpecification;

public class CountUserSearchSpec implements SqlSpecification {

	private String sql;
	private SqlConverter sqlConverter = new SqlConverter();
	private String q;
	

	public CountUserSearchSpec(String q) {
		this.q = q;
	}



		@Override
	    public String toSqlQuery() {
			sql = "SELECT COUNT(user.id) as count FROM user WHERE true ";
			sql = sqlConverter.addSearch(sql,"user", q);
			return sql;
	    }
	}
	

