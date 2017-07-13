package com.woodwork.business.impl.specification;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.SqlSpecification;

public class HomeSpec implements SqlSpecification {

	private String sql;
	private SqlConverter sqlConverter = new SqlConverter();
	private Integer page;
	private Integer pAmount;
	
		
	public HomeSpec(Integer page, Integer pAmount) {
		this.page = page;
		this.pAmount = pAmount;
	}

		@Override
	    public String toSqlQuery() {
			sql = "SELECT * FROM product where enabled=1 ";
			sql = sqlConverter.addLimit(sql, page, pAmount);
	        return sql;
	    }
}
