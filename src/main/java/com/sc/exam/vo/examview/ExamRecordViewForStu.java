package com.sc.exam.vo.examview;

import com.sc.exam.pojo.ExamRecord;
import com.sc.exam.pojo.QueAnalysis;
import com.sc.exam.pojo.UserAnswer;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ExamRecordViewForStu{
    private ExamRecord examRecord;
    private PaperInfo paperInfo;
    private List<QueWithOption> queWithOptionList;
    private List<UserAnswer> userAnswerList;
//    private List<QueAnalysis> analysisList;
}
