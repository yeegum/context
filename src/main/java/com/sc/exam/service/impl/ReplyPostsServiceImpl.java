package com.sc.exam.service.impl;

import com.sc.exam.dao.IReplyPostsDao;
import com.sc.exam.pojo.ReplyPosts;
import com.sc.exam.service.IReplyPostsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyPostsServiceImpl implements IReplyPostsService {
    @Autowired
    IReplyPostsDao iReplyPosts;
    @Override
    public int addReplyPosts(ReplyPosts replyPosts) {
        return iReplyPosts.addReplyPosts(replyPosts);
    }

    @Override
    public int delReplyPosts(Integer replyId) {
        return iReplyPosts.delReplyPosts(replyId);
    }

    @Override
    public int delReplyPostss(Integer replyId) {
        return iReplyPosts.delReplyPostss(replyId);
    }

    @Override
    public int changeReplyPosts(ReplyPosts replyPosts) {
        return iReplyPosts.changeReplyPosts(replyPosts);
    }

    @Override
    public int changeReplyStatus(Integer replyId, Integer status) {
        return iReplyPosts.changeReplyStatus(replyId,status);
    }

    @Override
    public int changeEssence(Integer replyId, Integer essence) {
        return iReplyPosts.changeEssence(replyId,essence);
    }

    @Override
    public List<ReplyPosts> getAllReplyPosts(Integer postId) {
        return iReplyPosts.getAllReplyPosts(postId);
    }

    @Override
    public List<ReplyPosts> getFirstPosts(Integer postId) {
        return iReplyPosts.getFirstPosts(postId);
    }

    @Override
    public List<ReplyPosts> findAllReplyPosts() {
        return iReplyPosts.findAllReplyPosts();
    }

    @Override
    public ReplyPosts findOneReplyPosts(Integer id) {
        return iReplyPosts.findOneReplyPosts(id);
    }

    @Override
    public int changeReplyPostsStatus(Integer id, Integer status) {
        return iReplyPosts.changeReplyPostsStatus(id,status);
    }

    @Override
    public int delListReply(List<Integer> id) {
        return iReplyPosts.delListReply(id);
    }

    @Override
    public List<ReplyPosts> findReplyByLikeName(String name) {
        return iReplyPosts.findReplyByLikeName(name);
    }

//    @Override
//    public List<ReplyPosts> getRespondPosts(Integer postId, Integer respondId) {
//        return iReplyPosts.getRespondPosts(postId);
//    }
}
