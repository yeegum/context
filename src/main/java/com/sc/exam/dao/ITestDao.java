package com.sc.exam.dao;


import com.sc.exam.pojo.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public interface ITestDao {
    //增加试卷记录
    int addPaper(Paper paper);
    //获得所有科目
    List<Sub> getSubs();
    //获得所有模块
    List<Rel> getRels();
    //根据模块ID查找题型和数量
    List<RelInfo> getRelinfoById(@Param("relid") Integer rel_id);
    //根据名称查找试卷ID
    Paper getPaperByname(@Param("name") String par_name);
    //根据题型数量和科目ID随机分配题目
    List<Que> getQues(@Param("subid") Integer sub_id
            , @Param("type") Integer que_type_id, @Param("amount") Integer amount);
    //将分配的题目插入试卷题目表
    int addParQues(List<ParQue> ques);
    //获得问题表
    List<Que> getQueList();
    //获得所有题型
    List<QueType> getTypeList();
    //添加题目
    int addQue(Que que);
    //添加问题选项
    int addOption(List<QueOption> ops);
    //获得最近一次添加的题目
    Que getQue();
    //批量删除题目
    int delQueById(List<Integer> idList);
    //批量删除选项
    int delOptionByQueId(List<Integer> idList);
    //根据ID获得题目信息
    Que getQueById(Integer id);
    //修改题目
    int queChange(Que q);
    //获得选项信息
    List<QueOption> getOptionsByQueId(Integer que_id);
    //修改选项信息
    int altOps(List<QueOption> ops);
    //删除试卷
    int delPaper(Integer par_id);
    //删除试卷对应的题目信息
    int delPRQ(Integer par_id);
    //修改试卷
    int altPaper(Paper paper);
    //发布试卷
    int issue(@Param("par_id") Integer par_id, @Param("status") Integer s);
    //获得试卷列表
    List<Paper> getPapers();
    //根据Id获得科目名称
    String getSubName(Integer id);
    //根据ID获得模块名
    String getRelName(Integer id);
    //查询问题
    List<Que> queSearch(@Param("sub") Integer sub_id, @Param("ask") String ask);
}