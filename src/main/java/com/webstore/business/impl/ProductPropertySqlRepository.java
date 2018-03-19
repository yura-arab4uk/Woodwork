package com.webstore.business.impl;

import org.springframework.stereotype.Service;

import com.webstore.business.functionality.SqlConverter;
import com.webstore.business.service.SqlRepository;
import com.webstore.entities.ProductProperty;

@Service("pPRepository")
public class ProductPropertySqlRepository extends SqlRepository<ProductProperty> {
	
	private SqlConverter sqlConverter;
	
	public ProductPropertySqlRepository() {
		super(ProductProperty.class);
	}

	@Override
	public void add(Iterable<ProductProperty> items) {
		
            for (ProductProperty pp : items) {
            	jdbcTemplate.update(
        				"insert into product_has_property values(?,?,?,?)",
        				new Object[]{pp.getProduct_id(),pp.getProperty_id(),
        						pp.getValue_as_string(),1});
              
            }

	}

	@Override
	public void update(ProductProperty pp) {
		sqlConverter = new SqlConverter();
		String sql = "update product_has_property set ";
		Object [][] productProperty = {
		{"value_as_string", pp.getValue_as_string()},
		{"enabled", pp.getEnabled()},
		};
		for (Object [] o:productProperty) {
			sql=sqlConverter.addIfNotNull(sql, o[0], o[1]);
		}
		sql=sql.replace("set ,", "set ");
		sql+=" where product_id="+pp.getProduct_id()
		+" and property_id="+pp.getProperty_id();
		
		jdbcTemplate.update(sql);
	}

	@Override
	public void remove(ProductProperty pp) {
		jdbcTemplate.update("update product_has_property set enabled=0 where product_id=? and property_id=?",
				new Object[]{pp.getProduct_id(),pp.getProperty_id()});
	}
	
}
