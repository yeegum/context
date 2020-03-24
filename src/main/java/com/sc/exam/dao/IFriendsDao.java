package com.sc.exam.dao;

import com.sc.exam.pojo.Friends;
import com.sc.exam.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface IFriendsDao {
    List<User> friendsList(@Param("userid") Integer userid);
    List<User> blackList(@Param("userid") Integer userid);
    List<User> selectStrange(@Param("userid") Integer userid);
    int delFriends(@Param("userid1") Integer userid1, @Param("userid2") Integer userid2);
    int addBlackList(@Param("userid1") Integer userid1, @Param("userid2") Integer userid2);
    List<User> selectWaitFriend(@Param("userid") Integer userid);
    int addFriends(@Param("userid1") Integer userid1, @Param("userid2") Integer userid2);
    int rejectFriends(@Param("userid1") Integer userid1, @Param("userid2") Integer userid2);
    int addWaitFriend(Friends friends);
    int reFriend(@Param("userid1") Integer userid1,@Param("userid2") Integer userid2);
}
