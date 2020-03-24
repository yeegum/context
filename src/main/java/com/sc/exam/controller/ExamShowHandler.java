package com.sc.exam.controller;


import com.sc.exam.pojo.User;
import com.sc.exam.service.IExamService;
import com.sc.exam.service.IExamShowService;
import com.sc.exam.vo.PageTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/show/")
public class ExamShowHandler {
    @Autowired
    private IExamService examService;

    @Autowired
    private IExamShowService showService;
    @RequestMapping("historyRecords")
    @ResponseBody
    protected PageTable getExamHistoryRecords(
            @RequestParam(defaultValue = "1",required = false) Integer page,
            @RequestParam(defaultValue = "1",required = false) Integer limit,
            HttpSession session
    ){
        User user = (User) session.getAttribute("user");
        if (user==null){
            return new PageTable(0,"",0,null);
        }
        PageTable examHistoryRecords = showService.getExamHistoryRecords(page, limit, user.getUserid());
        return  examHistoryRecords;
    }

    @RequestMapping("getExamPapers")
    @ResponseBody
    protected PageTable getExamPapers(
            @RequestParam(defaultValue = "1",required = false) Integer page,
            @RequestParam(defaultValue = "1",required = false) Integer limit,
            HttpSession session
    ){
        User user = (User) session.getAttribute("user");
        if (user==null){
            return new PageTable(0,"",0,null);
        }
        PageTable examPapers = showService.getExamPapers(page, limit, user.getUserid());
        return  examPapers;
    }
}
