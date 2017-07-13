package com.woodwork.business.impl.specification;

import java.util.List;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.SqlSpecification;
import com.woodwork.entities.Category;


public class ProductsSpec implements SqlSpecification {

	private String sql;
	private SqlConverter sqlConverter = new SqlConverter();
	private List<Category> items;
	private String prices;
	private String condition;
	private Integer catId;
	private Integer page;
	private Integer pAmount;
	

	public ProductsSpec(List<Category> items, String prices, String condition, Integer catId, Integer page, Integer pAmount) {
		this.items = items;
		this.prices = prices;
		this.condition = condition;
		this.catId = catId;
		this.page = page;
		this.pAmount = pAmount;
	}

		@Override
	    public String toSqlQuery() {
			sql = "SELECT * FROM product where enabled=1 ";
			sql = sqlConverter.addFilters(sql,prices, condition);
			sql = sqlConverter.addCategories(sql,items,catId);
			sql = sqlConverter.addLimit(sql, page, pAmount);
			return sql;
		}
}
