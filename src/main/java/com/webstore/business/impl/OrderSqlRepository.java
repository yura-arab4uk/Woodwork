package com.webstore.business.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Service;

import com.webstore.business.functionality.SqlConverter;
import com.webstore.business.service.SqlRepository;
import com.webstore.entities.Order;

@Service("oRepository")
public class OrderSqlRepository extends SqlRepository<Order> {
	
	SqlConverter sqlConverter;
	
	public OrderSqlRepository() {
		super(Order.class);
	}

	@Override
	public void add(Iterable<Order> items) {
		
            for (Order o : items) {
            	
            	Date dNow = o.getDate();
      	      SimpleDateFormat ft = 
      	      new SimpleDateFormat ("dd.MM.yyyy HH:mm:ss");
      	      
            	try {
					dNow=ft.parse(ft.format(dNow));
				} catch (ParseException e) {
					throw new RuntimeException(e);
				}
      	      
            	jdbcTemplate.update(
        			"insert into woodwork.order values(?,?,?,?,?,?)",
        			new Object[]{null,o.getUser_id(),o.getProduct_id(),
        			dNow,o.getStatus_id(),o.getStatus_description()});
            }

	}

	@Override
	public void update(Order o) {
		sqlConverter = new SqlConverter();
		String sql = "update woodwork.order set ";
		Date dNow = o.getDate();
	      SimpleDateFormat ft = 
	      new SimpleDateFormat ("dd.MM.yyyy HH:mm:ss");
	      
      	try {
				dNow=ft.parse(ft.format(dNow));
			} catch (ParseException e) {
				throw new RuntimeException(e);
			}
		Object [][] order = {
		{"user_id", o.getUser_id()},
		{"product_id", o.getProduct_id()},
		{"date", dNow},
		{"status_id", o.getStatus_id()},
		{"status_description", o.getStatus_description()}
		};
		for (Object [] or:order) {
			sql=sqlConverter.addIfNotNull(sql, or[0], or[1]);
		}
		sql=sql.replace("set ,", "set ");
		sql=sqlConverter.addWhereId(sql, o.getId());
		
		jdbcTemplate.update(sql);
		
	}

	@Override
	public void remove(Order o) {
		jdbcTemplate.update("update woodwork.order set status_id=? "
				+ "where id=?",
				new Object[]{4,o.getId()});
	}

}
