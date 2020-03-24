package com.sc.exam.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class PageTable<T> {
    private int code;
    private String msg;
    private long count;
    private List<T> data;
}
