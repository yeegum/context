package com.sc.exam.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;

@Repository
public interface ISignDao {
    Integer signCountBytime(Integer userid);
    Integer getSignByUserid(Integer userid);
    Integer addSign(Integer userid);
    Integer updateSign(@Param(value = "userid") Integer userid, @Param(value = "signTime") Timestamp signTime);
}
