package com.sc.exam.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.dao.IUsersDao;
import com.sc.exam.pojo.Plate;
import com.sc.exam.pojo.Posts;
import com.sc.exam.pojo.ReplyPosts;
import com.sc.exam.pojo.User;
import com.sc.exam.service.IPlateService;
import com.sc.exam.service.IPostService;
import com.sc.exam.service.IReplyPostsService;
import com.sc.exam.vo.PageTable;
import com.sc.exam.vo.ViewMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/management/Posts")
public class PostsHandle {
    @Autowired
    IPostService iPostService;
    @Autowired
    IPlateService iPlateService;
    @Autowired
    IReplyPostsService iReplyPosts;
    @Autowired
    IUsersDao iUsersDao;
    @Value("${file.uploadFolder}")
    private String path;

    @RequestMapping("getAllPosts")
    @ResponseBody
    private PageTable<Posts> getAllPosts(@RequestParam(defaultValue = "1", required = false) Integer page,
                                         @RequestParam(defaultValue = "5", required = false) Integer limit, HttpSession session,
                                         HttpServletResponse response) throws IOException {
        PageInfo<Posts> pageInfo = iPostService.getAllPosts(page, limit);
        PageTable<Posts> pageTable = new PageTable(0, "", pageInfo.getTotal(),pageInfo.getList());
//        pageTable.setData();
//        pageTable.setData(pageInfo.getList());

        return pageTable;
    }

    @RequestMapping("addPosts")
    private ModelAndView addPosts(Posts posts, @RequestParam(name = "img", required = false) MultipartFile img,
                                  HttpSession session) throws IOException {
        User user= (User) session.getAttribute("user");
//        posts.setUser_id(user.getUserid());
//        User users=iPostService.getUser(user.getUserid());
        posts.setUser_name(user.getNickname());
        posts.setUser_id(user.getUserid());
//


        System.out.println("-----------------------------------------------");
        System.out.println(user);
       if (img!= null) {
           File file = new File(path + img.getOriginalFilename());
           try {
               img.transferTo(file);
           } catch (IOException e) {
//            e.printStackTrace();
           }
           //以绝对路径保存重名命后的图片
           //把图片存储路径保存到数据库
           posts.setPost_image("/upload/" + img.getOriginalFilename());
       }
        Integer integral = iUsersDao.getUserById(user.getUserid()).getIntegral();
        iUsersDao.addIntegral(user.getUserid(),12+integral);
        iPostService.addPost(posts);
//        System.out.println(11111);
        ModelAndView modelAndView = new ModelAndView("html/forum_inside");
        List<Plate> list = iPlateService.getUserPlate();
        System.out.println(list);
        modelAndView.addObject("Platelist", list);
        List<Posts> hotPosts=iPostService.getHotPosts();
        modelAndView.addObject("hotPosts",hotPosts);
        return modelAndView;
    }

    @RequestMapping("delPosts")
    @ResponseBody
    private ViewMsg delPosts(Integer id) {
        ViewMsg viewMsg = new ViewMsg();
        if (iPostService.delPost(id) > 0) {
            viewMsg.setCode(1);
            viewMsg.setMsg("删除成功");
        } else {
            viewMsg.setCode(2);
            viewMsg.setMsg("删除失败");
        }
        return viewMsg;
    }

    @RequestMapping("delListPost")
    @ResponseBody
    private ViewMsg delListPlate(Integer[] ids) {
        //删除多个模块
        System.out.println(ids);
        ViewMsg viewMsg = new ViewMsg();
        int i = iPostService.delListPost(Arrays.asList(ids));
        if (i > 0) {
            viewMsg.setCode(1);
            viewMsg.setMsg("删除帖子成功");
        } else {
            viewMsg.setCode(2);
            viewMsg.setMsg("删除失败");
        }
        return viewMsg;
    }

    @RequestMapping("findPosts")
    private ModelAndView findPlate(Integer id, HttpSession session) {
        Posts posts = iPostService.getOnePosts(id);
        System.out.println(posts);
        ModelAndView modelAndView = new ModelAndView("html/Post");
//        List<Plate> plates=iPlateService.getAllPlate();
        session.setAttribute("posts", posts);
//        session.setAttribute("plates", plates);
        return modelAndView;
    }
    @RequestMapping("findPostsdemo")
    @ResponseBody
    private ModelAndView findPlatedemo(Integer id, HttpSession session) {
        Posts posts = iPostService.getOnePosts(id);
        System.out.println(posts);
        ModelAndView modelAndView = new ModelAndView("management/post-change");
        session.setAttribute("posts", posts);
        return modelAndView;
    }
    //    @RequestMapping("getLimitPosts")
//    @ResponseBody
//    private ViewMsg getLimitPosts(Integer id) {
//        //得到受数量限制可以用的帖在
//        ViewMsg viewMsg = new ViewMsg();
//        List<Posts> list= iPostService.getPostsByPlateLimter(id);
//        viewMsg.setCode(5);
//        viewMsg.setData(list);
//        return viewMsg;
//    }
    @RequestMapping("getPostsByPlate")
    @ResponseBody
    private ModelAndView getPostsByPlate(@RequestParam(defaultValue = "1", required = false) Integer page,
                                          Integer id, HttpSession session) {
        //得到数量限制可以用的帖在
        ModelAndView modelAndView = new ModelAndView("html/PostsPage");
        List<Posts> rooflist=iPostService.getRoofPlacementByPlate(id);
        PageHelper.startPage(page, 10);
        List<Posts> list = iPostService.getPostsByPlate(id);
        int  plate_id = 0;
        for (Posts p:
                list ) {
            plate_id=p.getPlate_typeid();
            System.out.println(plate_id);
            modelAndView.addObject("plate_id", plate_id);
            break;
        }
        PageInfo<Posts> pageInfo = new PageInfo<>(list);
        PageTable<Posts> pageTable = new PageTable(0, "", pageInfo.getTotal(),pageInfo.getList());
//        pageTable.setData();
        //分页
        List<Plate> Platelist = iPlateService.getUserPlate();
        modelAndView.addObject("Platelist",Platelist);
        List<Posts> hotPosts=iPostService.getHotPosts();
        modelAndView.addObject("hotPosts",hotPosts);
        session.setAttribute("pageInfo", pageInfo);
        modelAndView.addObject("list", pageInfo.getList());
        modelAndView.addObject("rooflist",rooflist);
        return modelAndView;
    }

    @RequestMapping("getPostAndReplyPost")
    @ResponseBody
//    需要session，找两个，一个找作者
    private ModelAndView getPostAndReplyPost(@RequestParam(defaultValue = "1", required = false) Integer page,
                                             Integer post_id, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("html/Posts");

        System.out.println(post_id);
        Posts posts = iPostService.getOnePosts(post_id);
        //得到这个帖子
        PageHelper.startPage(page, 10);
        List<ReplyPosts> list = iReplyPosts.getFirstPosts(post_id);
       //得到第一层评论
        List<ReplyPosts> allList=iReplyPosts.getAllReplyPosts(post_id);
        //得到所有评论
        iPostService.addPostsTime(post_id);
        //给这个post的次数加一；
        //得到这个贴子所以的评论
//        User PostUser=
//        User postUser = new User();
////        postUser.setAccount("吴和成");
//////        User user=new User();
////        postUser.setUserid(26);
////        User user = new User();
////        user.setUserid(26);
////        user.setNickname("吴和成");
//        User postUser = (User) session.getAttribute("user");
        User postUser = iPostService.getUser(post_id);

        PageInfo<ReplyPosts> pageInfo = new PageInfo<>(list);
        PageTable<ReplyPosts> pageTable = new PageTable(0, "", pageInfo.getTotal(),pageInfo.getList());
//        pageTable.setData();
        //分页
        session.setAttribute("pageInfo", pageInfo);
//        modelAndView.addObject("list", pageInfo.getList());
//        modelAndView.addObject("user", user);
        modelAndView.addObject("postUser", postUser);
        //设置作者
        modelAndView.addObject("posts", posts);
        modelAndView.addObject("replyPosts", pageInfo.getList());
        modelAndView.addObject("sreplyPosts",allList);
        List<Posts> hotPosts=iPostService.getHotPosts();
        modelAndView.addObject("hotPosts",hotPosts);
        return modelAndView;
    }

    @RequestMapping("addReplyPost")
    @ResponseBody
    private ViewMsg addReplyPost(ReplyPosts replyPosts,HttpSession session) {
        ViewMsg viewMsg = new ViewMsg();
        //点击一次帖子的次数加一
        User user = (User) session.getAttribute("user");
        replyPosts.setUser_name(user.getNickname());
        replyPosts.setUser_id(user.getUserid());

//        查询  后 在添加

        Integer integral = iUsersDao.getUserById(user.getUserid()).getIntegral();
        iUsersDao.addIntegral(user.getUserid(),2+integral);
        //加积分
        int n = iReplyPosts.addReplyPosts(replyPosts);
        if (n > 0) {
            viewMsg.setCode(1);
            viewMsg.setMsg("评论成功，本次添加2积分");
        } else {
            viewMsg.setCode(2);
            viewMsg.setMsg("评论失败");
        }
        return viewMsg;
    }
    @RequestMapping("getEssencePost")
    @ResponseBody
    private ViewMsg getEssencePost() {
        ViewMsg viewMsg = new ViewMsg();
        //点击一次帖子的次数加一
        List<Posts> list=iPostService.getEssence();
        viewMsg.setCode(list.size());
        viewMsg.setData(list);
        return viewMsg;
    }
    @RequestMapping("getHotPost")
    @ResponseBody
    private ViewMsg getHotPost() {
        ViewMsg viewMsg = new ViewMsg();
        //点击一次帖子的次数加一
        List<Posts> list=iPostService.getHotPosts();
        viewMsg.setCode(list.size());
        viewMsg.setData(list);
        return viewMsg;
    }
    @RequestMapping("changePost")
    @ResponseBody
    private String changePost(Posts posts,@RequestParam(name = "img", required = false) MultipartFile img,
                              HttpSession session) {
        if (img!= null) {
            File file = new File(path + img.getOriginalFilename());
            try {
                img.transferTo(file);
            } catch (IOException e) {
//            e.printStackTrace();
            }
            //以绝对路径保存重名命后的图片
            //把图片存储路径保存到数据库
            posts.setPost_image("/upload/" + img.getOriginalFilename());
        }
        int n=iPostService.changePosts(posts);
        if (n>0){
            return "修改成功";}
        return "修改失败";
    }

    @RequestMapping("findPostByTitleAndName")
    private ModelAndView findPostByTitleAndName(Posts posts,HttpSession session) {
        Posts posts1=new Posts();
        ModelAndView modelAndView=new ModelAndView("html/ShowPosts");
        String title=posts.getPost_title();
        title="%"+title+"%";
        posts1.setPost_title(title);
        String name=posts.getUser_name();
        //带条件的搜索
        name="%"+name+"%";
        posts1.setUser_name(name);
//        User user=new User();
//        user.setUserid(26);
//        user.setNickname("111");
//        session.setAttribute("user",user);
        List<Posts> post=iPostService.findPostByTitleAndName(title,name);
        modelAndView.addObject("list",post);
        List<Posts> hotPosts=iPostService.getHotPosts();
        List<Plate> Platelist = iPlateService.getUserPlate();
        modelAndView.addObject("Platelist",Platelist);
        modelAndView.addObject("hotPosts",hotPosts);
        return modelAndView;
    }


    @RequestMapping("changeStatus")
    @ResponseBody
    public ViewMsg changeStatus(Integer id) throws IOException {
        ViewMsg viewMsg=new ViewMsg();
        Posts posts=iPostService.getOnePosts(id);

        if (posts.getPost_status()==1){
            posts.setPost_status(0);
        }else {
            posts.setPost_status(1);
        }
        int n=iPostService.changePostStatus(id,posts.getPost_status());
        if (n>0) {
            viewMsg.setMsg("修改状态成功");
        }else {
            viewMsg.setMsg("修改状态失败");
        }
        return viewMsg;
    }
    @RequestMapping("changeEssence")
    @ResponseBody
    public ViewMsg changeessence(Integer id) throws IOException {
        ViewMsg viewMsg=new ViewMsg();
        Posts posts=iPostService.getOnePosts(id);

        if (posts.getPost_essence()==1){
            posts.setPost_essence(0);
        }else {
            posts.setPost_essence(1);
        }
      int n= iPostService.changePostsEssence(id,posts.getPost_essence());
      if (n>0) {
          viewMsg.setMsg("修改状态成功");
      }else {
          viewMsg.setMsg("修改状态失败");
      }
        return viewMsg;
    }
    @RequestMapping("changePost_roof_placement")
    @ResponseBody
    public ViewMsg changePost_roof_placement(Integer id) throws IOException {
        ViewMsg viewMsg=new ViewMsg();
        Posts posts=iPostService.getOnePosts(id);

        if (posts.getPost_roof_placement()==1){
            posts.setPost_roof_placement(0);
        }else {
            posts.setPost_roof_placement(1);
        }
        int n=iPostService.changePostsRoofPlacement(id,posts.getPost_roof_placement());
        if (n>0) {
            viewMsg.setMsg("修改状态成功");
        }else {
            viewMsg.setMsg("修改状态失败");
        }
        return viewMsg;
    }
    @RequestMapping("findPostByTitle")
    @ResponseBody
    public PageTable<Posts> findPostByTitle(String  likename,@RequestParam(defaultValue = "1", required = false) Integer page,
                                       @RequestParam(defaultValue = "3", required = false) Integer limit, HttpSession session){
        PageHelper.startPage(page, limit);
        String name="%"+likename+"%";
        List<Posts> list = iPostService.findPostByTitle(name);
        PageInfo<Posts> pageInfo = new PageInfo<>(list);
        PageTable<Posts> pageTable = new PageTable(0, "", pageInfo.getTotal(),pageInfo.getList());
//        pageTable.setData();
//        pageTable.setData(pageInfo.getList());
        return pageTable;
    }

}
