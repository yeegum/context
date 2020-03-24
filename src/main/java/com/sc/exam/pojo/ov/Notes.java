package com.sc.exam.pojo.ov;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notes {

    private int nid;

    private String title;

    private String nickname;


    private String tname;

    private String path;

    private Timestamp subtime;

    private int sid;

    private String sname;

    private int times;

}
