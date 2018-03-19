package com.webstore.business.impl.specification;

import com.webstore.business.functionality.SqlConverter;
import com.webstore.business.service.SqlSpecification;

public class ByFieldSpec implements SqlSpecification {

	private String tableName;
	private String sql;
	private Object[] values;
	private SqlConverter sqlConverter = new SqlConverter();

		public ByFieldSpec(String tableName, Object ... values ) {
			
			this.tableName=tableName;
			this.values = values;
}


		@Override
	    public String toSqlQuery() {
			sql = "SELECT * FROM " + tableName +" WHERE true ";
			sql = sqlConverter.addValues(sql, values);
	        return sql;
	    }
	}
	

