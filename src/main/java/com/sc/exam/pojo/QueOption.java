package com.sc.exam.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QueOption {
    private Integer id;
    private Integer que_id;
    private String statement;
    private String que_op;
    private Integer status;
}
