package com.sc.exam.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RegUser {
    private String phone;
    private String account;
    private String password;
    private String ip;
    private Integer code;
}
