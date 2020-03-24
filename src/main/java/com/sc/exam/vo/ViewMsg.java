package com.sc.exam.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ViewMsg<T> {
    private Integer code;
    private String msg;
    private T data;
}
