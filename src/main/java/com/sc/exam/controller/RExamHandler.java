package com.sc.exam.controller;


import com.sc.exam.pojo.RegUser;

import com.sc.exam.service.ISignService;
import com.sc.exam.service.ISmsServcie;
import com.sc.exam.service.IUsersService;
import com.sc.exam.vo.ViewMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/")
public class RExamHandler {
    @Autowired
    IUsersService iUsersService;
    @Autowired
    ISmsServcie iSmsServcie;
    @Autowired
    ISignService iSignService;

    @RequestMapping("regUser")
    @ResponseBody
    public String regUser(@RequestParam(value = "phone",required = true)String phone,
                          @RequestParam(value = "account",required = true)String account,
                          @RequestParam(value = "password",required = true)String password,
                          @RequestParam(value = "code",required=false)int code,
                          HttpServletRequest request){
        //获取ip地址
        String ip = request.getRemoteAddr();
        RegUser regUser = new RegUser();
        regUser.setPhone(phone);
        regUser.setAccount(account);
        regUser.setIp(ip);
        regUser.setCode(code);
        regUser.setPassword(DigestUtils.md5DigestAsHex(password.getBytes()));
        return  iUsersService.regUser(regUser);
    }
    @RequestMapping("sms")
    @ResponseBody
    public String sms(String phone){
        if(phone.length()==0){
            System.out.println("请输入电话号码");
            return "请输入电话号码";
        }
        String msg=iSmsServcie.addSms(phone);
        return msg ;
    }

    @RequestMapping("login")
    @ResponseBody
    protected ViewMsg login(String account, String password, String code, HttpSession session){
        //获取session中的验证码
        ViewMsg viewMsg = new ViewMsg();

        String rCode = (String) session.getAttribute("rCode");
       if(rCode.trim().equalsIgnoreCase(code.trim())){
           String pwd= DigestUtils.md5DigestAsHex(password.getBytes());
           viewMsg= iUsersService.userLogin(account,pwd,session);
           return viewMsg;
       }
       viewMsg.setCode(111);
        viewMsg.setMsg("验证码错误");
       return viewMsg;
    }
    @RequestMapping("sign")
    @ResponseBody
    protected String sign(HttpSession session){
        String msg=iSignService.sign(session);
        System.out.println(msg);
        return msg;
    }
    @RequestMapping("logout")
//    @ResponseBody
    protected String logout(HttpSession session){
        /*ModelAndView mv=new ModelAndView("html/login");
        iUsersService.logout(session);
        return mv;*/
        session.removeAttribute("user");
        session.invalidate();
        return "redirect:html/login.jsp";
    }
    @RequestMapping("")
//    @ResponseBody
    protected String toindex(){
        return "redirect:html/login.jsp";
    }

}
