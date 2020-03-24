package com.sc.exam.dao;

import com.sc.exam.pojo.Sms;
import org.springframework.stereotype.Repository;

@Repository
public interface ISmsDao {
    int addSms(Sms sms);
    Sms getSms(int code);
    int delSms();
    Sms getCodeByCodeAndTime(int code);
}
