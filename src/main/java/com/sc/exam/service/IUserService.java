package com.sc.exam.service;

import com.github.pagehelper.PageInfo;
import com.sc.exam.pojo.User;
import com.sc.exam.vo.ViewMsg;

public interface IUserService {
     ViewMsg login(User user);
     public PageInfo<User> getList(Integer page, int size, User user);
     Integer deleteone(Integer userid);
     User selectone(String account);
     User getOnebyid(Integer userid);
     ViewMsg updateuser(User user);
     ViewMsg insertuser(User user);

}
