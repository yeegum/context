package com.sc.exam.controller;

import com.github.pagehelper.PageInfo;
import com.sc.exam.pojo.*;
import com.sc.exam.service.IExamService;
import com.sc.exam.service.ITestService;
import com.sc.exam.vo.PageTable;
import com.sc.exam.vo.ViewMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/test/")
public class TestHandler {
    @Autowired
    private ITestService testService;

    @RequestMapping("ajaxSub")
    @ResponseBody
    public List<Sub> ajaxSub() {
        System.out.println("ajaxSub");
        return testService.getSubs();
    }
    @RequestMapping("ajaxRel")
    @ResponseBody
    public List<Rel> ajaxRel() {
        System.out.println("ajaxRel");
        return testService.getRels();
    }
    @RequestMapping("CreatePaper")
    @ResponseBody
    public ViewMsg create(String pname,Integer sub,Integer rel,String startime,String endtime,Integer lengthtime) {
        System.out.println("pname:"+pname+",sub:"+sub+",rel:"+rel+",start:"+startime+",end:"+endtime+",length:"+lengthtime+":");
        Paper p=new Paper();
        p.setPar_name(pname);
        p.setSub_id(sub);
        p.setRel_id(rel);
        Timestamp s = new Timestamp(System.currentTimeMillis());
        try {
            s = Timestamp.valueOf(startime);
            System.out.println(s);
        } catch (Exception e) {
            e.printStackTrace();
        }
        p.setTest_start_time(s);
        Timestamp e= new Timestamp(System.currentTimeMillis());
        try {
            e = Timestamp.valueOf(endtime);
            System.out.println(e);
        } catch (Exception i) {
            i.printStackTrace();
        }
        p.setTest_end_time(e);
        p.setTest_length_time(lengthtime);
        System.out.println(p);
        return testService.createPaper(p);
    }

    @RequestMapping("paperAlt")
    @ResponseBody
    protected ViewMsg paperAlt(Integer pid,String pna,String startime,String endtime,Integer leng) {
        System.out.println("pid:"+pid+","+"pna:"+pna+","+"startime:"+startime+","+"endtime:"+endtime+","+"leng:"+leng);
        Paper p=new Paper();
        p.setPar_id(pid);
        p.setPar_name(pna);
        Timestamp s = new Timestamp(System.currentTimeMillis());
        try {
            s = Timestamp.valueOf(startime);
            System.out.println(s);
        } catch (Exception e) {
            e.printStackTrace();
        }
        p.setTest_start_time(s);
        Timestamp e= new Timestamp(System.currentTimeMillis());
        try {
            e = Timestamp.valueOf(endtime);
            System.out.println(e);
        } catch (Exception i) {
            i.printStackTrace();
        }
        p.setTest_end_time(e);
        p.setTest_length_time(leng);
        System.out.println(p);
        return testService.paperAlt(p);
    }

    @RequestMapping("page")
    @ResponseBody
    PageTable<Que> getQueByPage( @RequestParam(defaultValue = "1", required = false) Integer page,
                                     @RequestParam(defaultValue = "1", required = false) Integer limit)
    {
        PageInfo<Que> pageInfo = testService.getQueList(page,limit);
        PageTable<Que> pageTable = new PageTable(0, "", pageInfo.getTotal(),pageInfo.getList());
        return pageTable;
    }
    @RequestMapping("paper")
    @ResponseBody
    PageTable<Que> getPaperByPage( @RequestParam(defaultValue = "1", required = false) Integer page,
                                   @RequestParam(defaultValue = "1", required = false) Integer limit)
    {
        PageInfo<Paper> pageInfo = testService.getPapers(page,limit);
        PageTable<Que> pageTable = new PageTable(0, "", pageInfo.getTotal(),pageInfo.getList());
        return pageTable;
    }
    @RequestMapping("queSearch")
    @ResponseBody
    PageTable<Que> queSearch(Integer sub,String ask, @RequestParam(defaultValue = "1", required = false) Integer page,
                                      @RequestParam(defaultValue = "1", required = false) Integer limit)
    {
        String as="%"+ask+"%";
        System.out.println("sub_id:"+sub+","+"as:"+ask);
        PageInfo<Que> pageInfo = testService.queSearch(sub,as,page,limit);
        PageTable<Que> pageTable = new PageTable(0, "", pageInfo.getTotal(),pageInfo.getList());
        return pageTable;
    }

   @RequestMapping("que")
    protected ModelAndView que(){
        ModelAndView mv=new ModelAndView("management/que");
        mv.addObject("subs",testService.getSubs());
        mv.addObject("types",testService.getTypeList());
        return mv;
   }
   @RequestMapping("queAdd")
   @ResponseBody
    protected ViewMsg queAdd(Integer subid,Integer typeid, String content,String key,
                            @RequestParam(defaultValue ="0",required = false) String a, @RequestParam(defaultValue ="0",required = false) String b,
                             @RequestParam(defaultValue ="0",required = false) String c, @RequestParam(defaultValue ="0",required = false) String d,
                             @RequestParam(defaultValue ="0",required = false) String e){
        Que q=new Que();
        q.setSub_id(subid);
        q.setQue_type_id(typeid);
        q.setAsk(content);
        q.setAsk(content);
        q.setRight_ask(key);
        List<QueOption> ops= new ArrayList<>();
        if(!"0".equals(a)){
            QueOption opa=new QueOption(0,0,a,"A",0);
            QueOption opb=new QueOption(0,0,b,"B",0);
            QueOption opc=new QueOption(0,0,c,"C",0);
            QueOption opd=new QueOption(0,0,d,"D",0);
            QueOption ope=new QueOption(0,0,e,"E",0);
            ops.add(opa);
            ops.add(opb);
            ops.add(opc);
            ops.add(opd);
            ops.add(ope);
        }
       ViewMsg vm=testService.queAdd(q,ops);
       return vm;
   }
    @RequestMapping("Del")
    @ResponseBody
    protected Integer del(Integer[] ids){
        System.out.println(Arrays.toString(ids));

        int result = testService.delQueById(Arrays.asList(ids));
        System.out.println(result);
        return result;
    }
    @RequestMapping("delPaper")
    @ResponseBody
    protected Integer delPaper(Integer[] ids){
        int k=0;
        for(int i=0;i<ids.length;i++){
            testService.delPaper(ids[i]);
        }

        System.out.println(k);
        return k;
    }

    @RequestMapping("getQueById")
    protected ModelAndView getQueById(Integer id){
        ModelAndView mv=new ModelAndView("management/que-edit");
        mv.addObject("que",testService.getQueById(id));
        mv.addObject("types",testService.getTypeList());
        mv.addObject("subs",testService.getSubs());
        mv.addObject("ops",testService.getOptionsByQueId(id));
        return mv;
    }
    @RequestMapping("queChange")
    @ResponseBody
    protected ViewMsg queChange(Integer queid,Integer subid,Integer typeid, String content,String key,
                                @RequestParam(defaultValue ="0",required = false) String A, @RequestParam(defaultValue ="0",required = false) String B,
                                @RequestParam(defaultValue ="0",required = false) String C, @RequestParam(defaultValue ="0",required = false) String D,
                                @RequestParam(defaultValue ="0",required = false) String E){

        Que q=new Que();
        q.setSub_id(subid);
        q.setQue_type_id(typeid);
        q.setAsk(content);
        q.setAsk(content);
        q.setRight_ask(key);
        q.setQue_id(queid);
        List<QueOption> ops= new ArrayList<>();
        if(!"0".equals(A)){
            QueOption opa=new QueOption(0,0,A,"A",0);
            QueOption opb=new QueOption(0,0,B,"B",0);
            QueOption opc=new QueOption(0,0,C,"C",0);
            QueOption opd=new QueOption(0,0,D,"D",0);
            QueOption ope=new QueOption(0,0,E,"E",0);
            ops.add(opa);
            ops.add(opb);
            ops.add(opc);
            ops.add(opd);
            ops.add(ope);
        }
        ViewMsg vm=testService.queChange(q,ops);
        System.out.println("ops---------------------------"+ops);
        System.out.println(q);
        return vm;
    }
    @RequestMapping("issue")
    @ResponseBody
    protected int issue(Integer id,Integer s){
        System.out.println(s);
        Integer st=0;
        if(s==0){
            st=1;
        }
      return   testService.issue(id,st);
    }
    public static void main(String[] args) {
        String s="A,c";
        String str="A";
        for(String i:s.split(",")){
            System.out.println(i);
        }
        System.out.println("-------");

        for(String i:str.split(",")){
            System.out.println(i);
        }
    }

}