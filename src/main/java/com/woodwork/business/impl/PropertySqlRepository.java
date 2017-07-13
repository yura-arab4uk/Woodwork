package com.woodwork.business.impl;

import org.springframework.stereotype.Service;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.SqlRepository;
import com.woodwork.entities.Property;

@Service("propRepository")
public class PropertySqlRepository extends SqlRepository<Property> {
	
	private SqlConverter sqlConverter;
	
	public PropertySqlRepository() {
		super(Property.class);
	}

	@Override
	public void add(Iterable<Property> items) {
		
            for (Property p : items) {
            	jdbcTemplate.update(
        				"insert into property values(?,?,?,?)",
        				new Object[]{null,p.getName(),p.getType(),1});
              
            }

	}

	@Override
	public void update(Property p) {
		sqlConverter = new SqlConverter();
		String sql = "update property set ";
		Object [][] property = {
		{"name", p.getName()},
		{"type", p.getType()},
		{"enabled", p.getEnabled()},
		};
		for (Object [] o:property) {
			sql=sqlConverter.addIfNotNull(sql, o[0], o[1]);
		}
		sql=sql.replace("set ,", "set ");
		sql=sqlConverter.addWhereId(sql, p.getId());
		jdbcTemplate.update(sql);
	}

	@Override
	public void remove(Property p) {
		jdbcTemplate.update("update property set enabled=0,where id=?"+p.getId());
	}
}
