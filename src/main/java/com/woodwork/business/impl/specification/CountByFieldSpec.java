package com.woodwork.business.impl.specification;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.SqlSpecification;

public class CountByFieldSpec implements SqlSpecification {

	private String tableName;
	private String sql;
	private String[] values;
	private SqlConverter sqlConverter = new SqlConverter();

		public CountByFieldSpec(String tableName, String ... values ) {
			
			this.tableName=tableName;
			this.values = values;
}


		@Override
	    public String toSqlQuery() {
			sql = "SELECT COUNT("+tableName+".id) as count FROM " + tableName +" WHERE true ";
			sql = sqlConverter.addValues(sql, values);
	        return sql;
	    }
	}
	

