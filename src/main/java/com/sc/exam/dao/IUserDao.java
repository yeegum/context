package com.sc.exam.dao;

import com.sc.exam.pojo.User;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface IUserDao {
    User getOne(String account);
    List<User> getList(User user);
    Integer deleteone(Integer userid);
    Integer deleteroleuser(Integer userid);
    User getOnebyid(Integer userid);
    Integer updateuser(User user);
    Integer insertuser(User user);
    Integer updatepasw(Integer userid);
}
