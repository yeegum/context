package com.sc.exam.service.impl;


import com.sc.exam.dao.ISmsDao;
import com.sc.exam.dao.IUsersDao;
import com.sc.exam.pojo.Sms;
import com.sc.exam.service.ISmsServcie;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class ISmsServicesImpl implements ISmsServcie {
    @Autowired
    ISmsDao iSmsDao;
    @Autowired
    IUsersDao iUsersDao;

    @Override
    public String addSms(String phone) {
        if (iUsersDao.getPhone(phone) != null) {
            return "电话号码已注册";
        }
        iSmsDao.delSms();
        Random random=new Random();
        int code= random.nextInt(900000)+100000;
        Sms sms=new Sms();
        sms.setPhone(phone);
        sms.setCode(code);
        iSmsDao.addSms(sms);
        return String.valueOf(code);
    }
}
