package com.sc.exam.service;

import com.sc.exam.pojo.ExamRecord;
import com.sc.exam.pojo.Paper;
import com.sc.exam.pojo.Sub;
import com.sc.exam.pojo.UserAnswer;
import com.sc.exam.vo.ViewMsg;
import com.sc.exam.vo.examview.ExamRecordViewForStu;
import com.sc.exam.vo.examview.ExamViewForStu;
import com.sc.exam.vo.examview.RelAllInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.util.MultiValueMap;

import java.util.List;
import java.util.Map;


public interface IExamService {
    ExamViewForStu getExamViewForStu(Integer userid,Integer par_id);

    ExamRecordViewForStu geExamRecordViewForStu(Integer userid,Integer par_id);

    ViewMsg handPaper(MultiValueMap<Integer,String> params,Integer userid);

    void autoHand(MultiValueMap<Integer,String> params,Integer userid);

    ViewMsg examStartCheck(Integer userid,Integer par_id);

//    admin
    ExamRecordViewForStu geExamRecordViewForTea(Integer par_id);

    ViewMsg correctionPaper(Map<String,Integer> params);

    RelAllInfo editRelInfo(Integer rel_id);

    ViewMsg updateRelNameByRelId(String rel_name, Integer rel_id);

    ViewMsg delRel(Integer rel_id);

    //    更新 relinfo 中的题目数量和题目分数
    ViewMsg updateRelInfoById(MultiValueMap<Integer,Integer> map);

    List<Sub> getSubList();

    ViewMsg insertRel(MultiValueMap<String,String> map);

}
