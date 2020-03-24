package com.sc.exam.service;

import com.sc.exam.dao.IExamDao;
import com.sc.exam.vo.PageTable;
import org.springframework.beans.factory.annotation.Autowired;

public interface IExamShowService {
//    @Autowired
    PageTable getExamHistoryRecords(Integer page, Integer limit, Integer userid);
    PageTable getExamPapers(Integer page, Integer limit, Integer userid);

    PageTable getPaperList(Integer page, Integer limit);

    PageTable getPaperListByName(Integer page,Integer limit,String par_name);

    PageTable getUserPaperScore(Integer page, Integer limit, Integer par_id);

    PageTable getUserPaperScoreByOther(Integer page, Integer limit, Integer par_id,
                Integer startScore, Integer endScore,Integer status);

    PageTable getRelList(Integer page, Integer limit);
}
