package com.sc.exam.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.dao.IRoleDao;
import com.sc.exam.dao.IUserDao;
import com.sc.exam.pojo.User;
import com.sc.exam.service.IUserService;
import com.sc.exam.vo.ViewMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.util.List;

@Service
public class UserServiceImpl implements IUserService {
@Autowired
IUserDao userDao;
    @Autowired
    IRoleDao roleDao;
    @Override
    public ViewMsg<User> login(User user) {
        User users=new User();
        ViewMsg viewMsg=new ViewMsg();
        if (user.getAccount()!=null){
            users=userDao.getOne(user.getAccount());
        }
        if(users==null){
            viewMsg.setCode(201);
            viewMsg.setMsg("没有该用户");
            return viewMsg;
        }
        System.out.println(users.getPassword().equalsIgnoreCase(DigestUtils.md5DigestAsHex(user.getPassword().getBytes())));
        if(users.getPassword().equalsIgnoreCase(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()))){
            viewMsg.setCode(200);
            viewMsg.setMsg("成功");
            viewMsg.setData(users);
            return viewMsg;
        }
        viewMsg.setMsg("用户名或密码错误");
        viewMsg.setCode(202);
        return viewMsg;

    }

    @Override
    public PageInfo<User> getList(Integer page, int size, User user) {
        PageHelper.startPage(page,size);
        List<User> list=userDao.getList(user);

        PageInfo<User> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public Integer deleteone(Integer userid) {
        userDao.deleteroleuser(userid);
        return userDao.deleteone(userid);
    }

    @Override
    public User selectone(String account) {
        return userDao.getOne(account);
    }

    @Override
    public User getOnebyid(Integer userid) {
        User user=userDao.getOnebyid(userid);
        user.setRoles(roleDao.getRoleByuser(userid));
        return user;
    }

    @Override
    public ViewMsg updateuser(User user) {
        ViewMsg viewMsg=new ViewMsg();
        Integer res=userDao.updateuser(user);
        roleDao.deleterolebyuser(user.getUserid());
        if (user.getRoleIds()!=null) {
            /*9.11*/
            for (int i = 0; i < user.getRoleIds().length; i++) {
                roleDao.addroleuser(user.getUserid(),user.getRoleIds()[i]);
            }
        }
        if (res>=1)
        {viewMsg.setCode(400);
        viewMsg.setMsg("修改成功");
        viewMsg.setData(user);}
        return viewMsg;
    }

    @Override
    public ViewMsg insertuser(User user) {
        ViewMsg vm=new ViewMsg();
       Integer res= userDao.insertuser(user);
       User user2=userDao.getOne(user.getAccount());
        if (user!=null){
            for (int i = 0; i <user.getRoleIds().length ; i++) {
                roleDao.addroleuser(user2.getUserid(),user.getRoleIds()[i]);
            }
        }
        User user1=userDao.getOne(user.getAccount());
        user1.setRoles(roleDao.getRoleByuser(user1.getUserid()));
        if (res==1){
            vm.setCode(400);
            vm.setMsg("成功");
            vm.setData(user1);
        }
        return vm;
    }

}
