package com.sc.exam.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Email {
    private Integer id;
    private String nickname;
    //昵称
    private Integer send_userid;
    //发送者id
    private Integer recv_userid;
    //接收者id
    private String topic;
    //邮件的标题
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Timestamp datetime;
    //邮件发送的时间
    private String content;
    //邮件内容
    private Integer status;
    //邮件状态
}
