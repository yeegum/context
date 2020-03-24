package com.sc.exam.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Friends {
    private Integer id;
    private Integer apply_userid;
    //申请者的id
    private Integer applied_userid;
    //被申请者的id
    private String apply_content;
    //申请描述
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Timestamp apply_datetime;
    //申请的时间
    private Integer status;
    //申请关系的状态

    public Friends(Integer apply_userid, Integer applied_userid, Timestamp applyDateTime) {
        this.apply_userid = apply_userid;
        this.applied_userid = applied_userid;
        this.apply_datetime = applyDateTime;
    }
}
