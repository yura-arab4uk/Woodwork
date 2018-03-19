package com.webstore.business.impl.specification;

import com.webstore.business.functionality.SqlConverter;
import com.webstore.business.service.SqlSpecification;

public class MinMaxProdSpec implements SqlSpecification {

	private String sql="";
	private SqlConverter sqlConverter = new SqlConverter();
	private String q;

	public MinMaxProdSpec(String q) {
		this.q = q;
	}

	@Override
	public String toSqlQuery() {
		sql = sqlConverter.addSearch(sql,"product", q);
		return sql;
	}
}
