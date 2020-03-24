package com.sc.exam.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.dao.IUsersDao;
import com.sc.exam.pojo.User;
import com.sc.exam.service.IUpdateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IUpdateServiceImpl implements IUpdateService {
    @Autowired
    IUsersDao iUsersDao;
    @Override
    public String updateUser(User user) {
        if(user.getFaceimg()==null){
            iUsersDao.updateUsers(user);
            return "修改成功";
        }

            iUsersDao.updateUser(user);
        return "修改成功";
    }

    @Override
    public User show(String account) {
        System.out.println(iUsersDao.userLoginByAccount(account));
        return iUsersDao.userLoginByAccount(account);
    }

    @Override
    public PageInfo<User> getList(int page, int limit) {

        PageHelper.startPage(page, limit);
        List<User> list = iUsersDao.getList();
        PageInfo<User> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

}
