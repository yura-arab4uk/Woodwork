package com.woodwork.business.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.woodwork.business.functionality.SqlConverter;
import com.woodwork.business.service.ProductRepository;
import com.woodwork.business.service.Specification;
import com.woodwork.business.service.SqlRepository;
import com.woodwork.business.service.SqlSpecification;
import com.woodwork.entities.Product;

@Service("prodRepository")
public class ProductSqlRepository extends SqlRepository<Product> implements ProductRepository {

	private SqlConverter sqlConverter;
	
	public ProductSqlRepository() {
		super(Product.class);
	}

	@Override
	public void add(Iterable<Product> items) {
		
            for (Product p : items) {
            	jdbcTemplate.update(
        				"insert into product values(?,?,?,?,?,?,?,?)",
        				new Object[]{null,p.getName(),p.getDescription(),
        						p.getCondition(),p.getCategory_id(),p.getPrice(),
        						p.getImage(),1});
              
            }

	}

	@Override
	public void update(Product p) {
		sqlConverter = new SqlConverter();
		String sql = "update product set ";
		Object [][] product = {
		{"name", p.getName()},
		{"description", p.getDescription()},
		{"condition", p.getCondition()},
		{"category_id", p.getCategory_id()},
		{"price", p.getPrice()},
		{"image", p.getImage()},
		{"enabled", p.getEnabled()},
		};
		for (Object [] o:product) {
			sql=sqlConverter.addIfNotNull(sql, o[0], o[1]);
		}
		sql=sql.replace("set ,", "set ");
		sql=sqlConverter.addWhereId(sql, p.getId());
		
		jdbcTemplate.update(sql);
	}

	@Override
	public void remove(Product p) {
		jdbcTemplate.update("update product set enabled=0 where id="+p.getId());
		jdbcTemplate.update("update woodwork.order set status_id=?,status_description=? where product_id=?",
				new Object[]{4,"We are not producing this product anymore",p.getId()});
		jdbcTemplate.update("update product_has_property set enabled=0 where product_id="+p.getId());
	}
	
	@Override
	public Integer[] getMinMaxPrice(Specification specification) {
		SqlSpecification sqlSpecification = (SqlSpecification) specification;
		String sql="SELECT MIN(price) as min,MAX(price) as max FROM product WHERE enabled=1";
		sql += sqlSpecification.toSqlQuery();
		/*if (condition!=null)
		if(!condition.equals(null)&&!condition.equals("all")) sql+=" and product.condition="+"\""+condition+"\"";*/
		return jdbcTemplate.queryForObject(
				sql,new RowMapper<Integer[]>() {
					
					@Override
					public Integer[] mapRow(ResultSet rs, int rowNum) throws SQLException {
					Integer[] minMax = new Integer[2];
					minMax[0]=rs.getInt("min");
					minMax[1]=rs.getInt("max");
					return minMax;
					}
				});
	};
	
	@Override
	public Integer getMaxId() {
		return jdbcTemplate.queryForObject("SELECT MAX(id) FROM product", Integer.class);
	};
	
}
