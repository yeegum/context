package com.sc.exam.dao;

import com.sc.exam.pojo.Modular;
import com.sc.exam.pojo.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface IModularDao {
    List<Modular> getModularByuser(Integer userid);
    List<Modular> getlist();
    List<Modular> getmodularbyrole(Integer roleid);
    List<Modular> getpage(Modular modular);
    List<Modular> getfm();
    Integer addm(Modular modular);
    Integer addmr(@Param("roleid") Integer roleid, @Param("mid") Integer mid);
    Modular getmbymname(String mname);
    List<Role> getmrbymid(Integer mid);
    Modular getmbymid(Integer mid);
    Integer updatem(Modular modular);
    Integer deletermbymid(Integer mid);
    Integer deletem(Integer mid);
    Integer getrolemodularbyfid(@Param("roleid") Integer roleid, @Param("mid") Integer mid);
}
