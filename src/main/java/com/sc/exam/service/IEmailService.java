package com.sc.exam.service;

import com.sc.exam.pojo.Email;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IEmailService {
    List<Email> getRecvEmailList(@Param("userid") Integer userid);
    int readRecvEmail(@Param("userid") Integer userid, @Param("id") Integer id);
    int delRecvEmail(@Param("userid") Integer userid, @Param("id") Integer id);
    List<Email> getSendEmailList(@Param("userid") Integer userid);
    int readSendEmail(@Param("userid") Integer userid, @Param("id") Integer id);
    int delSendEmail(@Param("userid") Integer userid, @Param("id") Integer id);
    List<Email> getRecycleEmailList(@Param("userid") Integer userid);
    int recovery(@Param("id") Integer id);
    int sendEmail(Email email);
}
