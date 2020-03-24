package com.sc.exam.controller;


import com.sc.exam.service.IExamShowService;
import com.sc.exam.vo.PageTable;
import com.sc.exam.vo.examview.PaperRecord;
import com.sc.exam.vo.examview.PaperScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/admin/")
public class ExamAdminHandler {

    @Autowired
    private IExamShowService examShowService;

    @RequestMapping("PaperList")
    protected PageTable<PaperRecord> getPaperList(
            @RequestParam(defaultValue = "1",required = false) Integer page,
            @RequestParam(defaultValue = "1",required = false) Integer limit,
            HttpSession session){

        PageTable paperList = examShowService.getPaperList(page, limit);
        return paperList;
    }

    @RequestMapping("PaperListByName")
    protected PageTable<PaperRecord> getPaperListByName(
            @RequestParam(defaultValue = "1",required = false) Integer page,
            @RequestParam(defaultValue = "3",required = false) Integer limit,
            @RequestParam(defaultValue = "",required = false)String par_name){
        PageTable paperList = examShowService.getPaperListByName(page, limit,par_name);
        return paperList;
    }

    @RequestMapping("UserPaperScore")
    protected PageTable<PaperScore> getUserPaperScore(
            @RequestParam(defaultValue = "1",required = false) Integer page,
            @RequestParam(defaultValue = "1",required = false) Integer limit,
            Integer par_id,
            HttpSession session){

        PageTable paperList = examShowService.getUserPaperScore(page,limit,par_id);
        return paperList;
    }
    @RequestMapping("UserPaperScoreByOther")
    protected PageTable<PaperScore> getUserPaperScoreByOther(
            @RequestParam(defaultValue = "1",required = false) Integer page,
            @RequestParam(defaultValue = "1",required = false) Integer limit,
            Integer par_id,
            @RequestParam(defaultValue = "0",required = false)Integer startScore,
            @RequestParam(defaultValue = "1000",required = false)Integer endScore,
            @RequestParam(required = false)Integer status
             ){
        PageTable paperList = examShowService.getUserPaperScoreByOther(page,limit,par_id,startScore,endScore,status);
        return paperList;
    }

    @RequestMapping("getRelList")
    protected PageTable getRelList(
            @RequestParam(defaultValue = "1",required = false) Integer page,
            @RequestParam(defaultValue = "1",required = false) Integer limit){
        return  examShowService.getRelList(page,limit);
    }


}
