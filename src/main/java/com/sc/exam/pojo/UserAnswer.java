package com.sc.exam.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserAnswer {
    private Integer id;
    private Integer userid;
    private Integer par_id;
    private Integer que_id;
    private String ask;
    private String right_ask;
    private Integer score;
    private Integer status;
}
