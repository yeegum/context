package com.sc.exam.vo.examview;

import com.sc.exam.pojo.Paper;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class GetExamPaperVo {
    private Paper paper;
    private String subName;
    private Integer allScore;
}
