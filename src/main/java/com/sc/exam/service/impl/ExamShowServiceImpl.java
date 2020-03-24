package com.sc.exam.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.dao.IExamDao;
import com.sc.exam.pojo.ExamRecord;
import com.sc.exam.pojo.Paper;
import com.sc.exam.pojo.Rel;
import com.sc.exam.pojo.RelInfo;
import com.sc.exam.service.IExamShowService;
import com.sc.exam.vo.PageTable;
import com.sc.exam.vo.examview.GetExamPaperVo;
import com.sc.exam.vo.examview.HistoryRecordVo;
import com.sc.exam.vo.examview.PaperRecord;
import com.sc.exam.vo.examview.PaperScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ExamShowServiceImpl implements IExamShowService {
    @Autowired
    private IExamDao examDao;

    @Override
    public PageTable<HistoryRecordVo> getExamHistoryRecords(Integer page, Integer limit, Integer userid) {
        List<HistoryRecordVo> res = new ArrayList<>();

        PageHelper.startPage(page,limit);
        List<ExamRecord> recordList = examDao.getExamRecordListByUserId(userid);
        PageInfo<ExamRecord> pageInfo = new PageInfo<>(recordList);

        for (ExamRecord examRecord : recordList) {
            Integer par_id = examRecord.getPar_id();
            Paper paper = examDao.getPaperInfoById(par_id);
            List<RelInfo> relInfo = examDao.getRelInfoByRelId(paper.getRel_id());
            Integer sum = 0;
            for (RelInfo info : relInfo) {
                int i = info.getQue_count() * info.getQue_score();
                sum += i;
            }
            Integer usetime = examRecord.getUsetime();
            Integer score = examRecord.getSum_score();
            Integer status = examRecord.getStatus();
            String statusStr = "已审批";
            if(status==0)
            {statusStr = "未审批";}

            HistoryRecordVo historyRecordVo = new HistoryRecordVo(paper, sum, usetime, score, statusStr);
            res.add(historyRecordVo);
        }
        return new PageTable<HistoryRecordVo>(0,"",pageInfo.getTotal(),res);
    }

    @Override
    public PageTable<GetExamPaperVo> getExamPapers(Integer page, Integer limit, Integer userid) {

        PageHelper.startPage(page,limit);
        List<Paper> paperList = examDao.getExamPaperList();
        PageInfo<Paper> pageInfo = new PageInfo<>(paperList);

        List<GetExamPaperVo> examPaperVos = new ArrayList<>();

        for (Paper paper : paperList) {
            Integer sum = 0;
            List<RelInfo> relInfo = examDao.getRelInfoByRelId(paper.getRel_id());
            for (RelInfo info : relInfo) {
                int i = info.getQue_count() * info.getQue_score();
                sum += i;
            }
            String typeName = examDao.getSubNameById(paper.getSub_id());
            examPaperVos.add(new GetExamPaperVo(paper,typeName,sum));
        }
        return new PageTable<GetExamPaperVo>(0,"",pageInfo.getTotal(),examPaperVos);
    }

    @Override
    public PageTable getPaperList(Integer page, Integer limit) {

        PageHelper.startPage(page,limit);
        List<Paper> paperList = examDao.getExamPaperList();
        PageInfo<Paper> pageInfo = new PageInfo<>(paperList);

//        定义一个 PaperRecord 列表
        List<PaperRecord> paperRecordList = new ArrayList<>();
        for (Paper paper : paperList) {
            String subName = examDao.getSubNameById(paper.getSub_id());
            List<ExamRecord> examRecords = examDao.getExamRecordListByParId(paper.getPar_id());
            Integer examCount = examRecords.size();
            Integer sum =0;

            for (ExamRecord examRecord : examRecords) {
                Integer userUcore = examRecord.getSum_score();
                sum += userUcore;
            }
//            如果除数为0
            Double avgScore;
            if(examCount==0||examCount==null){
                avgScore = 0.0;
            }else{
                avgScore = (double)sum/examCount;
            }


            String relName = examDao.getRelNameByRelId(paper.getRel_id());

            List<RelInfo> relInfoList = examDao.getRelInfoByRelId(paper.getRel_id());

            Integer score = 0;
            for (RelInfo relInfo : relInfoList) {
                score+=relInfo.getQue_score() * relInfo.getQue_count();
            }

            PaperRecord paperRecord = new PaperRecord(paper.getPar_id(),paper.getPar_name(),
                    paper.getTest_start_time(),paper.getTest_end_time(),paper.getTest_length_time()
                    , relName, subName, examCount, avgScore, score);

            paperRecordList.add(paperRecord);
        }

        PageTable<PaperRecord> paperRecordPageTable = new PageTable<>(0, "", pageInfo.getTotal(), paperRecordList);
        return paperRecordPageTable;
    }


    @Override
    public PageTable getPaperListByName(Integer page,Integer limit,String par_name){
        if (par_name==""||par_name==null){
            par_name="%%";
        }else {
            par_name = "%"+par_name+"%";
        }
        PageHelper.startPage(page,limit);
        List<Paper> paperList = examDao.getExamPaperListByName(par_name);
        PageInfo<Paper> pageInfo = new PageInfo<>(paperList);

        List<PaperRecord> paperRecordList = new ArrayList<>();
        for (Paper paper : paperList) {
            String subName = examDao.getSubNameById(paper.getSub_id());
            List<ExamRecord> examRecords = examDao.getExamRecordListByParId(paper.getPar_id());
            Integer examCount = examRecords.size();
            Integer sum =0;

            for (ExamRecord examRecord : examRecords) {
                Integer userUcore = examRecord.getSum_score();
                sum += userUcore;
            }
//            如果除数为0
            Double avgScore;
            if(examCount==0||examCount==null){
                avgScore = 0.0;
            }else{
                avgScore = (double)sum/examCount;
            }


            String relName = examDao.getRelNameByRelId(paper.getRel_id());

            List<RelInfo> relInfoList = examDao.getRelInfoByRelId(paper.getRel_id());

            Integer score = 0;
            for (RelInfo relInfo : relInfoList) {
                score+=relInfo.getQue_score() * relInfo.getQue_count();
            }

            PaperRecord paperRecord = new PaperRecord(paper.getPar_id(),paper.getPar_name(),
                    paper.getTest_start_time(),paper.getTest_end_time(),paper.getTest_length_time()
                    , relName, subName, examCount, avgScore, score);

            paperRecordList.add(paperRecord);
        }

        PageTable<PaperRecord> paperRecordPageTable = new PageTable<>(0, "", pageInfo.getTotal(), paperRecordList);
        return paperRecordPageTable;
    }
//    getPaperListByName

    @Override
    public PageTable getUserPaperScore(Integer page, Integer limit, Integer par_id) {

        PageHelper.startPage(page,limit);
        List<ExamRecord> examRecordList = examDao.getExamRecordListByParId(par_id);
        PageInfo<ExamRecord> pageInfo = new PageInfo<>(examRecordList);

        Paper paper = examDao.getPaperInfoById(par_id);

        List<PaperScore> paperScoreList = new ArrayList<>();

        for (ExamRecord examRecord : examRecordList) {
            Integer userid = examRecord.getUserid();
            String account = examDao.getUserAccountByUserId(userid);
            PaperScore paperScore = new PaperScore(par_id, paper.getPar_name(), userid, account, examRecord.getSum_score(),
                    examRecord.getExam_time(), examRecord.getUsetime(), examRecord.getStatus());

            paperScoreList.add(paperScore);
        }
        return new PageTable<PaperScore>(0,"",pageInfo.getTotal(),paperScoreList);
    }

    @Override
    public PageTable getUserPaperScoreByOther(Integer page, Integer limit, Integer par_id, Integer startScore, Integer endScore, Integer status) {

        PageHelper.startPage(page,limit);
        List<ExamRecord> examRecordList = new ArrayList<>();
        if(status!=1&&status!=0){
            examRecordList  = examDao.getExamRecordListByParIdByOther(par_id,startScore,endScore);
        }else{
            examRecordList  = examDao.getExamRecordListByParIdWithStatus(par_id,startScore,endScore,status);
        }
        PageInfo<ExamRecord> pageInfo = new PageInfo<>(examRecordList);

        Paper paper = examDao.getPaperInfoById(par_id);

        List<PaperScore> paperScoreList = new ArrayList<>();

        for (ExamRecord examRecord : examRecordList) {
            Integer userid = examRecord.getUserid();
            String account = examDao.getUserAccountByUserId(userid);
            PaperScore paperScore = new PaperScore(par_id, paper.getPar_name(), userid, account, examRecord.getSum_score(),
                    examRecord.getExam_time(), examRecord.getUsetime(), examRecord.getStatus());

            paperScoreList.add(paperScore);
        }
        return new PageTable<PaperScore>(0,"",pageInfo.getTotal(),paperScoreList);
    }


    @Override
    public PageTable getRelList(Integer page, Integer limit) {

        PageHelper.startPage(page,limit);
        List<Rel> relList = examDao.getRelList();
        PageInfo<Rel> pageInfo = new PageInfo<>(relList);
        return new PageTable(0,"",pageInfo.getTotal(),relList);
    }


}
