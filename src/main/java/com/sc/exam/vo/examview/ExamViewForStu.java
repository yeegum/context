package com.sc.exam.vo.examview;

import com.sc.exam.pojo.ExamRecord;
import com.sc.exam.pojo.Paper;
import com.sc.exam.pojo.UserAnswer;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ExamViewForStu {
//    private List<>
    /**
     * 1:试卷 信息
     * 2:模块 信息
     * 3:QueWithOption 类
     * 4:用户 答案表
     * 5:考试 记录表
     */
    private ExamRecord examRecord;
    private PaperInfo paperInfo;
    private List<QueWithOption> queWithOptionList;
    private List<UserAnswer> userAnswerList;

}
