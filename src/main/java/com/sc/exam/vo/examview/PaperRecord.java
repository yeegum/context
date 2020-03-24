package com.sc.exam.vo.examview;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.sc.exam.pojo.Paper;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PaperRecord {
//    private Paper paper;
    /*par_id
    * par_name
    * paper.test_start_time
    * paper.test_end_time
    * paper.test_length_time*/
    private Integer par_id;
    private String Par_name;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Timestamp test_start_time;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Timestamp test_end_time;
    private Integer test_length_time;
    private String relName;
    private String subName;
    private Integer examCount;
    private Double avgScore;
    private Integer score;
}
