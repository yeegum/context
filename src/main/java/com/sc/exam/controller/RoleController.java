package com.sc.exam.controller;

import com.github.pagehelper.PageInfo;
import com.sc.exam.dao.IModularDao;
import com.sc.exam.pojo.Modular;
import com.sc.exam.pojo.Role;
import com.sc.exam.service.IModularService;
import com.sc.exam.service.IRoleService;
import com.sc.exam.vo.PageTable;
import com.sc.exam.vo.ViewMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
@RequestMapping("/role")
public class RoleController {
    @Autowired
    IRoleService roleService;
    @Autowired
    IModularService modularService;
    @Autowired
    IModularDao modularDao;
    @RequestMapping("/list")
    @ResponseBody
    public List<Role> roleList(){
        return roleService.getList();
    }

//    @RequestMapping("list")
//    @ResponseBody
//    public PageTable<User> pageuserlist(@RequestParam(defaultValue = "1", required = false) Integer page,
//                                        @RequestParam(defaultValue = "10", required = false) Integer limit,User user){
//        if (user.getStartTimeStr()==""){
//            user.setStartTimeStr(null);
//        }
//        if (user.getEndTimeStr()==""){
//            user.setEndTimeStr(null);
//        }
//        PageInfo<User> pageInfo = userService.getList(page,limit,user);
//        PageTable<User> pageTable =new PageTable();
//        pageTable.setCode(0);
//        pageTable.setMsg("");
//        pageTable.setCount(pageInfo.getTotal());
//        pageTable.setData(pageInfo.getList());
//        return pageTable;
//
//    }
    @RequestMapping("/page")
    @ResponseBody
    public PageTable<Role> pageTableList(@RequestParam(defaultValue = "1", required = false) Integer page,
                                         @RequestParam(defaultValue = "10", required = false) Integer limit, Role role){

        PageInfo<Role> pageInfo = roleService.getroleList(page,limit,role);
        PageTable<Role> pageTable=new PageTable<>();
        pageTable.setCode(0);
        pageTable.setMsg("");
        pageTable.setCount(pageInfo.getTotal());
        pageTable.setData(pageInfo.getList());
        return pageTable;


    }
    @RequestMapping("addinit")
    private ModelAndView addinit(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, ServletException {
        ModelAndView mv=new ModelAndView("/sys/roleadd");
        List<Modular> ms=modularService.getlist();
        mv.addObject("ms",ms);
        return mv;
    }
    @RequestMapping("updateinit")
    private ModelAndView updateinit(Integer roleid) {
        ModelAndView mv=new ModelAndView("/sys/roleadd");
        List<Modular> ms=modularService.getlist();
        Role role=roleService.getonebyroleid(roleid);
        role.setModularList(modularDao.getmodularbyrole(roleid));
        mv.addObject("reqrole",role);
        mv.addObject("ms",ms);
        return mv;
    }
    @RequestMapping("add")
    protected ModelAndView add(Role role, String method){
         ModelAndView mv=new ModelAndView("/sys/roleadd");
        if ("update".equalsIgnoreCase(method)) {
            Role role1=roleService.updaterole(role);
            mv.addObject("code",600);
            mv.addObject("reqrole",role1);
            List<Modular> ms=modularService.getlist();
            mv.addObject("ms",ms);
            return mv;
        }
        ViewMsg v=roleService.addrole(role);
        mv.addObject("code",v.getCode());
        mv.addObject("reqrole",v.getData());
        List<Modular> ms=modularService.getlist();
        mv.addObject("ms",ms);
        return mv;
    }
    @RequestMapping("delete")
    @ResponseBody
    protected Integer delete(Integer roleid){
        return roleService.deleterole(roleid);
    }
}
