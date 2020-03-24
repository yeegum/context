package com.sc.exam.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecvEmail {
    private Integer id;
    private Integer send_userid;
    //发送者id
    private Integer recv_userid;
    //接收者id
    private String topic;
    //邮件的标题
    private Timestamp dateTime;
    //邮件发送的时间
    private String content;
    //邮件内容
    private Integer status;
    //邮件状态
}
