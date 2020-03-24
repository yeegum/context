package com.sc.exam.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.pojo.Plate;
import com.sc.exam.pojo.Posts;
import com.sc.exam.service.IPlateService;
import com.sc.exam.service.IPostService;
import com.sc.exam.vo.PageTable;
import com.sc.exam.vo.ViewMsg;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.*;

import java.util.Arrays;

import java.util.List;
import java.util.UUID;


@Controller
@RequestMapping("/management/Plate")
public class PlateHandler {
    @Value("${file.uploadFolder}")
    private String path;
    @Autowired
    IPlateService iPlateService;
    @Autowired
    IPostService iPostService;
    @RequestMapping("getAllPlate")
    @ResponseBody
    private PageTable<Plate> getAllPlate(@RequestParam(defaultValue = "1", required = false) Integer page,
                                         @RequestParam(defaultValue = "3", required = false) Integer limit, HttpSession session) throws IOException {
        System.out.println("dddd");
        PageHelper.startPage(page, limit);
        List<Plate> list = iPlateService.getAllPlate();
        PageInfo<Plate> pageInfo = new PageInfo<>(list);
        PageTable<Plate> pageTable = new PageTable(0, "", pageInfo.getTotal(),pageInfo.getList());
//        pageTable.setData();
//        pageTable.setData(pageInfo.getList());
        return pageTable;
    }
    @RequestMapping("getAllNoPagePlate")
    @ResponseBody
        public  ModelAndView getAllNoPagePlate(){
        ModelAndView modelAndView=new ModelAndView("html/forum_inside");
        List<Plate> list = iPlateService.getUserPlate();
        modelAndView.addObject("Platelist",list);
        List<Posts> hotPosts=iPostService.getHotPosts();

        modelAndView.addObject("hotPosts",hotPosts);
        return  modelAndView;
    }
    @RequestMapping("delPlate")
    @ResponseBody
    private ViewMsg delPlate(Integer id) {

        ViewMsg viewMsg = new ViewMsg();
        if (iPlateService.delPlate(id) > 0) {
            viewMsg.setCode(1);
            viewMsg.setMsg("删除成功");
        } else {
            viewMsg.setCode(2);
            viewMsg.setMsg("删除失败");
        }
        return viewMsg;
    }

    @RequestMapping("delListPlate")
    @ResponseBody
    private ViewMsg delListPlate(Integer[] ids) {
       //删除多个模块
        System.out.println(ids);
        ViewMsg viewMsg = new ViewMsg();
        int i = iPlateService.delListPlate(Arrays.asList(ids));
        if (i > 0) {
            viewMsg.setCode(1);
            viewMsg.setMsg("删除成功");
        } else {
            viewMsg.setCode(2);
            viewMsg.setMsg("删除失败");
        }
        return viewMsg;
    }

    @RequestMapping("addPlate")
    public ModelAndView addPlate(String plate_type, @RequestParam(name = "img", required = false) MultipartFile img,
                         HttpSession session, Integer plate_status,Integer plate_id) {
        Plate plate = new Plate();
        plate.setPlate_type(plate_type);
        plate.setPlate_status(plate_status);
        plate.setPlate_id(plate_id);
//        Session session1= (Session) session;
//        String path = session.getServletContext().getRealPath("upload/");
        if (img!= null) {
            File file = new File(path + img.getOriginalFilename());
            try {
                img.transferTo(file);
            } catch (IOException e) {
//            e.printStackTrace();
            }

            //以绝对路径保存重名命后的图片
            //把图片存储路径保存到数据库
            plate.setPlate_plateimg("/upload/" + img.getOriginalFilename());
        }
        //重定向到查询所有用户的Controller，测试图片回显
        int i = iPlateService.addPlate(plate);
        ModelAndView modelAndView=new ModelAndView("management/Plate-list");
        return modelAndView;
    }

    @RequestMapping("findPlate")
    private ModelAndView  findPlate(Integer id,HttpSession session){
        System.out.println(1111);
        Plate plate=iPlateService.findSingerPlate(id);
        System.out.println(plate);
        ModelAndView modelAndView=new ModelAndView("management/plate-change");
        session.setAttribute("plates",plate);
        return modelAndView;
    }
    @RequestMapping("changePlate")
    @ResponseBody
    public String changePlate(String plate_type, @RequestParam(name = "img", required = false) MultipartFile img,
                         HttpSession session, Integer plate_status,Integer plate_id) throws IOException {
        System.out.println(plate_status + plate_type);
//        Session session1= (Session) session;
        Plate plate = new Plate();
        plate.setPlate_id(plate_id);
        plate.setPlate_type(plate_type);
        plate.setPlate_status(plate_status);

        if (img!= null) {
            File file = new File(path + img.getOriginalFilename());
            try {
                img.transferTo(file);
            } catch (IOException e) {
//            e.printStackTrace();
            }
            //以绝对路径保存重名命后的图片
            //把图片存储路径保存到数据库
            plate.setPlate_plateimg("/upload/" + img.getOriginalFilename());
        }
        //重定向到查询所有用户的Controller，测试图片回显
        int i = iPlateService.changePlate(plate);
        ViewMsg viewMsg = new ViewMsg();
        if (i > 0) {
            viewMsg.setMsg("添加成功");
        }
        return "添加成功";
    }
    @RequestMapping("likeNamePlate")
    @ResponseBody
    public PageTable<Plate> likeNamePlate(String  likename,@RequestParam(defaultValue = "1", required = false) Integer page,
                                        @RequestParam(defaultValue = "8", required = false) Integer limit, HttpSession session) throws IOException {

        PageHelper.startPage(page, limit);
        String name="%"+likename+"%";
//        System.out.println(list1[0]);
//        System.out.println(list1[1]);
//        System.out.println(name);
        List<Plate> list = iPlateService.likeNamePlate(name);
        PageInfo<Plate> pageInfo = new PageInfo<>(list);
        PageTable<Plate> pageTable = new PageTable(0, "", pageInfo.getTotal(),pageInfo.getList());
//        pageTable.setData();
//        pageTable.setData(pageInfo.getList());
         return pageTable;
    }
    @RequestMapping("changeStatus")
    @ResponseBody
    public ViewMsg likeNamePlate(Integer id) throws IOException {
        System.out.println(id);
        ViewMsg viewMsg=new ViewMsg();
        Plate plate=iPlateService.findSingerPlate(id);
        if (plate.getPlate_status()==1){
            plate.setPlate_status(0);
        }else {
            plate.setPlate_status(1);
        }
        iPlateService.changeStatusPlate(id,plate.getPlate_status());
        viewMsg.setMsg("修改状态成功");
        return viewMsg;
    }
}
