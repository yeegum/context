package com.sc.exam.controller;

import com.sc.exam.pojo.*;
import com.sc.exam.service.IExamService;
import com.sc.exam.vo.ViewMsg;
import com.sc.exam.vo.examview.ExamRecordViewForStu;
import com.sc.exam.vo.examview.ExamViewForStu;

import com.sc.exam.vo.examview.RelAllInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;


import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/exam/")
public class ExamHandler {
    @Autowired
    private IExamService examService;

    @RequestMapping("check")
    @ResponseBody
    protected ViewMsg examStartCheck(Integer par_id, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user==null){
            return new ViewMsg(0,"未知错误",null);
        }
        ViewMsg viewMsg = examService.examStartCheck(user.getUserid(), par_id);
        return viewMsg;
    }
    @RequestMapping("kaoshi")
    protected ModelAndView getExamViewForStu(Integer par_id, HttpSession session){
        ModelAndView mv = new ModelAndView("html/test_in1");
        User user = (User) session.getAttribute("user");
        if (user==null){
            mv.setViewName("html/login");
            return mv;
        }
        ViewMsg viewMsg = examService.examStartCheck(user.getUserid(), par_id);
        if (!(viewMsg.getCode().equals(9990))) {
            mv.setViewName("html/all");
            return mv;
        }
        ExamRecordViewForStu examViewForStu = examService.geExamRecordViewForStu(user.getUserid(), par_id);
        mv.addObject("ViewInfo",examViewForStu);
        return mv;
    }
    @RequestMapping("record")
    protected ModelAndView getExamRecordViewForStu(Integer par_id, HttpSession session){
        ModelAndView mv = new ModelAndView("html/test_view");
        User user = (User) session.getAttribute("user");
        if (user==null){
            mv.setViewName("html/login");
            return mv;
        }
        ExamRecordViewForStu examViewForStu = examService.geExamRecordViewForStu(user.getUserid(), par_id);
        mv.addObject("ViewInfo",examViewForStu);
        return mv;
    }

    @RequestMapping(value = "autohand",  produces = "application/json;charset=UTF-8")
    protected void autoHand(@RequestParam MultiValueMap<Integer,String> params,HttpSession session){
        System.out.println(params);
        User user = (User) session.getAttribute("user");
        if (user==null){
            return;
        }
        examService.autoHand(params,user.getUserid());
        System.out.println("sdfsdf");
    }

    @PostMapping(value = "handpaper",  produces = "application/json;charset=UTF-8")
    @ResponseBody
    protected ViewMsg handPaper(@RequestParam MultiValueMap<Integer,String> params,HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user==null){
            return new ViewMsg(0,"未知错误",null);
        }
        ViewMsg viewMsg = examService.handPaper(params, user.getUserid());
        return viewMsg;
    }

//    admin
    @RequestMapping("paperview")
    protected ModelAndView getPaperViewForTea(Integer par_id){
        ModelAndView mv = new ModelAndView("management/paper-view");
        ExamRecordViewForStu examViewForStu = examService.geExamRecordViewForTea(par_id);
        mv.addObject("ViewInfo",examViewForStu);
        return mv;
    }
    @RequestMapping("Papercorrection")
    protected ModelAndView getPaperCorrectionForTea(Integer par_id, Integer userid){
        ModelAndView mv = new ModelAndView("management/paper-correction");
        ExamRecordViewForStu examViewForStu = examService.geExamRecordViewForStu(userid, par_id);
        mv.addObject("ViewInfo",examViewForStu);
        return mv;
    }

    @RequestMapping("correctionPaper")
    @ResponseBody
    protected ViewMsg correctionPaper(@RequestParam Map<String,Integer> params){
        return examService.correctionPaper(params);
    }

    @RequestMapping("changeRelName")
    @ResponseBody
    protected ViewMsg changeRelName(Integer rel_id,String rel_name){
        System.out.println(rel_id+rel_name);
//        执行修改
        return  examService.updateRelNameByRelId(rel_name,rel_id);
    }
    @RequestMapping("delRel")
    @ResponseBody
    protected ViewMsg delRelById(Integer rel_id ){
        System.out.println(rel_id );
//        执行删除

        return  examService.delRel(rel_id);
    }
    @RequestMapping("EditRelInfo")
    protected ModelAndView editRelInfo(Integer rel_id){
        ModelAndView mv = new ModelAndView("management/relinfo-edit");
//查询
        RelAllInfo relAllInfo = examService.editRelInfo(rel_id);
        mv.addObject("Info",relAllInfo);
        return  mv;
    }
//修改   relinfo
    @RequestMapping("changeRelInfo")
    @ResponseBody
    protected ViewMsg changeRelInfo(@RequestParam MultiValueMap<Integer,Integer> map){
        System.out.println(map);
        return examService.updateRelInfoById(map);
    }
//
    @RequestMapping("insertEditRel")
    protected ModelAndView insertEditRel(){
        ModelAndView mv = new ModelAndView("management/rel-add");
        List<Sub> subList = examService.getSubList();
        mv.addObject("subList",subList);
        return mv;
    }
    @RequestMapping("insertRel")
    @ResponseBody
    protected ViewMsg insertRel(@RequestParam MultiValueMap<String,String> map){
//        List<Sub> subList = examService.getSubList();

        System.out.println(map);
        ViewMsg viewMsg = examService.insertRel(map);
        return viewMsg;
    }

}
