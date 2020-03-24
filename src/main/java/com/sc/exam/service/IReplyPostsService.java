package com.sc.exam.service;

import com.sc.exam.pojo.ReplyPosts;


import java.util.List;

public interface IReplyPostsService {
    int addReplyPosts(ReplyPosts replyPosts);
    //增加回复消息
    int delReplyPosts(Integer replyId);
    //删除回复消息
    int delReplyPostss(Integer replyId);
    int changeReplyPosts(ReplyPosts replyPosts);
    //修改回复消息
    int changeReplyStatus(Integer replyId, Integer status);
    //修改回复消息的状态
    int changeEssence(Integer replyId, Integer essence);
    //修改是否为精华评论
    List<ReplyPosts> getAllReplyPosts(Integer postId);

//    List<ReplyPosts> getRespondPosts(Integer postId,Integer respondId);
//    //找到该贴所有第二层的评论,也就是评论评论的评论
    List<ReplyPosts> getFirstPosts(Integer postId);
    //找到该贴所有第一层的评论
    List<ReplyPosts> findAllReplyPosts();
    ReplyPosts  findOneReplyPosts(Integer id);
    //找到一个评论
    int changeReplyPostsStatus(Integer id, Integer status);
    //修改帖子状态
    int delListReply(List<Integer> id);
    //删除多个评论
    List<ReplyPosts> findReplyByLikeName(String name);
    //根据姓名找用户
}
