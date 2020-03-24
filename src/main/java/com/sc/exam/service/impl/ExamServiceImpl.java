package com.sc.exam.service.impl;

import com.sc.exam.dao.IExamDao;
import com.sc.exam.pojo.*;
import com.sc.exam.service.IExamService;
import com.sc.exam.vo.ViewMsg;
import com.sc.exam.vo.examview.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;

import java.sql.Timestamp;
import java.util.*;

@Service
public class ExamServiceImpl implements IExamService {
    @Autowired
    private IExamDao examDao;
    @Override
    public ExamViewForStu getExamViewForStu(Integer userid, Integer par_id) {

/*        //得到试卷信息
        Paper paper = examDao.getPaperInfoById(par_id);

        //得到题目ID列表
        List<Integer> queIdList = examDao.getQueIdListByParId(par_id);
        //得到题目信息列表
        List<Que> queList = new ArrayList<>();
        for (Integer queid : queIdList) {
            Que question = examDao.getQueListByQueId(queid);
            queList.add(question);
        }
        //定义 题目-选项 列表
        List<QueWithOption> queWithOptionList = new ArrayList<>();
        for (Que que : queList) {
            List<QueOption> options = examDao.getOptionsByQueId(que.getQue_id());
             //添加到题目-选项列表
            queWithOptionList.add(new QueWithOption(que, options));
        }

        //获得 通过模板 题目类型 分数
        List<RelInfo> relInfos = examDao.getRelInfoByRelId(paper.getRel_id());

        //定义 模板信息视图类
        List<RelInfoVo> relInfoVoList = new ArrayList<>();
        //遍历模板 得到typeid 对应的 类型名 存到模板信息视图类
        for (RelInfo relInfo : relInfos) {
            String typeName = examDao.getTypeNameByRelId(relInfo.getQue_type_id());
            relInfoVoList.add(new RelInfoVo(typeName,relInfo));
        }

        //得到用户本次考试的记录  如果没有记录则添加记录
        ExamRecord record = examDao.getExamRecordByUserIdAndParId(userid, par_id);
        if(record==null){
            //增加本次考试的考试记录
            examDao.insertExamRecordByUserIdAndParId(userid,par_id);
//           重新获取考试记录获取 用于传输数据
            record =examDao.getExamRecordByUserIdAndParId(userid, par_id);

            //增加 用户的答题记录 初始化为空 状态未答题
            List<UserAnswer> userAnswerList = new ArrayList<>();
            for (Que que : queList) {
                UserAnswer userAnswer = new UserAnswer();
                String right_ask = que.getRight_ask();
                Integer que_id = que.getQue_id();
                userAnswer.setUserid(userid);
                userAnswer.setQue_id(que_id);
                userAnswer.setPar_id(par_id);
//                userAnswer.setAsk("");
                userAnswer.setRight_ask(right_ask);
                userAnswer.setScore(0);
                userAnswer.setStatus(0);
                userAnswerList.add(userAnswer);
            }
            examDao.insertListToUserAnswer(userAnswerList);
        }
        //获得 用户的答题 列表
        List<UserAnswer> userAnswerList = examDao.getUserAnswerList(par_id, userid);

        //把 试卷信息 模板信息 分数信息 包装为一个类
        PaperInfo paperInfo = new PaperInfo(paper, relInfoVoList);
//        PaperWithRelInfo paperWithRelInfo = new PaperWithRelInfo(paperInfo,typeScoreMap,relInfos);

        //把所有信息 包装成一个 视图类用来传递给jsp
        ExamViewForStu view =
                new ExamViewForStu(record,paperInfo,queWithOptionList,userAnswerList);
        return view;*/
        return null;
    }

    @Override
    public ExamRecordViewForStu geExamRecordViewForStu(Integer userid, Integer par_id) {
        //得到试卷信息
        Paper paper = examDao.getPaperInfoById(par_id);
        //得到题目ID列表
        List<Integer> queIdList = examDao.getQueIdListByParId(par_id);
        //得到题目信息列表
        List<Que> queList = new ArrayList<>();
        for (Integer queid : queIdList) {
            Que question = examDao.getQueListByQueId(queid);
            queList.add(question);
        }
        //定义 题目-选项 列表
        List<QueWithOption> queWithOptionList = new ArrayList<>();
        //定义 题目-解析列表
//        List<QueAnalysis> queAnalysisList = new ArrayList<>();
        for (Que que : queList) {
            List<QueOption> options = examDao.getOptionsByQueId(que.getQue_id());
            QueAnalysis analysis = examDao.getAnalysisByQueId(que.getQue_id());
            //添加到题目-选项列表
            queWithOptionList.add(new QueWithOption(que, options));
            //添加到题目-解析列表
//            queAnalysisList.add(analysis);

        }
        //获得 通过模板 题目类型 分数
        List<RelInfo> relInfos = examDao.getRelInfoByRelId(paper.getRel_id());

        //定义 模板信息视图类
        List<RelInfoVo> relInfoVoList = new ArrayList<>();
        //遍历模板 得到typeid 对应的 类型名 存到模板信息视图类
        for (RelInfo relInfo : relInfos) {
            String typeName = examDao.getTypeNameByRelId(relInfo.getQue_type_id());
            relInfoVoList.add(new RelInfoVo(typeName,relInfo));
        }

        //得到用户本次考试的记录  如果没有记录则添加记录
        ExamRecord record = examDao.getExamRecordByUserIdAndParId(userid, par_id);
        if(record==null){
            //增加本次考试的考试记录
            examDao.insertExamRecordByUserIdAndParId(userid,par_id);
//           重新获取考试记录获取 用于传输数据
            record =examDao.getExamRecordByUserIdAndParId(userid, par_id);

            //增加 用户的答题记录 初始化为空 状态未答题
            List<UserAnswer> userAnswerList = new ArrayList<>();
            for (Que que : queList) {
                UserAnswer userAnswer = new UserAnswer();
                String right_ask = que.getRight_ask();
                Integer que_id = que.getQue_id();
                userAnswer.setUserid(userid);
                userAnswer.setQue_id(que_id);
                userAnswer.setPar_id(par_id);
//                userAnswer.setAsk("");
                userAnswer.setRight_ask(right_ask);
                userAnswer.setScore(0);
                userAnswer.setStatus(0);
                userAnswerList.add(userAnswer);
            }
            examDao.insertListToUserAnswer(userAnswerList);
        }
        //获得 用户的答题 列表
        List<UserAnswer> userAnswerList = examDao.getUserAnswerList(par_id, userid);

        //把 试卷信息 模板信息 分数信息 包装为一个类
        PaperInfo paperInfo = new PaperInfo(paper, relInfoVoList);
//        PaperWithRelInfo paperWithRelInfo = new PaperWithRelInfo(paperInfo,typeScoreMap,relInfos);

        //把所有信息 包装成一个 视图类用来传递给jsp
        ExamRecordViewForStu view =
                new ExamRecordViewForStu(record,paperInfo,queWithOptionList,userAnswerList);
        return view;

    }

    //提交试卷事务管理
    @Override
    public ViewMsg handPaper(MultiValueMap<Integer, String> params,Integer userid) {
        System.out.println(params);
        List<String> ps = params.get("par_id");
        String s = ps.get(0);
        int par_id = Integer.parseInt(s);
        params.remove("par_id");
        System.out.println(params);

//        获取每个类型题目的分数
        Paper paper = examDao.getPaperInfoById(par_id);
        List<RelInfo> relList = examDao.getRelInfoByRelId(paper.getRel_id());
        Map<Integer,Integer> relScoreMap = new HashMap<>();
        for (RelInfo relInfo : relList) {
            relScoreMap.put(relInfo.getQue_type_id(),relInfo.getQue_score());
        }
        //得到现在的时间和开始时间的差值
        ExamRecord record = examDao.getExamRecordByUserIdAndParId(userid, par_id);
        long l = System.currentTimeMillis() - record.getExam_time().getTime();
        Integer t = (int)l/(60*1000);
        Integer lengthTime = paper.getTest_length_time();

//        计算客观题总得分
        Iterator<Map.Entry<Integer, List<String>>> itor = params.entrySet().iterator();

        Integer sum_score = sumScore(itor, relScoreMap, par_id, userid);
//        更新考试记录
        examDao.updateOneToExamRecord(sum_score,t<lengthTime?t:lengthTime,userid,par_id);

        ViewMsg viewMsg = new ViewMsg();
        viewMsg.setCode(9901);
        viewMsg.setMsg("客观题得分:"+sum_score);
        return viewMsg;
    }

    @Override
    public void autoHand(MultiValueMap<Integer, String> params, Integer userid) {
        System.out.println(params);
        List<String> ps = params.get("par_id");
        String s = ps.get(0);
        int par_id = Integer.parseInt(s);
        params.remove("par_id");
        System.out.println(params);

//        获取每个类型题目的分数
        Paper paper = examDao.getPaperInfoById(par_id);
        List<RelInfo> relList = examDao.getRelInfoByRelId(paper.getRel_id());
        Map<Integer,Integer> relScoreMap = new HashMap<>();
        for (RelInfo relInfo : relList) {
            relScoreMap.put(relInfo.getQue_type_id(),relInfo.getQue_score());
        }
        //     1   计算客观题总得分 并更新用户题目到数据库中
        Iterator<Map.Entry<Integer, List<String>>> itor = params.entrySet().iterator();
        //     2   计算客观题总得分 并更新用户题目到数据库中
        Integer sum_score = sumScore(itor, relScoreMap, par_id, userid);
    }

    //    开始考试的检查
    @Override
    public ViewMsg examStartCheck(Integer userid, Integer par_id) {
        ViewMsg viewMsg = new ViewMsg();
        viewMsg.setCode(9990);
        viewMsg.setMsg("");

        Paper paper = examDao.getPaperInfoById(par_id);
        Timestamp test_start_time = paper.getTest_start_time();
        Timestamp test_end_time = paper.getTest_end_time();
        if(System.currentTimeMillis()<test_start_time.getTime()){
            viewMsg.setMsg("考试没有开始");
            viewMsg.setCode(9991);
            return viewMsg;
        }
        if(System.currentTimeMillis()>test_end_time.getTime()){
            viewMsg.setMsg("考试已经结束");
            viewMsg.setCode(9991);
            return viewMsg;
        }
        //得到用户本次考试的记录
        ExamRecord record = examDao.getExamRecordByUserIdAndParId(userid, par_id);
        if(record!=null){
            Integer usetime = record.getUsetime();
//        System.out.println(usetime);
            if(usetime!=null){
                viewMsg.setMsg("您已交卷，无需再次作答");
                viewMsg.setCode(9991);
                return viewMsg;
            }

        }
        return viewMsg;
    }

//    老师查看试卷
    @Override
    public ExamRecordViewForStu geExamRecordViewForTea(Integer par_id) {
        //得到试卷信息
        Paper paper = examDao.getPaperInfoById(par_id);
        //得到题目ID列表
        List<Integer> queIdList = examDao.getQueIdListByParId(par_id);
        //得到题目信息列表
        List<Que> queList = new ArrayList<>();
        for (Integer queid : queIdList) {
            Que question = examDao.getQueListByQueId(queid);
            queList.add(question);
        }
        //定义 题目-选项 列表
        List<QueWithOption> queWithOptionList = new ArrayList<>();
        //定义 题目-解析列表
//        List<QueAnalysis> queAnalysisList = new ArrayList<>();
        for (Que que : queList) {
            List<QueOption> options = examDao.getOptionsByQueId(que.getQue_id());
            QueAnalysis analysis = examDao.getAnalysisByQueId(que.getQue_id());
            //添加到题目-选项列表
            queWithOptionList.add(new QueWithOption(que, options));
            //添加到题目-解析列表
//            queAnalysisList.add(analysis);

        }
        //获得 通过模板 题目类型 分数
        List<RelInfo> relInfos = examDao.getRelInfoByRelId(paper.getRel_id());

        //定义 模板信息视图类
        List<RelInfoVo> relInfoVoList = new ArrayList<>();
        //遍历模板 得到typeid 对应的 类型名 存到模板信息视图类
        for (RelInfo relInfo : relInfos) {
            String typeName = examDao.getTypeNameByRelId(relInfo.getQue_type_id());
            relInfoVoList.add(new RelInfoVo(typeName,relInfo));
        }



        //把 试卷信息 模板信息 分数信息 包装为一个类
        PaperInfo paperInfo = new PaperInfo(paper, relInfoVoList);
//        PaperWithRelInfo paperWithRelInfo = new PaperWithRelInfo(paperInfo,typeScoreMap,relInfos);

        //把所有信息 包装成一个 视图类用来传递给jsp
        ExamRecordViewForStu view =
                new ExamRecordViewForStu(null,paperInfo,queWithOptionList,null);
        return view;
    }

//  审批试卷
    @Override
    public ViewMsg correctionPaper(Map<String,Integer> params) {
        ViewMsg viewMsg = new ViewMsg();
        viewMsg.setMsg("审批成功");
        viewMsg.setCode(9800);
//        examDao.updateOneToUserAnswer()
        Object par_idObj = params.get("par_id");
        if(par_idObj==null){
            viewMsg.setCode(9811);
            viewMsg.setMsg("未知错误");
            return viewMsg;
        }
        Integer par_id = Integer.valueOf(String.valueOf(par_idObj));
        params.remove("par_id");
        Object useridObj = params.get("userid");
        if(useridObj==null){
            viewMsg.setCode(9812);
            viewMsg.setMsg("未知错误");
            return viewMsg;
        }
        Integer userid = Integer.valueOf(String.valueOf(useridObj));
        params.remove("userid");

        Iterator<Map.Entry<String, Integer>> itor = params.entrySet().iterator();
        while (itor.hasNext()) {
            /*更新 用户答案表分数score = #{score}*/
            Map.Entry<String, Integer> e = itor.next();
            String key = e.getKey();
            Integer que_id = Integer.valueOf(key);
            Integer score =Integer.valueOf(String.valueOf(e.getValue()));
            examDao.updateScoreToUserAnswer(score,userid,par_id,que_id);
        }
        //    更新 试卷记录表 分数
        examDao.updateExamRecordScore(examDao.getSumScoreByUserIdAndParId(userid,par_id),userid,par_id);
        //    更新 试卷记录表 状态
        examDao.updateExamRecordStatus(1,userid,par_id);

        return viewMsg;
    }

    @Override
    public RelAllInfo editRelInfo(Integer rel_id) {
        List<RelInfo> relInfoList = examDao.getRelInfoByRelId(rel_id);

        List<RelInfoVo> relInfoVoList = new ArrayList<>();
        for (RelInfo relInfo : relInfoList) {
            String typeName = examDao.getTypeNameByRelId(relInfo.getQue_type_id());
            RelInfoVo relInfoVo = new RelInfoVo(typeName, relInfo);
            relInfoVoList.add(relInfoVo);
        }
        String relName = examDao.getRelNameByRelId(rel_id);

        return new RelAllInfo(rel_id,relName,relInfoVoList);
    }

    @Override
    public ViewMsg updateRelNameByRelId(String rel_name, Integer rel_id) {
        ViewMsg viewMsg = new ViewMsg();
        viewMsg.setMsg("修改成功");
        if(rel_id==null||rel_name==null){
            viewMsg.setMsg("删除失败");
            return viewMsg;
        }
        Integer integer = examDao.updateRelNameByRelId(rel_name, rel_id);
        if(integer==0||integer==null){
            viewMsg.setMsg("修改失败");
            return viewMsg;
        }
        return viewMsg;
    }

    @Override
    public ViewMsg delRel(Integer rel_id) {
        ViewMsg viewMsg = new ViewMsg();
        viewMsg.setMsg("删除成功");
        if(rel_id==null){
            viewMsg.setMsg("删除失败");
            return viewMsg;
        }
        Integer integer = examDao.delRelByRelId(rel_id);
        if(integer==0||integer==null){
            viewMsg.setMsg("删除失败");
            return viewMsg;
        }
        integer = examDao.delRelInfo(rel_id);
        if(integer==0||integer==null){
            viewMsg.setMsg("删除失败");
            return viewMsg;
        }
        return viewMsg;
    }

    @Override
    public ViewMsg updateRelInfoById(MultiValueMap<Integer,Integer> map) {
        ViewMsg viewMsg = new ViewMsg();
        viewMsg.setMsg("修改成功");
        Iterator<Map.Entry<Integer, List<Integer>>> itor = map.entrySet().iterator();
        while (itor.hasNext()) {

            Map.Entry<Integer, List<Integer>> e = itor.next();

            Integer id =Integer.valueOf(String.valueOf(e.getKey()));

            List<Integer> value = e.getValue();
            Integer que_count =Integer.valueOf(String.valueOf(value.get(0)));
            Integer que_score =Integer.valueOf(String.valueOf(value.get(1)));

            examDao.updateRelInfoById(que_count,que_score,id);
        }

        return viewMsg;
    }

    @Override
    public List<Sub> getSubList() {
        return examDao.getSubList();
    }

    @Override
    public ViewMsg insertRel(MultiValueMap<String, String> map) {
        List<String> rel_names = map.get("rel_name");
        String rel_name = rel_names.get(0);
        map.remove("rel_name");
        System.out.println(rel_name);
        examDao.insertRel(rel_name);

        Integer rel_id = examDao.getRelIdByRelName(rel_name);
        System.out.println(rel_id);
        List<String> sub = map.get("sub");
        Integer sub_id = Integer.valueOf(sub.get(0));
        map.remove("sub");
        Integer count;
        Integer score;
        RelInfo relInfo = new RelInfo();
        List<RelInfo> relInfoList = new ArrayList<>();

        List<String> radioT = map.get("radioT");
        count = Integer.valueOf(radioT.get(0));
        score = Integer.valueOf(radioT.get(1));
        relInfo.setRel_id(rel_id);
        relInfo.setQue_type_id(1);
        relInfo.setQue_count(count);
        relInfo.setQue_score(score);
        relInfoList.add(relInfo);

        relInfo = new RelInfo();
        List<String> checkboxT = map.get("checkboxT");
        count = Integer.valueOf(checkboxT.get(0));
        score = Integer.valueOf(checkboxT.get(1));
        relInfo.setRel_id(rel_id);
        relInfo.setQue_type_id(2);
        relInfo.setQue_count(count);
        relInfo.setQue_score(score);
        relInfoList.add(relInfo);

        relInfo = new RelInfo();
        List<String> writeT = map.get("writeT");
        count = Integer.valueOf(writeT.get(0));
        score = Integer.valueOf(writeT.get(1));
        relInfo.setRel_id(rel_id);
        relInfo.setQue_type_id(3);
        relInfo.setQue_count(count);
        relInfo.setQue_score(score);
        relInfoList.add(relInfo);

        examDao.insertRelInfoList(relInfoList);

        ViewMsg viewMsg = new ViewMsg();
        viewMsg.setMsg("模板添加成功");
        return viewMsg;
    }


    //    用于判断多选 是否完全正确的函数
    private boolean checkboxIsRight(List<String> value,String rightStr){
        String[] right = rightStr.split(",");
        if(right.length!=value.size()){
            return false;
        }
        for (String s : value) {
            if(rightStr.indexOf(s)==-1){
                return false;
            }
        }
        return true;
    }
//    计算得分
    private Integer sumScore(
            Iterator<Map.Entry<Integer, List<String>>> itor,
            Map<Integer,Integer> relScoreMap,int par_id,Integer userid){
        Integer sum_score = 0;
        while (itor.hasNext()) {
            Map.Entry<Integer, List<String>> e = itor.next();
//            Integer que_id = e.getKey();
            Object key = e.getKey();
            Integer que_id = Integer.parseInt(String.valueOf(key));
            System.out.println("-----------------");
            System.out.println(que_id);
            List<String> value = e.getValue();
            Que que = examDao.getQueListByQueId(que_id);
            Integer type_id = que.getQue_type_id();

            UserAnswer userAnswer = new UserAnswer();

            userAnswer.setRight_ask(que.getRight_ask());
            userAnswer.setStatus(1);
            userAnswer.setPar_id(par_id);
            userAnswer.setQue_id(que_id);
            userAnswer.setUserid(userid);
            userAnswer.setScore(0);

            switch (type_id){
                case 1:
                    String ask = value.get(0);
                    if(ask.equalsIgnoreCase(que.getRight_ask())){
                        System.out.println("单选题 对了"+ask+"得分："+relScoreMap.get(1));
                        userAnswer.setScore(relScoreMap.get(1));
                        sum_score+=relScoreMap.get(1);
                    }
                    userAnswer.setAsk(ask);
                    break;
                case 2:
                    if(checkboxIsRight(value,que.getRight_ask())){
                        System.out.println("多选题对了"+value+"得分："+relScoreMap.get(2));
                        userAnswer.setScore(relScoreMap.get(2));

                        sum_score+=relScoreMap.get(2);
                    }
                    StringBuffer asks = new StringBuffer();
                    for (String s1 : value) {
                        asks.append(s1+",");
                    }
                    asks.deleteCharAt(asks.length() - 1);
                    userAnswer.setAsk(asks.toString());
                    break;
                default:
                    userAnswer.setAsk(value.get(0));
                    break;
            }
            //更新到 用户答案表中
            examDao.updateOneToUserAnswer(userAnswer);
            System.out.println("-------------------");

        }
        System.out.println("总得分"+sum_score);
        return sum_score;
    }



}
