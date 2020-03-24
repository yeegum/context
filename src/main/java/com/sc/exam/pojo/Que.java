package com.sc.exam.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Que {
    private Integer que_id;
    private Integer sub_id;
    private Integer que_type_id;
    private String right_ask;
    private String ask;
    private String analysis;
}
