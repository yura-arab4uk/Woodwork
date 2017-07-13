package com.woodwork.business.impl;

import org.springframework.stereotype.Service;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.SqlRepository;
import com.woodwork.entities.CategoryProperty;

@Service("cPRepository")
public class CategoryPropertySqlRepository extends SqlRepository<CategoryProperty> {

	private SqlConverter sqlConverter;
	
	public CategoryPropertySqlRepository() {
		super(CategoryProperty.class);
	}

	@Override
	public void add(Iterable<CategoryProperty> items) {
		
            for (CategoryProperty cp: items) {
            	jdbcTemplate.update(
        				"insert into category_has_property values(?,?,?)",
        				new Object[]{
        					cp.getCategory_id(),cp.getProperty_id(),1
        				});
              
            }

	}

	@Override
	public void update(CategoryProperty cp) {
		sqlConverter = new SqlConverter();
		String sql = "update category_has_property set ";
		sql=sqlConverter.addIfNotNull(sql, "enabled", cp.getEnabled());
		sql=sql.replace("set ,", "set ");
		sql+=" where category_id="+cp.getCategory_id()
		+" and property_id="+cp.getProperty_id();
		jdbcTemplate.update(sql);
		
	}

	@Override
	public void remove(CategoryProperty cp) {
		jdbcTemplate.update("update category_has_property set enabled=0 where category_id=? and property_id=?",
				new Object[]{cp.getCategory_id(),cp.getProperty_id()});
	}

}
