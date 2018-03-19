package com.webstore.business.impl;

import org.springframework.stereotype.Service;

import com.webstore.business.functionality.SqlConverter;
import com.webstore.business.service.SqlRepository;
import com.webstore.entities.Status;

@Service
public class StatusSqlRepository extends SqlRepository<Status> {

	private SqlConverter sqlConverter;
	
	public StatusSqlRepository() {
		super(Status.class);
	}

	@Override
	public void add(Iterable<Status> items) {
		
            for (Status s : items) {
            	jdbcTemplate.update(
        				"insert into status values(?,?,?)",
        				new Object[]{null,s.getName(),1});
              
            }
	}

	@Override
	public void update(Status s) {
		sqlConverter = new SqlConverter();
		String sql = "update status set ";
		Object [][] status = {
		{"name", s.getName()},
		{"enabled", s.getEnabled()},
		};
		for (Object [] o:status) {
			sql=sqlConverter.addIfNotNull(sql, o[0], o[1]);
		}
		sql=sql.replace("set ,", "set ");
		sql=sqlConverter.addWhereId(sql, s.getId());
		jdbcTemplate.update(sql);
	}

	@Override
	public void remove(Status s) {
		jdbcTemplate.update("update status set enabled=0,where id=?"+s.getId());
	}
	
}
