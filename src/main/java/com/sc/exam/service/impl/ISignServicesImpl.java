package com.sc.exam.service.impl;
import com.sc.exam.dao.ISignDao;
import com.sc.exam.dao.IUsersDao;
import com.sc.exam.pojo.User;
import com.sc.exam.service.ISignService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.Date;

@Service
public class ISignServicesImpl implements ISignService {
    @Autowired
    ISignDao iSignDao;
    @Autowired
    IUsersDao iUsersDao;

    @Override
    public String sign(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if(user==null){
            return "您还没有登录";
        }
        System.out.println("签到次数"+iSignDao.signCountBytime(user.getUserid()));
        if(iSignDao.signCountBytime(user.getUserid())>0){
            return "三小时内已签到，签到失败";
        }
        //开始签到
        if(iSignDao.getSignByUserid(user.getUserid())==0){
            iSignDao.addSign(user.getUserid());
        }
        iSignDao.updateSign(user.getUserid(),new Timestamp(System.currentTimeMillis()));
        //增加积分
        Integer integral= iUsersDao.userLoginByPwd(user.getAccount(),user.getPassword()).getIntegral();
        iUsersDao.addIntegral(user.getUserid(),integral+10);

        return "签到成功";
    }
}
