package com.sc.exam.vo.examview;

import com.sc.exam.pojo.ExamRecord;
import com.sc.exam.pojo.Paper;
import com.sc.exam.pojo.RelInfo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class HistoryRecordVo {
    private Paper paper;
    private Integer allScore;
    private Integer usetime;
    private Integer score;
    private String status;
}
