package com.sc.exam.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.dao.IModularDao;
import com.sc.exam.dao.IRoleDao;
import com.sc.exam.pojo.Modular;
import com.sc.exam.pojo.Role;
import com.sc.exam.service.IRoleService;
import com.sc.exam.util.util;
import com.sc.exam.vo.ViewMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

import static com.sc.exam.util.util.removeDuplicate;

@Service
public class RoleServiceImpl implements IRoleService {
    @Autowired
    IRoleDao roleDao;
    @Autowired
    IModularDao modularDao;
    @Override
    public List<Role> getList() {
        return roleDao.getList();
    }

    @Override
    public List<Role> getRoleByuser(Integer userid) {
        return roleDao.getRoleByuser(userid);
    }

    @Override
    public PageInfo<Role> getroleList(Integer page, int size, Role role) {
        PageHelper.startPage(page,size);
        List<Role> list=roleDao.getpagelist(role);
        PageInfo<Role> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public ViewMsg<Role> addrole(Role role) {
        ViewMsg viewMsg=new ViewMsg();
         Integer res=roleDao.addrole(role);
        Role role1=roleDao.getrolebyname(role.getRolename());
        Modular modular=new Modular();
        List<Integer> ids=new ArrayList<>();
        if (role.getMids()!=null) {
            for (int i = 0; i < role.getMids().length; i++) {
                modular = modularDao.getmbymid(role.getMids()[i]);
                if (modular.getFid() == 0) {
                    ids.add(modular.getMid());
                }
                {
                    ids.add(modular.getFid());
                    ids.add(modular.getMid());
                }
            }
            List<Integer> ids2 = util.removeDuplicate(ids);

            for (int i = 0; i < ids2.size(); i++) {
                roleDao.addrolemodular(role1.getRoleid(), ids.get(i));
            }
        }
        Role role2=new Role();
        role2.setRoleid(role1.getRoleid());
        role2.setRolename(role1.getRolename());
        role2.setModularList(modularDao.getmodularbyrole(role1.getRoleid()));
        if (res==1){
            viewMsg.setCode(600);
            viewMsg.setMsg("成功");
            viewMsg.setData(role2);
            return viewMsg;
        }
        return null;
    }

    @Override
    public Integer deleterole(Integer roleid) {
     Integer res=roleDao.deleterole(roleid);
        System.out.println(roleid);
        Integer res2=roleDao.deleterolemodular(roleid);
        System.out.println(res2);
        return res;
    }

    @Override
    public Role getonebyroleid(Integer roleid) {
        return roleDao.getonebyroleid(roleid);
    }

    @Override
    public Role updaterole(Role role) {
        Integer res=roleDao.updaterole(role);
        roleDao.deleterolemodular(role.getRoleid());
        Modular modular=new Modular();
        List<Integer> ids=new ArrayList<>();
        if (role.getMids()!=null) {
            for (int i = 0; i < role.getMids().length; i++) {
                modular = modularDao.getmbymid(role.getMids()[i]);
                if (modular.getFid() == 0) {
                    ids.add(modular.getMid());
                }
                {
                    ids.add(modular.getFid());
                    ids.add(modular.getMid());
                }
            }
            List<Integer> ids2 = util.removeDuplicate(ids);

            for (int i = 0; i < ids2.size(); i++) {
                roleDao.addrolemodular(role.getRoleid(), ids.get(i));
            }
        }
        Role role1=roleDao.getonebyroleid(role.getRoleid());
        role1.setModularList(modularDao.getmodularbyrole(role.getRoleid()));
        return role1;
    }
}
