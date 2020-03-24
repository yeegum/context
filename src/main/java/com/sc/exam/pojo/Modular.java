package com.sc.exam.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Modular {
    private Integer mid;
    private String mname;
    private String url;
    private Integer fid;
    private String modularrole;
    private List<Role> mroles;
    private Integer[] mroleids;

}
