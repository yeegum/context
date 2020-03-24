package com.sc.exam.service;

import com.sc.exam.pojo.ov.Notes;
import com.sc.exam.vo.ViewMsg;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public interface INoteService {

    ViewMsg upload(String title,String type,MultipartFile note, HttpSession session);

    ModelAndView doShow(String uid,String page, String status, String url,HttpSession session);

    ViewMsg ChangeStatus(String nid,String sid);

    ViewMsg delAll(List<Integer> idList);

    ViewMsg changeStautsAll(List<Integer> idList,String sid);

    ViewMsg dodel(String nid);

    ModelAndView doForChange(String nid);

    ViewMsg doChange(String tid,String nid,String title);

    void download(String nid, HttpServletRequest req, HttpServletResponse response);

    void doSearch(String title,HttpSession session);

    void doSearchByType(String tid,HttpSession session);

    ViewMsg<List<Notes>> getHotNotes();
}
