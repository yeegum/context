package com.sc.exam.service.impl;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.dao.IPostDao;
import com.sc.exam.pojo.Plate;
import com.sc.exam.pojo.Posts;
import com.sc.exam.pojo.User;
import com.sc.exam.service.IPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostServiceImpl implements IPostService {
    @Autowired
    IPostDao iPostDao;
    @Override
    public PageInfo<Posts> getAllPosts(Integer page, int size) {
        PageHelper.startPage(page, size);
        List<Posts> list = iPostDao.getAllPosts();
        PageInfo<Posts> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public List<Posts> getPostsByPlate(Integer plateTypeId) {
        return iPostDao.getPostsByPlate(plateTypeId);
    }

    @Override
    public List<Posts> getPostsByPlateLimter(Integer plateTypeId) {
        return iPostDao.getPostsByPlateLimter(plateTypeId);
    }

    @Override
    public List<Posts> getEssence() {
        return iPostDao.getEssence();
    }

    @Override
    public List<Posts> getRoofPlacement() {
        return iPostDao.getRoofPlacement();
    }

    @Override
    public List<Posts> getRoofPlacementByPlate(Integer plateTypeId) {
        return iPostDao.getRoofPlacementByPlate(plateTypeId);
    }

    @Override
    public List<Posts> getEssenceByPlate(Integer plateTypeId) {
        return iPostDao.getEssenceByPlate(plateTypeId);
    }

    @Override
    public int delPost(Integer postid) {
        return iPostDao.delPost(postid);
    }

    @Override
    public int changePostStatus(Integer postid, Integer status) {
        return iPostDao.changePostStatus(postid,status);
    }

    @Override
    public int addPost(Posts posts) {
        return iPostDao.addPost(posts);
    }

    @Override
    public int changePostsEssence(Integer postid, Integer Essence) {
        return iPostDao.changePostsEssence(postid,Essence);
    }

    @Override
    public int changePostsRoofPlacement(Integer postid, Integer RoofPlacement) {
        return iPostDao.changePostsRoofPlacement(postid,RoofPlacement);
    }

    @Override
    public int changePosts(Posts posts) {
        return iPostDao.changePosts(posts);
    }

    @Override
    public int delListPost(List<Integer> id) {
        return iPostDao.delListPost(id);
    }

    @Override
    public Posts getOnePosts(Integer id) {
        return iPostDao.getOnePosts(id);
    }

    @Override
    public List<Posts> getAllUserPostsByPlate(Integer plateTypeId) {
        return iPostDao.getAllUserPostsByPlate(plateTypeId);
    }

    @Override
    public int addPostsTime(Integer postid) {
        return iPostDao.addPostsTime(postid);
    }

    @Override
    public User getUser(Integer user_id) {
        return iPostDao.getUser(user_id);
    }

    @Override
    public List<Posts> getHotPosts() {
        return iPostDao.getHotPosts();
    }

    @Override
    public List<Posts> getUserPosts() {
        return iPostDao.getUserPosts();
    }

    @Override
    public List<Posts> findPostByTitleAndName(String title,String name) {
        return iPostDao.findPostByTitleAndName(title,name);
    }

    @Override
    public List<Posts> findPostByTitle(String title) {
        return iPostDao.findPostByTitle(title);
    }
}
