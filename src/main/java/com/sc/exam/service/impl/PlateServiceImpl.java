package com.sc.exam.service.impl;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.dao.IPlateDao;
import com.sc.exam.pojo.Plate;
import com.sc.exam.service.IPlateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class PlateServiceImpl implements IPlateService {
    @Autowired
    private  IPlateDao iPlateDao;
    @Override
    public List<Plate> getAllPlate() {
        List<Plate> list = iPlateDao.getAllPlate();
        return list;
    }

    @Override
    public int addPlate(Plate plate) {
        return iPlateDao.addPlate(plate);
    }

    @Override
    public int delPlate(Integer id) {
        return iPlateDao.delPlate(id);
    }


    @Override
    public int changePlate(Plate plate) {
        return iPlateDao.changePlate(plate);
    }

    @Override
    public int delListPlate(List<Integer> id) {
        System.out.println(id.size());
        return iPlateDao.delListPlate(id);
    }

    @Override
    public Plate findSingerPlate(Integer id) {
        return iPlateDao.findSingerPlate(id);
    }

    @Override
    public List<Plate> getUserPlate() {
        return iPlateDao.getUserPlate();
    }

    @Override
    public List<Plate> likeNamePlate(String plateName) {
        return iPlateDao.likeNamePlate(plateName);
    }

    @Override
    public int changeStatusPlate(Integer id, Integer status) {
        return iPlateDao.changeStatusPlate(id,status);
    }
}
