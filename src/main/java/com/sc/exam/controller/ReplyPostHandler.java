package com.sc.exam.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.pojo.Posts;
import com.sc.exam.pojo.ReplyPosts;
import com.sc.exam.service.IReplyPostsService;
import com.sc.exam.vo.PageTable;
import com.sc.exam.vo.ViewMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/management/Posts")
public class ReplyPostHandler {
    @Autowired
    IReplyPostsService iReplyPosts;
    @RequestMapping("changeReplyStatus")
    @ResponseBody
    public ViewMsg changeReplyStatus(Integer id) throws IOException {
        ViewMsg viewMsg=new ViewMsg();
        ReplyPosts replyPosts=iReplyPosts.findOneReplyPosts(id);
        if (replyPosts.getApply_status()==1){
            replyPosts.setApply_status(0);
        }else {
            replyPosts.setApply_status(1);
        }
        int n=iReplyPosts.changeReplyPostsStatus(id,replyPosts.getApply_status());
        if (n>0) {
            viewMsg.setMsg("修改状态成功");
        }else {
            viewMsg.setMsg("修改状态失败");
        }
        return viewMsg;
    }
    @RequestMapping("getAllReplyPost")
    @ResponseBody
    private PageTable<ReplyPosts> getAllReplyPost(@RequestParam(defaultValue = "1", required = false) Integer page,
                                                  @RequestParam(defaultValue = "5", required = false) Integer limit, HttpSession session,
                                                  HttpServletResponse response){
        ViewMsg viewMsg=new ViewMsg();
//           =iReplyPosts.findAllReplyPosts();
        PageHelper.startPage(page, limit);
        List<ReplyPosts> list = iReplyPosts.findAllReplyPosts();
        PageInfo<ReplyPosts> pageInfo = new PageInfo<>(list);
        PageTable<ReplyPosts> pageTable = new PageTable(0, "", pageInfo.getTotal(),pageInfo.getList());

        return pageTable;
    }
    @RequestMapping("delReplyPost")
    @ResponseBody
    private ViewMsg  delReplyPost(Integer id){
        ViewMsg viewMsg=new ViewMsg();
        int n=iReplyPosts.delReplyPosts(id);
        iReplyPosts.delReplyPostss(id);
        if (n>0){
            viewMsg.setMsg("删除评论成功");
        }
        return  viewMsg;
    }
    @RequestMapping("delSingerReplyPost")
    @ResponseBody
    private ViewMsg  delSingerReplyPost(Integer id){
        ViewMsg viewMsg=new ViewMsg();
        int n=iReplyPosts.delReplyPosts(id);
        if (n>0){
            viewMsg.setMsg("删除评论成功");
        }
        return  viewMsg;
    }
    @RequestMapping("delListReply")
    @ResponseBody
    private ViewMsg delListReply(Integer[] ids) {
        //删除多个模块
        System.out.println(ids);
        ViewMsg viewMsg = new ViewMsg();
        int i = iReplyPosts.delListReply(Arrays.asList(ids));
        if (i > 0) {
            viewMsg.setCode(1);
            viewMsg.setMsg("删除帖子成功");
        } else {
            viewMsg.setCode(2);
            viewMsg.setMsg("删除失败");
        }
        return viewMsg;
    }
    @RequestMapping("likeNameReply")
    @ResponseBody
    public PageTable<ReplyPosts> findPostByTitle(String  likename, @RequestParam(defaultValue = "1", required = false) Integer page,
                                            @RequestParam(defaultValue = "5", required = false) Integer limit, HttpSession session){
        PageHelper.startPage(page, limit);
        String name="%"+likename+"%";
        List<ReplyPosts> list = iReplyPosts.findReplyByLikeName(name);
        PageInfo<ReplyPosts> pageInfo = new PageInfo<>(list);
        PageTable<ReplyPosts> pageTable = new PageTable(0, "", pageInfo.getTotal(),pageInfo.getList());
//        pageTable.setData(pageInfo.getList());
        return pageTable;
    }
}
