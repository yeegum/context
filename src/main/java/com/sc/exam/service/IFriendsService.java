package com.sc.exam.service;


import com.github.pagehelper.PageInfo;
import com.sc.exam.pojo.Friends;
import com.sc.exam.pojo.User;
import com.sc.exam.vo.PageTable;
import org.apache.ibatis.annotations.Param;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface IFriendsService {
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
