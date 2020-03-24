package com.sc.exam.service;

import com.github.pagehelper.PageInfo;
import com.sc.exam.pojo.Posts;
import com.sc.exam.pojo.User;

import java.util.List;

public interface IPostService {
    PageInfo<Posts> getAllPosts(Integer page, int size);
    //得到所有的帖子
    List<Posts> getPostsByPlate(Integer plateTypeId);
    //获取所有的同一个板块类型的帖子
    List<Posts> getPostsByPlateLimter(Integer plateTypeId);
    //得到一个板块限制数量的帖子
    List<Posts> getEssence();
    //得到所有的精华帖子
    List<Posts> getRoofPlacement();
    //得到所有的置顶帖子
    List<Posts> getRoofPlacementByPlate(Integer plateTypeId);
    //得到一个模块  的置顶帖子
    List<Posts> getEssenceByPlate(Integer plateTypeId);
    //得到一个模块的精华帖子
    int delPost(Integer postid);
    //删除帖子
    int changePostStatus(Integer postid, Integer status);
    //修改帖子状态
    int addPost(Posts posts);
    //增加帖子
    int changePostsEssence(Integer postid, Integer Essence);
    //修改是否为精华帖状态
    int changePostsRoofPlacement(Integer postid, Integer RoofPlacement);
    //修改是否为置顶帖状态
    int changePosts(Posts posts);
    //修改帖子
    int delListPost(List<Integer> id);
    Posts getOnePosts(Integer id);
    //得到一个帖子
    List<Posts> getAllUserPostsByPlate(Integer plateTypeId);
    //得到一个版块可以使用的帖子
    int addPostsTime(Integer postid);
    User getUser(Integer user_id);
    List<Posts>  getHotPosts();
    List<Posts>  getUserPosts();
    List<Posts> findPostByTitle(String title);
    //通过标题去找帖子
    List<Posts>  findPostByTitleAndName(String title, String name);
}
