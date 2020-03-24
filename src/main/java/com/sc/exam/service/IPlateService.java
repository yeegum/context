package com.sc.exam.service;

import com.github.pagehelper.PageInfo;
import com.sc.exam.pojo.Plate;

import java.util.List;

public interface IPlateService {
    List<Plate> getAllPlate();
    //得到所有的模块
    int addPlate(Plate plate);
    //添加Plate模块
    int delPlate(Integer id);
    //删除Plate模块
    int changePlate(Plate plate);

    int delListPlate(List<Integer> id);
    //删除多个模块
    Plate findSingerPlate(Integer id);
    //得到一个模块
    List<Plate> getUserPlate();
    //得到没有被禁用的模块
    List<Plate> likeNamePlate(String plateName);
    int changeStatusPlate(Integer id, Integer status);
}
