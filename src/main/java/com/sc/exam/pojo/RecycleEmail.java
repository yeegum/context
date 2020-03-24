package com.sc.exam.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecycleEmail {
    private Integer id;
    private Integer send_userid;
    //发送者id
    private Integer recv_userid;
    //接收者id
    private String topic;
    //邮件标题
    private Integer status;
    //邮件状态
    private Timestamp dataTime;
    //邮件时间
}
