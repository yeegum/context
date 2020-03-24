package com.sc.exam.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.pojo.Friends;
import com.sc.exam.pojo.User;
import com.sc.exam.service.IFriendsService;
import com.sc.exam.vo.PageTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/management")
public class FriendsHandler {
    @Autowired
    IFriendsService friendsService;

    @RequestMapping("friends")
    @ResponseBody
    public PageTable friendsPageTable(@RequestParam(defaultValue = "1",required = false) Integer page,
                                      @RequestParam(defaultValue = "2",required = false)Integer limit,
                                      HttpSession session){
//        session.setAttribute("userid",1);
        User user = (User) session.getAttribute("user");
        if(user==null){
            return new PageTable();
        }
        Integer myuserid = user.getUserid();
        PageHelper.startPage(page,limit);
        List<User> friendsList = friendsService.friendsList(myuserid);
        PageInfo<User> pageInfo=new PageInfo<>(friendsList);
        PageTable<User> pageTable=new PageTable<>(0,"",pageInfo.getTotal(),pageInfo.getList());
        return pageTable;
    }
    @RequestMapping("delFriends")
    @ResponseBody
    public int delOne(Integer userid,HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return -1;
        }
        Integer myuserid = user.getUserid();
        return friendsService.delFriends(userid, (Integer) myuserid);
    }
    @RequestMapping("addBlackList")
    @ResponseBody
    public int addBlackList(Integer userid,HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return -1;
        }
        Integer myuserid = user.getUserid();
        return friendsService.addBlackList(userid, (Integer) myuserid);
    }
    @RequestMapping("strange")
    @ResponseBody
    public PageTable strangePageTable(@RequestParam(defaultValue = "1",required = false) Integer page,
                                      @RequestParam(defaultValue = "2",required = false) Integer limit,
                                     HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return new PageTable();
        }
        Integer myuserid = user.getUserid();
        PageHelper.startPage(page,limit);
        List<User> strangeList = friendsService.selectStrange((Integer) myuserid);
        PageInfo<User> pageInfo=new PageInfo<>(strangeList);
        PageTable pageTable=new PageTable(0,"",pageInfo.getTotal(),pageInfo.getList());
        return pageTable;
    }
    @RequestMapping("blackList")
    @ResponseBody
    public PageTable blackListPageTable(@RequestParam(defaultValue = "1",required = false) Integer page,
                                        @RequestParam(defaultValue = "5",required = false) Integer limit,
                                        HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return new PageTable();
        }
        Integer myuserid = user.getUserid();
        PageHelper.startPage(page,limit);
        List<User> blackList = friendsService.blackList((Integer) myuserid);
        PageInfo<User> pageInfo=new PageInfo<>(blackList);
        PageTable pageTable=new PageTable(0,"",pageInfo.getTotal(),pageInfo.getList());
        return pageTable;
    }
    @RequestMapping("waitFriendList")
    @ResponseBody
    public PageTable waitFriendListPageTable(@RequestParam(defaultValue = "1",required = false) Integer page,
                                             @RequestParam(defaultValue = "5",required = false) Integer limit,
                                             HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return new PageTable();
        }
        Integer myuserid = user.getUserid();
        PageHelper.startPage(page,limit);
        List<User> waitFriendList = friendsService.selectWaitFriend((Integer) myuserid);
        PageInfo<User> pageInfo=new PageInfo<>(waitFriendList);
        PageTable pageTable=new PageTable(0,"",pageInfo.getTotal(),pageInfo.getList());
        return pageTable;
    }
    @RequestMapping("addFriends")
    @ResponseBody
    public int addFriends(Integer userid1,Integer userid2){
        return friendsService.addFriends(userid1, userid2);
    }
    @RequestMapping("rejectFriends")
    @ResponseBody
    public int rejectFriends(Integer userid1,Integer userid2){
        return friendsService.rejectFriends(userid1, userid2);
    }
    @RequestMapping("addWaitFriend")
    @ResponseBody
    public int addWaitFriend(HttpSession session,Integer applied_userid){
        Friends friends=new Friends();

        User user = (User) session.getAttribute("user");
        if(user==null){
            return -1;
        }
        Integer myuserid = user.getUserid();
        friends.setApply_userid((Integer) myuserid);
        friends.setApplied_userid(applied_userid);
        return friendsService.addWaitFriend(friends);

    }

    @RequestMapping("refriend")
    @ResponseBody
    public int refriend(Integer userid,HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user==null){
            return -1;
        }
        Integer myuserid = user.getUserid();
        return friendsService.reFriend((Integer) myuserid,userid);
    }

}
