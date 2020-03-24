package com.sc.exam.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Blob;
import java.sql.Timestamp;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User extends BaseBean{
    private Integer userid;
    private String account;
    private String password;
    private String nickname;
    private Integer sex ;  //0男  1女
    private Integer age;
    private String phone;
    private String email;
    private Integer integral; //用户积分
    private String faceimg;//修改为String
    private String introduce; //简介
    private String address;
    private String ip;
//    private Timestamp registertime;
//    private Timestamp lastlogintime;
//    private Timestamp bithday;
    @DateTimeFormat (pattern="yyyy-MM-dd")
    private String registertime;
    private Timestamp lastlogintime;
    private Timestamp birthday;
    private Integer status;   //判断是否禁用状态 默认1

    private List<Role> roles;
    private List<Modular> modulars;
    private String rolename;
    private Integer roleId;
    private Integer[] roleIds;
}
