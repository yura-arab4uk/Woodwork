package com.woodwork.business.impl.specification;

import java.util.Set;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.SqlSpecification;
import com.woodwork.entities.Item;

public class CatPropSpec implements SqlSpecification {

	private String sql;
	private SqlConverter sqlConverter = new SqlConverter();
	private Set<? extends Item> items; 
	
	public CatPropSpec(Set<? extends Item> items) {
		this.items = items;
	}

		@Override
	    public String toSqlQuery() {
			sql = "SELECT * FROM property p INNER JOIN category_has_property chp ON p.id = chp.property_id WHERE chp.category_id IN "+ sqlConverter.addList(items);
	        return sql;
	    }
	}
	

