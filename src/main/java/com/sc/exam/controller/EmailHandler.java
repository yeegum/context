package com.sc.exam.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.pojo.*;
import com.sc.exam.service.IEmailService;
import com.sc.exam.service.IExamService;
import com.sc.exam.vo.PageTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/management")
public class EmailHandler {
    @Autowired
    IEmailService emailService;

    @RequestMapping("recvEmailBox")
    @ResponseBody
    public PageTable  getRecvEmailList(@RequestParam(defaultValue = "1",required = false) Integer page,
                                       @RequestParam(defaultValue = "5",required = false) Integer limit,
                                       HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return new PageTable();
        }
        Integer myuserid = user.getUserid();
        PageHelper.startPage(page,limit);
        List<Email> recvEmailList = emailService.getRecvEmailList((Integer) myuserid);
        PageInfo<Email> pageInfo=new PageInfo<>(recvEmailList);
        PageTable<Email> pageTable=new PageTable<>(0,"",pageInfo.getTotal(),pageInfo.getList());
        return pageTable;
    }
    @RequestMapping("readRecvEmail")
    @ResponseBody
    public int readRecvEmail(HttpSession session,Integer id){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return -1;
        }
        Integer myuserid = user.getUserid();
        return emailService.readRecvEmail((Integer) myuserid, id);
    }
    @RequestMapping("addRecycleEmail_recvEmail")
    @ResponseBody
    public int delRecvEmail(HttpSession session,Integer id){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return -1;
        }
        Integer myuserid = user.getUserid();
        return emailService.delRecvEmail((Integer) myuserid,id);
    }
    @RequestMapping("sendEmailBox")
    @ResponseBody
    public PageTable  getSendEmailList(@RequestParam(defaultValue = "1",required = false) Integer page,
                                       @RequestParam(defaultValue = "5",required = false) Integer limit,
                                       HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return new PageTable();
        }
        Integer myuserid = user.getUserid();
        PageHelper.startPage(page,limit);

        List<Email> recvEmailList = emailService.getSendEmailList((Integer) myuserid);
        PageInfo<Email> pageInfo=new PageInfo<>(recvEmailList);
        PageTable<Email> pageTable=new PageTable<>(0,"",pageInfo.getTotal(),pageInfo.getList());
        return pageTable;
    }
    @RequestMapping("readSendEmail")
    @ResponseBody
    public int readSendEmail(HttpSession session,Integer id){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return -1;
        }
        Integer myuserid = user.getUserid();
        return emailService.readSendEmail((Integer) myuserid, id);
    }
    @RequestMapping("addRecycleEmail_sendEmail")
    @ResponseBody
    public int delSendEmail(HttpSession session,Integer id){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return -1;
        }
        Integer myuserid = user.getUserid();
        return emailService.delSendEmail((Integer) myuserid,id);
    }
    @RequestMapping("recycleEmailBox")
    @ResponseBody
    public PageTable  getRecycleEmailList(@RequestParam(defaultValue = "1",required = false) Integer page,
                                       @RequestParam(defaultValue = "5",required = false) Integer limit,
                                       HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return new PageTable();
        }
        Integer myuserid = user.getUserid();
        PageHelper.startPage(page,limit);
        List<Email> recvEmailList = emailService.getRecycleEmailList((Integer) myuserid);
        PageInfo<Email> pageInfo=new PageInfo<>(recvEmailList);
        PageTable<Email> pageTable=new PageTable<>(0,"",pageInfo.getTotal(),pageInfo.getList());
        return pageTable;
    }
    @RequestMapping("recovery")
    @ResponseBody
    public int recovery(Integer id){
        return emailService.recovery(id);
    }
    @RequestMapping("sendEmail")
    @ResponseBody
    public int sendEmail(HttpSession session,Integer recv_userid, String topic, String content){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return -1;
        }
        Integer myuserid = user.getUserid();
        Email email=new Email();
        email.setSend_userid((Integer) myuserid);
        email.setRecv_userid(recv_userid);
        email.setTopic(topic);
        email.setContent(content);
        email.setStatus(0);
        return emailService.sendEmail(email);
    }
}
