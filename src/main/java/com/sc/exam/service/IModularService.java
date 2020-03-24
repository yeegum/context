package com.sc.exam.service;

import com.github.pagehelper.PageInfo;
import com.sc.exam.pojo.Modular;

import java.util.List;

public interface IModularService {
    List<Modular> getModularByuser(Integer userid);
    List<Modular> getlist();
    public PageInfo<Modular> getpage(Integer page, int size, Modular modular);
    List<Modular> getfm();
    Modular addm(Modular modular);
    Modular updatem(Modular modular);
    Integer deletem(Integer mid);

}
