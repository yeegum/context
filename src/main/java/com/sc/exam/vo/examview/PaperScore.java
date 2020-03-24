package com.sc.exam.vo.examview;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PaperScore {
    private Integer par_id;
    private String par_name;
    private Integer userid;
    private String account;
    private Integer sum_score;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Timestamp exam_time;
    private Integer usetime;
    private Integer status;
}
