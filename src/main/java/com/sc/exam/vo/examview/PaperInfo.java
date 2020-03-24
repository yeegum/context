package com.sc.exam.vo.examview;

import com.sc.exam.pojo.Paper;
import com.sc.exam.pojo.RelInfo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PaperInfo {
    private Paper paper;  //试卷信息
    private List<RelInfoVo> relList; //模板列表
}
