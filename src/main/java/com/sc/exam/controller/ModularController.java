package com.sc.exam.controller;

import com.github.pagehelper.PageInfo;
import com.sc.exam.dao.IModularDao;
import com.sc.exam.pojo.Modular;
import com.sc.exam.pojo.Role;
import com.sc.exam.service.IModularService;
import com.sc.exam.service.IRoleService;
import com.sc.exam.vo.PageTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/m/")
public class ModularController {
    @Autowired
    IModularService modularService;
    @Autowired
    IRoleService roleService;
    @Autowired
    IModularDao modularDao;
    @RequestMapping("list")
    @ResponseBody
    protected List<Modular> list(){
        return modularService.getlist();
    }
    @RequestMapping("/page")
    @ResponseBody
    public PageTable<Modular> pageTableList(@RequestParam(defaultValue = "1", required = false) Integer page,
                                            @RequestParam(defaultValue = "10", required = false) Integer limit, Modular modular){

        PageInfo<Modular> pageInfo = modularService.getpage(page,limit,modular);
        PageTable<Modular> pageTable=new PageTable<>();
        pageTable.setCode(0);
        pageTable.setMsg("");
        pageTable.setCount(pageInfo.getTotal());
        pageTable.setData(pageInfo.getList());
        return pageTable;


    }
    @RequestMapping("flist")
    @ResponseBody
    protected List<Modular> flist(){
        return modularService.getfm();
    }
    @RequestMapping("addinit")
    protected ModelAndView addinit(){
        ModelAndView mv=new ModelAndView("/sys/madd");
       List<Role> list=roleService.getList();
       mv.addObject("role",list);
       return mv;

    }
    @RequestMapping("add")
    protected ModelAndView add(Modular modular,String method){
        ModelAndView mv=new ModelAndView("/sys/madd");
        if (method.equalsIgnoreCase("update")) {
//            Role role1=roleService.updaterole(role);
//
//            mv.addObject("reqrole",role1);
//            List<Modular> ms=modularService.getlist();
//            mv.addObject("ms",ms);
            Modular modular1=modularService.updatem(modular);
            mv.addObject("code",600);
            mv.addObject("reqmenu",modular1);
            List<Role> list=roleService.getList();
            mv.addObject("role",list);
            return mv;
        }
        Modular modular1=modularService.addm(modular);
        mv.addObject("code",600);
        mv.addObject("reqmenu",modular1);
        List<Role> list=roleService.getList();
        mv.addObject("role",list);
        return mv;
    }
    @RequestMapping("updateinit")
    protected ModelAndView addinit(Integer mid){
        ModelAndView mv=new ModelAndView("/sys/madd");
        Modular modular=modularDao.getmbymid(mid);
        modular.setMroles(modularDao.getmrbymid(mid));
        List<Role> list=roleService.getList();
        mv.addObject("role",list);
        mv.addObject("reqmenu",modular);
        return mv;

    }
    @RequestMapping("deleteone")
    @ResponseBody
    protected Integer delete(Integer mid){
        return modularService.deletem(mid);
    }
}
