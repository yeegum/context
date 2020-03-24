package com.sc.exam.dao;

import com.sc.exam.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;
@Repository
public interface IUsersDao {
    Integer countIpByTimeAndIp(String ip);
    Integer regUser(User user);
    List<User> getUser();
    String getPhone(String phone);
    User userLoginByAccount(String account);
    User userLoginByPwd(@Param(value = "account") String account, @Param(value = "password") String password);
    int updateLastLonginTime(@Param(value = "lastlogintime") Timestamp lastlogintime, @Param(value = "account") String acount);
    int addIntegral(@Param(value = "userid") Integer userid, @Param(value = "integral") Integer integral);
    int updateUser(User user);
    int updateUsers(User user);
    int logout(Integer userid);
    List<User> getList();
    User getUserById(Integer userid);
}
