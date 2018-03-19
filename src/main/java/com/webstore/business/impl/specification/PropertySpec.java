package com.webstore.business.impl.specification;

import com.webstore.business.functionality.SqlConverter;
import com.webstore.business.service.SqlSpecification;

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
	

