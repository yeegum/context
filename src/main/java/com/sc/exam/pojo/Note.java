package com.sc.exam.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class Note {

    private int nid;

    private String title;

    private String path;

    private int userid;

    private Timestamp subtime;

    private int tid;

    private int sid;

    private int times;

    private User user;

    private Notetype notetype;

    private NoteStatus noteStatus;
}
