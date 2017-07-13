package com.woodwork.business.impl.specification;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.SqlSpecification;

public class PropertySpec implements SqlSpecification {

	private String sql;
	private SqlConverter sqlConverter = new SqlConverter();
	private ByFieldSpec byFS= new ByFieldSpec("property");
	private Integer page;
	private Integer pAmount;
		
	public PropertySpec(Integer page, Integer pAmount) {
		this.page = page;
		this.pAmount = pAmount;
	}



		@Override
	    public String toSqlQuery() {
			sql = byFS.toSqlQuery();
			sql = sqlConverter.addLimit(sql, page, pAmount);
	        return sql;
	    }
	}
	

