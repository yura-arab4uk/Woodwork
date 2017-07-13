package com.woodwork.business.impl.specification;

import java.util.List;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.SqlSpecification;
import com.woodwork.entities.Category;


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
