package com.sc.exam.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.dao.IModularDao;
import com.sc.exam.pojo.Modular;
import com.sc.exam.service.IModularService;
import com.sc.exam.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ModularServiceImpl implements IModularService {
    @Autowired
    IModularDao modularDao;
    @Autowired
    IRoleService roleService;
    @Override
    public List<Modular> getModularByuser(Integer userid) {
        return modularDao.getModularByuser(userid);
    }

    @Override
    public List<Modular> getlist() {
        return modularDao.getlist();
    }

    @Override
    public PageInfo<Modular> getpage(Integer page, int size, Modular modular) {
        PageHelper.startPage(page,size);
        List<Modular> list=modularDao.getpage(modular);
        PageInfo<Modular> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public List<Modular> getfm() {
        return modularDao.getfm();
    }

    @Override
    public Modular addm(Modular modular) {
        Integer res=modularDao.addm(modular);
        Modular modular1=modularDao.getmbymname(modular.getMname());

        if (modular.getMroleids()!=null) {
            for (int i = 0; i < modular.getMroleids().length; i++) {
                modularDao.addmr(modular.getMroleids()[i], modular1.getMid());
//            if (modularDao.getrolemodularbyfid(modular.getMroleids()[i],modular.getFid())==0);
//                modularDao.addmr(modular.getMroleids()[i],modular1.getFid());
            }

        }

        modular.setMid(modular1.getMid());
        modular.setMroles(modularDao.getmrbymid(modular.getMid()));
        return modular;
    }

    @Override
    public Modular updatem(Modular modular) {
       Integer res=modularDao.updatem(modular);
       modularDao.deletermbymid(modular.getMid());
       if (modular.getMroleids()!=null){
           for (int i = 0; i < modular.getMroleids().length; i++) {
               modularDao.addmr(modular.getMroleids()[i], modular.getMid());
//               if (modularDao.getrolemodularbyfid(modular.getMroleids()[i],modular.getFid())==0);
//               modularDao.addmr(modular.getMroleids()[i],modular.getFid());

           }
       }
        modular.setMroles(modularDao.getmrbymid(modular.getMid()));
       return modular;
    }

    @Override
    public Integer deletem(Integer mid) {
        modularDao.deletermbymid(mid);
       int res= modularDao.deletem(mid);
        return res;
    }
}
