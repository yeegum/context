package com.sc.exam.dao;

import com.sc.exam.pojo.Plate;
import com.sc.exam.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface IPlateDao {
    List<Plate> getAllPlate();
    //得到所有的模块
    int addPlate(Plate plate);
    //添加Plate模块
    int delPlate(Integer id);
    //删除Plate模块
    int changeStatusPlate(@Param("id") Integer id, @Param("status") Integer status);
    //修改模块状态
    int changePlate(Plate plate);
    //修改模块
    int delListPlate(List<Integer> id);
    //删除多个模块
    Plate findSingerPlate(Integer id);
    //得到一个模块
    List<Plate> getUserPlate();
    //得到没有被禁用的模块
    List<Plate> likeNamePlate(String plateName);
    //通过名字模块
}
