package com.webstore.business.impl;

import org.springframework.stereotype.Service;

import com.webstore.business.functionality.SqlConverter;
import com.webstore.business.service.SqlRepository;
import com.webstore.entities.User;

@Service("uRepository")
public class UserSqlRepository extends SqlRepository<User> {

	private SqlConverter sqlConverter;
	
	public UserSqlRepository() {
		super(User.class);
	}

	@Override
	public void add(Iterable<User> items) {
		
            for (User u : items) {
            	jdbcTemplate.update(
        				"insert into user values(?,?,?,?,?,?,?,md5(?),?)",
        				new Object[]{null,u.getEmail(),u.getLogin(),
        						u.getPhone_number(),u.getFirstname(),
        						u.getLastname(),1,u.getPassword(),"ROLE_USER"});
              
            }

	}

	@Override
	public void update(User u) {
		sqlConverter = new SqlConverter();
		String sql = "update user set ";
		Object [][] user = {
		{"email", u.getEmail()},
		{"login", u.getLogin()},
		{"phone_number", u.getPhone_number()},
		{"firstname", u.getFirstname()},
		{"lastname", u.getLastname()},
		{"enabled", u.getEnabled()},
		{"password", u.getPassword()},
		{"role", u.getRole()}
		};
		for (Object [] o:user) {
			sql=sqlConverter.addIfNotNull(sql, o[0], o[1]);
		}
		sql=sql.replace("set ,", "set ");
		sql=sqlConverter.addWhereId(sql, u.getId());
		
		jdbcTemplate.update(sql);
	}

	@Override
	public void remove(User u) {
		jdbcTemplate.update("update user set enabled=0 where id="+u.getId());
		jdbcTemplate.update("update woodwork.order set enabled=?,status_id=?,status_description=? where user_id=?",
				new Object[]{0,4,"This user has been deleted",u.getId()});
	}

}
