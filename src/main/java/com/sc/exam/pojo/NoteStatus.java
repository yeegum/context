package com.sc.exam.pojo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoteStatus {

    //状态Id
    private int sid;

    //状态名
    private String sname;
}
