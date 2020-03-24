package com.sc.exam.controller;

import java.io.*;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.github.pagehelper.PageInfo;
import com.sc.exam.pojo.User;
import com.sc.exam.service.IUpdateService;

import com.sc.exam.util.GetAge;
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

@Controller
@RequestMapping("/")
public class UpdateController {
        @Value("${file.uploadFolder}")
        private String path;
        @Autowired
        IUpdateService iUpdateService;
        @RequestMapping("upload")
        public String upload(MultipartFile img, HttpSession session,
                                   String nickname, Integer sex, String introduce, String address,String  birthday, String email) throws ParseException {
                //获取文件保存在服务器端的绝对路径
                User user1 = (User) session.getAttribute("user");
                User user=new User();
//                String path = session.getServletContext().getRealPath("images/");
                if (img != null && !img.isEmpty()) {
                        // 获取图片的文件名
                       String fileName = img.getOriginalFilename();
                        /*// 获取图片的扩展名
                        String extensionName = fileName
                                .substring(fileName.lastIndexOf(".") + 1);
                        // 新的图片文件名 = 获取时间戳+"."图片扩展名
                        //String newFileName = "touxiang" + "." + extensionName;
                        //强转为jpg格式
                        String newFileName = "touxiang" + "." + "jpg";*/
                        File file = new File(path+"faceimg/" + fileName);
                        System.out.println(path + "," + fileName);
                        user.setFaceimg("/upload/faceimg/"+fileName);
                        //写入到服务器端
                        try {
                                img.transferTo(file);
                        } catch (IOException e) {
                                e.printStackTrace();
                        }
                }

                user.setNickname(nickname);
                System.out.println("性别"+sex);
                user.setSex(sex);
                user.setIntroduce(introduce);
                user.setAddress(address);
                user.setEmail(email);
                user.setUserid(user1.getUserid());
                //获得年龄,timestamp格式时间
                if(birthday.length()>0){
                        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                        Date birthday1 = format.parse(birthday);
                        int age =  GetAge.getAgeByBirth(birthday1);
                        System.out.println(age);
                        user.setAge(age);
                        String str =birthday+" "+ "00:00:00";
                        System.out.println(str);
                        Timestamp timestamp=Timestamp.valueOf(str);
                        System.out.println(timestamp);
                        user.setBirthday(timestamp);
                }
                else {
                        user.setAge(0);
                }
                System.out.println("user"+user);
                iUpdateService.updateUser(user);

                return "redirect:/show";
        }
        @RequestMapping("show")
        @ResponseBody
        public ModelAndView show(HttpSession session) throws ParseException {

                System.out.println("得到session"+session);
                User user1 = (User) session.getAttribute("user");
                System.out.println("user1"+user1);
                String account=user1.getAccount();
                ModelAndView mv =new ModelAndView("html/information");
                ViewMsg viewMsg=new ViewMsg();
                User user=iUpdateService.show(account);
                viewMsg.setData(user);
                if(user.getBirthday()!=null){
                        String s= String.valueOf(user.getBirthday());
                        String result = s.substring(0,10);
                        viewMsg.setMsg(result);
                }
                mv.addObject("user",viewMsg);
                return mv;
        }

       @RequestMapping("shows")
        @ResponseBody
        public ViewMsg shows(HttpSession session) throws ParseException {
                User user1 = (User) session.getAttribute("user");
               System.out.println("aa");
               System.out.println("user1"+user1);

                String account=user1.getAccount();
                ModelAndView mv =new ModelAndView("html/information");
                ViewMsg viewMsg=new ViewMsg();
                User user=iUpdateService.show(account);
                viewMsg.setData(user);
                if(user.getBirthday()!=null){
                        String s= String.valueOf(user.getBirthday());
                        String result = s.substring(0,10);
                        viewMsg.setMsg(result);
                }
                return viewMsg;
        }

        @RequestMapping("download")
        public void download(String name, HttpServletRequest req, HttpServletResponse response) {
                //获取文件保存的路径
                String fileName = req.getServletContext().getRealPath("upload/");
                //fileName是要下载文件的磁盘绝对路径
                fileName += "/" + name;
                InputStream f = null;
                System.out.println("要下载的文件是：" + fileName);
                try {
                        f = new FileInputStream(fileName);
                        System.out.println("下载：" + fileName);
                        response.reset();
                        response.setHeader("Content-Disposition",
                                "attachment; filename=\"" + name + "\"");
                        //设置下载文件的大小信息
                        response.addHeader("Content-Length", "" + f.available());
                        //设置文件response返回的内容类型，浏览器接收到这个类型就会以下载文件形式处理
                        response.setContentType("application/octet-stream;charset=UTF-8");
                        OutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
                        //把文件数据写入到outputstream中
                    byte[] b = new byte[1024];
                        int len = f.read(b);
                        while (len != -1) {
                                outputStream.write(b);
                                len = f.read(b);
                        }

                        outputStream.flush();
                        outputStream.close();
                } catch (IOException e1) {
                        // TODO Auto-generated catch block
                        e1.printStackTrace();
                }

        }


    @RequestMapping("page")
    @ResponseBody
    protected PageTable<User> login(@RequestParam(defaultValue = "1", required = false) Integer page,
                                    @RequestParam(defaultValue = "5", required = false) Integer limit,
                                    HttpSession session){


        PageInfo<User> pageInfo=iUpdateService.getList(page,limit);
        PageTable<User> pageTable = new PageTable(0,"",pageInfo.getTotal(),pageInfo.getList());


        return pageTable;
    }

}