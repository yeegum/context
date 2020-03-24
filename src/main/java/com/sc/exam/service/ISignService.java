package com.sc.exam.service;

import javax.servlet.http.HttpSession;

public interface ISignService {
    String sign(HttpSession session);
}
