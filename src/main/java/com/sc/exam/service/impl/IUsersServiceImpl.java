package com.sc.exam.service.impl;
import com.sc.exam.dao.IRoleDao;
import com.sc.exam.dao.ISmsDao;
import com.sc.exam.dao.IUsersDao;
import com.sc.exam.pojo.RegUser;
import com.sc.exam.pojo.Sms;
import com.sc.exam.pojo.User;
import com.sc.exam.service.IModularService;
import com.sc.exam.service.IRoleService;
import com.sc.exam.service.IUsersService;
import com.sc.exam.vo.ViewMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;


@Service
public class IUsersServiceImpl implements IUsersService {
    @Autowired
    IUsersDao iUsersDao;
    @Autowired
    ISmsDao iSmsDao;
    @Autowired
    IRoleService roleService;
    @Autowired
    IModularService modularService;
//    角色
    @Autowired
    IRoleDao iRoleDao;

    @Override
    public String regUser(RegUser regUser) {
        System.out.println(regUser);
        Sms sms=iSmsDao.getSms(regUser.getCode());
        System.out.println(sms+"sms");
       /* if (regUser.getCode()==null){
            return "验证码为空";
        }*/
        if(sms==null){
            System.out.println("验证码错误");
            return "验证码错误";
        }
        if(iSmsDao.getCodeByCodeAndTime(regUser.getCode())==null){
            return "输入验证码超时";
        }

       /* if(iUserDao.countIpByTimeAndIp(regUser.getIp())>2){
            return "今天注册账号超过三个,请明天再来";
        }*/
        if(iUsersDao.userLoginByAccount(regUser.getAccount()) != null){
            return ("账号名已被注册");
        }
        User user=new User();
        user.setPhone(regUser.getPhone());
        user.setAccount(regUser.getAccount());
        user.setPassword(regUser.getPassword());
        user.setIp(regUser.getIp());
        //默认头像
        user.setFaceimg("/upload/faceimg/a5.jpg");
        System.out.println("user"+user);
        iUsersDao.regUser(user);

//        赋予角色
        User user1 = iUsersDao.userLoginByPwd(user.getAccount(), user.getPassword());
        iRoleDao.addroleuser(user1.getUserid(),20);
        return "注册成功";
    }

    @Override
    public ViewMsg userLogin(String account, String password, HttpSession session) {
//        int i=0;
        ViewMsg viewMsg = new ViewMsg();
        if ( iUsersDao.userLoginByAccount(account)==null){
            viewMsg.setCode(112);
            viewMsg.setMsg("账号或密码错误");
            return viewMsg;
        }
        if(iUsersDao.userLoginByPwd(account,password)==null){
            viewMsg.setCode(113);
            viewMsg.setMsg("账号或密码错误");
            return viewMsg;
        }
        //设置session
        iUsersDao.updateLastLonginTime(new Timestamp(System.currentTimeMillis()),account);
        User user= iUsersDao.userLoginByPwd(account,password);
        user.setRoles(roleService.getRoleByuser(user.getUserid()));
        user.setModulars(modularService.getModularByuser(user.getUserid()));
        session.setAttribute("user", user);
//        User user1 = (User) session.getAttribute("user");
//        System.out.println("得到session"+user1);
//        if()
        for (int i = 0; i <user.getRoles().size();i++) {
            if(user.getRoles().get(i).getRoleid()==20){
                viewMsg.setCode(100);
                viewMsg.setMsg("登录成功");
                return viewMsg;
            }
        }
        viewMsg.setCode(200);
        viewMsg.setMsg("管理员登录成功");
        return viewMsg;
    }

   /* @Override
    public String logout(HttpSession session) {
        User user = (User) session.getAttribute("user");
        System.out.println("用户"+user.getUserid());
        iUserDao.logout(user.getUserid());
        return "注销成功";
    }*/
}
