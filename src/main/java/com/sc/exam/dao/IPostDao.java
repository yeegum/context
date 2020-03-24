package com.sc.exam.dao;

import com.sc.exam.pojo.Posts;
import com.sc.exam.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.sql.Blob;
import java.util.List;

@Repository
public interface IPostDao {
    List<Posts>  getAllPosts();
    //得到所有的帖子
    List<Posts>  getUserPosts();
    //得到所有的帖子
    List<Posts> getPostsByPlate(Integer plateTypeId);
   //获取所有的同一个板块类型的可用的帖子

    List<Posts> getPostsByPlateLimter(@Param("plateTypeId") Integer plateTypeId);
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
    int delListPost(List<Integer> id);
    //删除多个帖子
    int changePostStatus(@Param("postid") Integer postid, @Param("status") Integer status);
    //修改帖子状态
    int addPost(Posts posts);
    //增加帖子
    int changePostsEssence(@Param("postid") Integer postid, @Param("Essence") Integer Essence);
        //修改是否为精华帖状态
    int changePostsRoofPlacement(@Param("postid") Integer postid, @Param("RoofPlacement") Integer RoofPlacement);
    //修改是否为置顶帖状态
    int changePosts(Posts posts);
    //修改帖子
    Posts getOnePosts(Integer id);
    //得到一个帖子
    List<Posts> getAllUserPostsByPlate(Integer plateTypeId);
    //得到一个版块可以使用的帖子
    int addPostsTime(Integer postid);
    User getUser(Integer user_id);

    List<Posts>  getHotPosts();
    List<Posts>  findPostByTitleAndName(@Param("title") String title, @Param("name") String name);
    //搜索，通过多个条件
    List<Posts> findPostByTitle(String title);
}
