package com.webstore.business.impl.specification;

import java.util.List;

import com.webstore.business.functionality.SqlConverter;
import com.webstore.business.service.SqlSpecification;
import com.webstore.entities.Category;


public class MinMaxCatSpec implements SqlSpecification {

	private String sql="";
	private SqlConverter sqlConverter = new SqlConverter();
	private List<Category> items;
	private Integer catId;

	public MinMaxCatSpec(List<Category> items, Integer catId) {
		this.items = items;
		this.catId = catId;
	}

		@Override
	    public String toSqlQuery() {
			sql = sqlConverter.addCategories(sql,items,catId);
			return sql;
		}
}
