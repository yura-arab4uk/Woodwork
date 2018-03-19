package com.webstore.business.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public abstract class SqlRepository<T> implements Repository<T> {

	@Autowired
	protected JdbcTemplate jdbcTemplate;
	private Class<T> c; 
	public SqlRepository(Class<T> c){
		this.c=c;
	}
	
	@Override
	public void add(T item) {
		add(Collections.singletonList(item));
	}
	
	@Override
	public void remove(Specification specification) {
		SqlSpecification sqlSpecification = (SqlSpecification) specification;
		jdbcTemplate.update(sqlSpecification.toSqlQuery());
	}
	
	@Override
	public List<T> query(Specification specification) {
		SqlSpecification sqlSpecification = (SqlSpecification) specification;
		List<T> items = jdbcTemplate.query(
				sqlSpecification.toSqlQuery(),
				new BeanPropertyRowMapper<T>(c));
		return items;
	}
	
	private class CountRowMapper implements RowMapper<Integer> {
		
		@Override
		public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {

			return rs.getInt("count");
		}
	}
	
	@Override
	public Integer getCount(Specification specification) {
		SqlSpecification sqlSpecification = (SqlSpecification) specification;
		return jdbcTemplate.queryForObject(
				sqlSpecification.toSqlQuery(),new CountRowMapper());
	}
	
}
