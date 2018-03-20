package com.webstore.business.impl;

import com.webstore.business.impl.specification.CountUserSearchSpec;
import com.webstore.business.impl.specification.UserSpec;
import com.webstore.business.service.SqlSpecification;
import com.webstore.entities.User;
import mockito.MockitoExtension;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.doReturn;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@ExtendWith(MockitoExtension.class)
public class UserSqlRepositoryTest {

    @Mock
    private JdbcTemplate jdbcTemplate;

    @InjectMocks
    @Spy
    private UserSqlRepository userSqlRepository;

    private List<User> users;

    private Object [] user1Params;

    private Object [] user2Params;

    @BeforeEach
    void setup() {
        users = new ArrayList<>();
        User user = new User();
        user.setLogin("user1");
        user1Params = new Object[] {
                null, user.getEmail(), user.getLogin(), user.getPhone_number(),
                user.getFirstname(), user.getLastname(), 1, user.getPassword(),
                "ROLE_USER"
        };

        users.add(user);
        user = new User();
        user.setLogin("user2");
        users.add(user);
        user2Params = new Object[] {
                null, user.getEmail(), user.getLogin(), user.getPhone_number(),
                user.getFirstname(), user.getLastname(), 1, user.getPassword(),
                "ROLE_USER"
        };
    }

    @Test
    void testQuery_ShouldReturnUsers() {
        //Arrange
        UserSpec userSpec = new UserSpec("username", null, 1, 10);
        doReturn(users).when(jdbcTemplate).query(eq(userSpec.toSqlQuery()), any(BeanPropertyRowMapper.class));

        //Act
        List<User> actual = userSqlRepository.query(userSpec);

        //Assert
        assertEquals(users, actual);
    }

    @Test
    void testAdd_ShouldAdd_ByIterable() {
        //Arrange
        User u1 = users.get(0);
        User u2 = users.get(1);

        doReturn(user1Params).when(userSqlRepository).getParamsForAdd(u1);
        doReturn(user2Params).when(userSqlRepository).getParamsForAdd(u2);

        //Act
        userSqlRepository.add(users);

        //Assert
        Mockito.verify(jdbcTemplate).update("insert into user values(?,?,?,?,?,?,?,md5(?),?)", user1Params);
        Mockito.verify(jdbcTemplate).update("insert into user values(?,?,?,?,?,?,?,md5(?),?)", user2Params);
    }

    @Test
    void testAdd_ShouldAdd_ByUser() {
        //Arrange
        User user = users.get(0);
        List<User> users = Collections.singletonList(user);

        //Act
        userSqlRepository.add(user);

        //Assert
        Mockito.verify(userSqlRepository).add(users);
    }

    @Test
    void testUpdate_ShouldUpdate() {
        //Arrange
        User user = new User();
        user.setLogin("login");
        user.setId(21);
        String expectedSqlString = "update user set login='login' WHERE id=21";

        //Act
        userSqlRepository.update(user);

        //Assert
        Mockito.verify(jdbcTemplate).update(expectedSqlString);
    }

    @Test
    void testRemove_ShouldRemove_ByUser() {
        //Arrange
        User user = new User();
        user.setLogin("login");
        user.setId(1);

        Object [] userParams = new Object[] { 0, 4, "This user has been deleted", user.getId() };

        doReturn(userParams).when(userSqlRepository).getParamsForRemove(user);

        //Act
        userSqlRepository.remove(user);

        //Assert
        Mockito.verify(jdbcTemplate).update("update user set enabled=0 where id=1");
        Mockito.verify(jdbcTemplate).update("update woodwork.order set enabled=?,status_id=?,status_description=? where user_id=?", userParams);
    }

    @Test
    void testRemove_ShouldRemove_BySpec() {
        //Arrange
        String removeSqlString = "update user set enabled=0 where id=55";
        SqlSpecification sqlSpecification = () -> removeSqlString;

        //Act
        userSqlRepository.remove(sqlSpecification);

        //Assert
        Mockito.verify(jdbcTemplate).update(removeSqlString);
    }

    @Test
    void testGetCount_ShouldReturnInteger() {
        //Arrange
        CountUserSearchSpec countProductsSpec = new CountUserSearchSpec("user");

        Integer expectedCount = 8;
        doReturn(expectedCount).when(jdbcTemplate).queryForObject(eq(countProductsSpec.toSqlQuery()), ArgumentMatchers.<RowMapper>any());

        //Act
        Integer actualCount = userSqlRepository.getCount(countProductsSpec);

        //Assert
        assertEquals(expectedCount, actualCount);
    }

    @Test
    void testGetParams() {
        //Arrange
        User user = users.get(0);
        User removeUser = new User();
        removeUser.setId(12);

        //Act
        Object[] actualAddParams = userSqlRepository.getParamsForAdd(user);
        Object[] actualRemoveParams = userSqlRepository.getParamsForRemove(user);

        //Assert
        assertEquals(user.getLogin(), actualAddParams[2]);
        assertEquals(user.getId(), actualRemoveParams[3]);
    }

}
