package com.sc.exam.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BaseBean {
    private String startTimeStr;
    private String endTimeStr;
    private String updateTimeStr;
    private String state;
    private String editor;
    private String valid;
}
