package com.sc.exam.controller;

import com.github.pagehelper.PageInfo;
import com.sc.exam.dao.IUserDao;
import com.sc.exam.pojo.Role;
import com.sc.exam.pojo.User;
import com.sc.exam.service.IModularService;
import com.sc.exam.service.IRoleService;
import com.sc.exam.service.IUserService;
import com.sc.exam.vo.PageTable;
import com.sc.exam.vo.ViewMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/user/")
public class UserController {
    @Autowired
    IUserService userService;
    @Autowired
    IRoleService roleService;
    @Autowired
    IModularService modularService;
    @Autowired
    IUserDao userDao;
    @RequestMapping("login")
    public String login(User user, HttpServletRequest request){
        ModelAndView mv=new ModelAndView("/admin");
        HttpSession session=request.getSession();
        ViewMsg vo=new ViewMsg();
        vo=userService.login(user);
        if(vo.getData()!=null){
            User user1= (User) vo.getData();
            user1.setRoles(roleService.getRoleByuser(user1.getUserid()));
            user1.setModulars(modularService.getModularByuser(user1.getUserid()));
           session.setAttribute("user",user1);
            User user2 = (User) session.getAttribute("user");
            System.out.println("aaaaaaaaaa:" + user2);
            return "redirect:/admin.jsp";
        }

        return "redirct：/login.html";

    }
    @RequestMapping("list")
    @ResponseBody
    public PageTable<User> pageuserlist(@RequestParam(defaultValue = "1", required = false) Integer page,
                                        @RequestParam(defaultValue = "3", required = false) Integer limit, User user){
        if (user.getStartTimeStr()==""){
            user.setStartTimeStr(null);
        }
        if (user.getEndTimeStr()==""){
            user.setEndTimeStr(null);
        }
        PageInfo<User> pageInfo = userService.getList(page,limit,user);
        PageTable<User> pageTable =new PageTable();
        pageTable.setCode(0);
        pageTable.setMsg("");
        pageTable.setCount(pageInfo.getTotal());
        pageTable.setData(pageInfo.getList());
        return pageTable;

    }
    @RequestMapping("/del")
    @ResponseBody
    public Integer del(Integer userid){
        return userService.deleteone(userid);
    }
//    @RequestMapping("/update1")
//    public  update1(String account) {
//
//        User user=userService.selectone(account);
//
//        return"/management/userxg";
//
//    }
    @RequestMapping ("test")
    public String test(HttpSession session){
        User user = (User) session.getAttribute("user");
        System.out.println(user);
        return null;
    }
    @RequestMapping("addinit")
    private ModelAndView addinit(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, ServletException {
        ModelAndView mv=new ModelAndView("/sys/userEdit");
        List<Role> roles = roleService.getList();
        mv.addObject("reqrole",roles);
        return mv;
    }
    @RequestMapping ("deleteone")
    @ResponseBody
    public Integer deleteone(Integer userid){
     Integer res=userService.deleteone(userid);
        return res;
    }
    @GetMapping("updateinit")
    public ModelAndView updateinit(Integer userid){
        ModelAndView mv=new ModelAndView("/sys/userEdit");
        User user=userService.getOnebyid(userid);
        List<Role> roles=roleService.getList();
        mv.addObject("reqrole",roles);
        mv.addObject("requser",user);
        return mv;
    }

    @RequestMapping("update")
    public ModelAndView update(User user, String method){
        ModelAndView mv=new ModelAndView("/sys/userEdit");
        if ("update".equalsIgnoreCase(method)) {
            ViewMsg viewMsg = userService.updateuser(user);
            if (viewMsg == null) {
                viewMsg.setCode(401);
                viewMsg.setMsg("修改失败");
            }
            user = userService.getOnebyid(user.getUserid());
            List<Role> roles = roleService.getList();
            mv.addObject("reqrole", roles);
            mv.addObject("requser", user);
            mv.addObject("vo", viewMsg.getCode());
            return mv;
        }
        ViewMsg viewMsg =userService.insertuser(user);
        User user1= (User) viewMsg.getData();
        List<Role> roles = roleService.getList();
        mv.addObject("reqrole", roles);mv.addObject("vo", viewMsg.getCode());
        mv.addObject("requser", user1);


        return mv;
    }
    @RequestMapping ("ajaxaccount")
    @ResponseBody
    public Integer ajaxaccount(String account){
        User user=userService.selectone(account);
        if (user!=null){
            return 0;
        }
        return 1;
    }
    @RequestMapping("cz")
    @ResponseBody
    private Integer cz(Integer userid){
    return userDao.updatepasw(userid);
    }
}
