package com.sc.exam.service;

import com.github.pagehelper.PageInfo;
import com.sc.exam.pojo.Role;
import com.sc.exam.vo.ViewMsg;

import java.util.List;

public interface IRoleService {
    List<Role> getList();

    List<Role> getRoleByuser(Integer userid);

    public PageInfo<Role> getroleList(Integer page, int size, Role role);

    ViewMsg<Role> addrole(Role role);
    Integer deleterole(Integer roleid);
    Role getonebyroleid(Integer roleid);
    Role updaterole(Role role);
}
