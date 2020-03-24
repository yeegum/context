package com.sc.exam.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Role {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer roleid;
    private String rolename;
    private String roleMname;
    private List<Modular> modularList;
    private Integer midOne;
    private Integer[] mids;

}
