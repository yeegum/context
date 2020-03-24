package com.sc.exam.service.impl;

import com.sc.exam.dao.IFriendsDao;
import com.sc.exam.pojo.Friends;
import com.sc.exam.pojo.User;
import com.sc.exam.service.IFriendsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FriendsServiceImpl implements IFriendsService {
    @Autowired
    IFriendsDao friendsDao;
    @Override
    public List<User> friendsList(Integer userid) {
        return friendsDao.friendsList(userid);
    }

    @Override
    public List<User> blackList(Integer userid) {
        return friendsDao.blackList(userid);
    }

    @Override
    public List<User> selectStrange(Integer userid) {
        return friendsDao.selectStrange(userid);
    }

    @Override
    public int delFriends(Integer userid1, Integer userid2) {
        return friendsDao.delFriends(userid1, userid2);
    }

    @Override
    public int addBlackList(Integer userid1, Integer userid2) {
        return friendsDao.addBlackList(userid1, userid2);
    }

    @Override
    public List<User> selectWaitFriend(Integer userid) {
        return friendsDao.selectWaitFriend(userid);
    }

    @Override
    public int addFriends(Integer userid1, Integer userid2) {
        return friendsDao.addFriends(userid1,userid2);
    }

    @Override
        public int rejectFriends(Integer userid1, Integer userid2) {
        return friendsDao.rejectFriends(userid1, userid2);
    }

    @Override
    public int addWaitFriend(Friends friends) {
        return friendsDao.addWaitFriend(friends);
    }

    @Override
    public int reFriend(Integer userid1, Integer userid2) {
        return friendsDao.reFriend(userid1,userid2);
    }
}
