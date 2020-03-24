package com.sc.exam.dao;

import com.sc.exam.pojo.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface IRoleDao {
    List<Role> getList();
    List<Role> getRoleByuser(Integer userid);
    Integer deleterolebyuser(Integer userid);
    Integer addroleuser(@Param("userid") Integer userid, @Param("roleid") Integer roleid);
    List<Role> getpagelist(Role role);
    Integer addrole(Role role);
    Integer addrolemodular(@Param("roleid") Integer roleid, @Param("mid") Integer mid);
    Role getrolebyname(String rolename);
    Integer deleterole(Integer roleid);
    Integer deleterolemodular(Integer roleid);
    Role getonebyroleid(Integer roleid);
    Integer updaterole(Role role);
}
