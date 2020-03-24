package com.sc.exam.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReplyPosts {
    private Integer reply_id;
    private Integer user_id;
//    回复者的id
    private Integer responded_id;
//    被回复的id,默认为0，就是代表回复的是帖子
    private Integer post_id;
//    回复帖子的id
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Timestamp apply_time;
//    回复的时间
    private String apply_content;
//    回复的内容
    private Integer apply_status;
//    回复的状态，1:为启用，0为禁用
    private Integer apply_essence;
//    是否为精华评论，回帖，默认不是为 0
    private String  user_name;
}

