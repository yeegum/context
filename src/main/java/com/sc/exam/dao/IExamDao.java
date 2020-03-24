package com.sc.exam.dao;

import com.sc.exam.pojo.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IExamDao {
    /**
     * 以下方法用于进入考试时初始化
     */
//    根据试卷id 查找试卷
    Paper getPaperInfoById(Integer par_id);
//    根据模板id 查找 每个模板的分数
    List<RelInfo> getRelInfoByRelId(Integer rel_id);
//    根据模板id 查找 每个模板的类型名
    String getTypeNameByRelId(Integer que_type_id);
//    根据试卷id 查找对应生成的题目id
    List<Integer> getQueIdListByParId(Integer par_id);
//    根据题目id查找题目信息
    Que getQueListByQueId(Integer que_id);
//    根据题目，查找对应的选项
    List<QueOption> getOptionsByQueId(Integer que_id);
//    根据userid 和 parid 查找是否有考试记录
    ExamRecord getExamRecordByUserIdAndParId(@Param("userid") Integer userid,@Param("par_id") Integer par_id);
//    没有记录时插入开始记录
    Integer insertExamRecordByUserIdAndParId(@Param("userid") Integer userid,@Param("par_id") Integer par_id);
//    查询用户的答题记录 根据userid，par_id
    List<UserAnswer> getUserAnswerList(@Param("par_id") Integer par_id,@Param("userid") Integer userid);


    /**
     * 答题过程+交卷过程
     */
//    在进入考试时，先插入用户答案表
    Integer insertListToUserAnswer(List<UserAnswer> userAnswerList);
//    提交考试，更新用户答案表
    Integer updateOneToUserAnswer(UserAnswer userAnswer);
//    从用户答案表中算出总分
    Integer getSumScoreByUserIdAndParId(@Param("userid") Integer userid,@Param("par_id") Integer par_id);
//    将计算的总分更新到考试记录表中  同时记录考试用时
    Integer updateOneToExamRecord(
            @Param("sum_score") Integer sum_score,@Param("usetime") Integer usetime,
            @Param("userid") Integer userid,@Param("par_id") Integer par_id);

    //获得用户的考试历史记录
    List<ExamRecord> getExamRecordListByUserId(Integer userid);
    //获得所有已经发布的试卷
    List<Paper> getExamPaperList();
    //获得 已经发布的试卷 按试卷名 模糊查询
    List<Paper> getExamPaperListByName(String par_name);

    String getSubNameById(Integer sub_id);


    /**
     * 考试历史详情需要的 试题解析
     *
     */
    QueAnalysis getAnalysisByQueId(Integer que_id);


    /**
     * admin
     */
//    获取 某个试卷的  考试记录
    List<ExamRecord> getExamRecordListByParId(Integer par_id);

    //    获取 某个试卷的 考试记录 及 模糊查询
    List<ExamRecord> getExamRecordListByParIdByOther(
            @Param("par_id")Integer par_id, @Param("startScore") Integer startScore,
            @Param("endScore") Integer endScore );
//    获取 某个试卷的 考试记录 及 模糊查询 包含 状态
    List<ExamRecord> getExamRecordListByParIdWithStatus(
            @Param("par_id")Integer par_id, @Param("startScore") Integer startScore,
            @Param("endScore") Integer endScore ,@Param("status") Integer status);
//    获取  模板名
    String getRelNameByRelId(Integer rel_Id);
//    获取account
    String getUserAccountByUserId(Integer userid);

//    更新 用户答案表分数score = #{score}
//        where userid=#{userid} and par_id = #{par_id} and que_id = #{que_id};
    Integer updateScoreToUserAnswer(
            @Param("score") Integer score,
            @Param("userid") Integer userid,
            @Param("par_id") Integer par_id,
            @Param("que_id") Integer que_id);
//    更新 试卷记录表 分数
    Integer updateExamRecordScore(
            @Param("sum_score") Integer sum_score,
            @Param("userid") Integer userid,
            @Param("par_id") Integer par_id);
//    更新 试卷记录表 状态
    Integer updateExamRecordStatus(
            @Param("status") Integer status,
            @Param("userid") Integer userid,
            @Param("par_id") Integer par_id);

//    得到 rel列表
    List<Rel> getRelList();
//    更新 relname 更具 relid
    Integer updateRelNameByRelId(@Param("rel_name") String rel_name,
                                 @Param("rel_id")Integer rel_id);
//    删除 rel 表
    Integer delRelByRelId(Integer rel_id);
//    删除  relINfo 表
    Integer delRelInfo(Integer rel_id);
//    更新 relinfo 中的题目数量和题目分数
    Integer updateRelInfoById(
            @Param("que_count") Integer que_count,
            @Param("que_score") Integer que_score,
            @Param("id") Integer id);
//    新增 模块表
    Integer insertRel(String rel_name);
//    得到 模块表 的id 根据 rel_name
    Integer getRelIdByRelName(String rel_name);
//    批量插入 relinfo 记录
    Integer insertRelInfoList(List<RelInfo> list);

    List<Sub> getSubList();



}
