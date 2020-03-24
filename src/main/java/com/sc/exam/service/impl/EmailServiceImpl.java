package com.sc.exam.service.impl;

import com.sc.exam.dao.IEmailDao;
import com.sc.exam.pojo.Email;
import com.sc.exam.service.IEmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmailServiceImpl implements IEmailService {

    @Autowired
    IEmailDao emailDao;
    @Override
    public List<Email> getRecvEmailList(Integer userid) {
        return emailDao.getRecvEmailList(userid);
    }

    @Override
    public int readRecvEmail(Integer userid,Integer id) {
        return emailDao.readRecvEmail(userid,id);
    }

    @Override
    public int delRecvEmail(Integer userid, Integer id) {
        return emailDao.delRecvEmail(userid, id);
    }

    @Override
    public List<Email> getSendEmailList(Integer userid) {
        return emailDao.getSendEmailList(userid);
    }

    @Override
    public int readSendEmail(Integer userid,Integer id) {
        return emailDao.readSendEmail(userid, id);
    }

    @Override
    public int delSendEmail(Integer userid, Integer id) {
        return emailDao.delSendEmail(userid, id);
    }

    @Override
    public List<Email> getRecycleEmailList(Integer userid) {
        return emailDao.getRecycleEmailList(userid);
    }

    @Override
    public int recovery(Integer id) {
        return emailDao.recovery(id);
    }

    @Override
    public int sendEmail(Email email) {
        return emailDao.sendEmail(email);
    }
}
