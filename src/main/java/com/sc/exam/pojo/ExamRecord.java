package com.sc.exam.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ExamRecord {
    private Integer id;
    private Integer userid;
    private Integer par_id;
    private Integer sum_score;
    private Timestamp exam_time;
    private Integer usetime;
    private Integer status;
}
