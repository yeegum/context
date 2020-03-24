package com.sc.exam.controller;

import com.sc.exam.pojo.User;
import com.sc.exam.pojo.ov.Notes;
import com.sc.exam.service.INoteService;
import com.sc.exam.vo.ViewMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/management/Note/")
public class NoteHandler {

    @Autowired
    INoteService noteService;

//    static User user = new User();
//    static {
//        user.setUserid(4);
//    }

    @RequestMapping("doShow")
    public ModelAndView doShow(String uid, String page, String status, @RequestParam(defaultValue = "management/admin-pass-note-list") String url, HttpSession session) {
        return noteService.doShow(uid,page,status,url,session);
    }

    //上传笔记方法，返回的code值为“ 1 ”时，为上传成功；“ 0 ”时上传失败
    //上传的笔记有两种状态：0 未审核，1 通过审核，（2：被管理员删除）
    @RequestMapping("upload")
    @ResponseBody
    protected ViewMsg upload(String title,String type,MultipartFile note,HttpSession session){
//        session.setAttribute("user",user);
        return noteService.upload(title,type,note,session);
    }

    @RequestMapping("download")
    @ResponseBody
    public void download(String nid, HttpServletRequest req, HttpServletResponse response) {
        noteService.download(nid,req,response);
    }

    @RequestMapping("ChangeStatus")
    @ResponseBody
    protected ViewMsg ChangeStatus(String nid,String sid){
        return noteService.ChangeStatus(nid,sid);
    }

    @RequestMapping("delAll")
    @ResponseBody
    protected ViewMsg del(Integer[] ids){
        System.out.println(ids.toString());
        return noteService.delAll(Arrays.asList(ids));
    }

    @RequestMapping("dodel")
    @ResponseBody
    protected  ViewMsg dodel(String nid){
        return noteService.dodel(nid);
    }

    @RequestMapping("ChangeStatusAll")
    @ResponseBody
    protected ViewMsg changeStautsAll(Integer[] ids,String sid){
        return noteService.changeStautsAll(Arrays.asList(ids),sid);
    }

    @RequestMapping("doForChange")
    protected ModelAndView doForChange(String nid){
        return noteService.doForChange(nid);
    }

    @RequestMapping("doChange")
    @ResponseBody
    protected ViewMsg doChange(String tid,String nid,String title){
        return noteService.doChange(tid,nid,title);
    }

    @RequestMapping("doSearch")
    @ResponseBody
    protected void doSearch(String title,HttpSession session){
        noteService.doSearch(title,session);
    }

    @RequestMapping("ShowByType")
    @ResponseBody
    protected void ShowByType(String tid,HttpSession session){
        noteService.doSearchByType(tid,session);
    }

    @RequestMapping("getHotNotes")
    @ResponseBody
    protected ViewMsg<List<Notes>> getHotNotes(){
        return noteService.getHotNotes();
    }
}
