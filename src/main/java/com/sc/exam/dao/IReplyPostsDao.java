package com.sc.exam.dao;

import com.sc.exam.pojo.ReplyPosts;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IReplyPostsDao {
    int addReplyPosts(ReplyPosts replyPosts);
    //增加回复消息
    int delReplyPosts(Integer replyId);
    //删除回复消息
    int delReplyPostss(Integer replyId);
    int changeReplyPosts(ReplyPosts replyPosts);
    //修改回复消息
    int changeReplyStatus(@Param("replyId") Integer replyId, @Param("status") Integer status);
    //修改回复消息的状态
    int changeEssence(@Param("replyId") Integer replyId, @Param("essence") Integer essence);
    //修改是否为精华评论
    List<ReplyPosts> getAllReplyPosts(@Param("postId") Integer postId);
    //找到该贴所有的评论
    List<ReplyPosts> getFirstPosts(Integer postId);
    //找到该贴所有第二层的评论,也就是评论评论的评论
    List<ReplyPosts> findAllReplyPosts();
    //找到该贴所有的评论
    ReplyPosts  findOneReplyPosts(Integer id);
    //找到一个评论
    int changeReplyPostsStatus(@Param("id") Integer id, @Param("status") Integer status);
    //修改帖子状态
    int delListReply(List<Integer> id);
    //删除多个评论
    List<ReplyPosts> findReplyByLikeName(String name);
}
