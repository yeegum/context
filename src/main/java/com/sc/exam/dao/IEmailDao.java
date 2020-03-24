package com.sc.exam.dao;


import com.sc.exam.pojo.Email;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
/*为什么 @Repository 只能标注在 DAO 类上呢？这是因为该注解的作用不只是将类识别为Bean，
同时它还能将所标注的类中抛出的数据访问异常封装为 Spring 的数据访问异常类型。
 Spring本身提供了一个丰富的并且是与具体的数据访问技术无关的数据访问异常结构，
 用于封装不同的持久层框架抛出的异常，使得异常独立于底层的框架。
*/
public interface IEmailDao {
    List<Email> getRecvEmailList(@Param("userid") Integer userid);
    int readRecvEmail(@Param("userid") Integer userid, @Param("id") Integer id);
    int delRecvEmail(@Param("userid") Integer userid, @Param("id") Integer id);
    List<Email> getSendEmailList(@Param("userid") Integer userid);
    int readSendEmail(@Param("userid") Integer userid, @Param("id") Integer id);
    int delSendEmail(@Param("userid") Integer userid, @Param("id") Integer id);
    List<Email> getRecycleEmailList(@Param("userid") Integer userid);
    int recovery(@Param("id") Integer id);
    int sendEmail(Email email);
}
