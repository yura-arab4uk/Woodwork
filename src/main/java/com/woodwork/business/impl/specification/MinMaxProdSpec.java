package com.woodwork.business.impl.specification;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.SqlSpecification;

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
