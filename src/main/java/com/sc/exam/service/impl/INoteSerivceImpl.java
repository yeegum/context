package com.sc.exam.service.impl;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.dao.INoteDao;
import com.sc.exam.pojo.Note;
import com.sc.exam.pojo.ov.Notes;
import com.sc.exam.pojo.Notetype;
import com.sc.exam.pojo.User;
import com.sc.exam.service.INoteService;
import com.sc.exam.vo.ViewMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;


@SuppressWarnings("ALL")
@Service
public class INoteSerivceImpl implements INoteService {

    @Autowired
    INoteDao iNoteDao;

    static int re = 1;

    @Value("${file.uploadFolder}")
    private String path;

    @Override
    public ViewMsg upload(@RequestParam("title") String title, @RequestParam("type") String type, @RequestParam("note") MultipartFile note, HttpSession session) {
        System.out.println(title);
        System.out.println(type);
        System.out.println(note.getOriginalFilename());
        ViewMsg viewMsg = new ViewMsg();
        viewMsg.setCode(0);
        viewMsg.setMsg("上传失败!");
        User user = (User) session.getAttribute("user");
        Note note1 = new Note();
        if (type != null) {
            note1.setUserid(user.getUserid());
            note1.setTitle(title);
            String filename;
            if (iNoteDao.existnote(note.getOriginalFilename()) == null) {
                filename = note.getOriginalFilename();
            } else {
                filename = (re++) + note.getOriginalFilename();
            }
            note1.setPath(filename);
            note1.setSid(0);
            note1.setSubtime(new Timestamp(System.currentTimeMillis()));
            note1.setTid(Integer.parseInt(type));
            note1.setTimes(0);
            int addnote = iNoteDao.AddNote(note1);
            if (addnote == 1) {
                File file = new File(path + filename);
                try {
                    note.transferTo(file);
                } catch (IOException e) {
                    e.printStackTrace();
                }
                viewMsg.setCode(1);
                viewMsg.setMsg("上传成功！等待审核中");
                System.out.println(viewMsg);
                return viewMsg;
            }
        }
        System.out.println(viewMsg);
        return viewMsg;
    }

    @SuppressWarnings("AliDeprecation")
    @Override
    public ModelAndView doShow(String uid, String page, String status, String url, HttpSession session) {
        ModelAndView mv = new ModelAndView(url);
        String title = (String) session.getAttribute("title");
        String t = (String) session.getAttribute("tid");
        System.out.println(title + "....." + t);
        int tid = 0;
        if (t != "" && t != null) {
            tid = Integer.parseInt(t);
        }
        List<Notetype> notetypes = iNoteDao.getNoteType();
        int sid = 1;
        if (status != null) {
            sid = Integer.parseInt(status);
        }
        int pa = 1;
        if (page != null) {
            pa = Integer.parseInt(page);
        }
        int userid = 0;
        if (uid != "" && uid != null) {
            userid = Integer.parseInt(uid);
        }
        PageHelper.startPage(pa, 7, "subtime desc");
        List<Notes> notes = iNoteDao.getNotes(sid, userid, title, tid);
        PageInfo<Notes> pageInfo = new PageInfo<>(notes);
        if (pageInfo.getNextPage() == 0) {
            //noinspection AliDeprecation
            pageInfo.setNextPage(pageInfo.getLastPage());
        }
        mv.addObject("pageInfo", pageInfo);
        mv.addObject("types", notetypes);

        return mv;
    }

    @Override
    public ViewMsg ChangeStatus(String nid, String sid) {
        ViewMsg viewMsg = new ViewMsg();
        viewMsg.setCode(0);
        viewMsg.setMsg("未知错误!");
        if (nid != null && sid != null) {
            Note note = new Note();
            note.setNid(Integer.parseInt(nid));
            note.setSid(Integer.parseInt(sid));
            if (iNoteDao.changStatus(note) == 1) {
                viewMsg.setCode(1);
                viewMsg.setMsg("审核成功!");
                return viewMsg;
            }
        }
        return viewMsg;
    }

    @Override
    public ViewMsg delAll(List<Integer> idList) {
        ViewMsg viewMsg = new ViewMsg();
        viewMsg.setCode(0);
        viewMsg.setMsg("删除失败!");
        if (iNoteDao.changeAllstauts(idList, 3) > 0) {
            for (int nid : idList) {
                Note note = iNoteDao.getNoteById(nid);
                File file = new File(path + note.getPath());
                if (file.exists()) {
                    file.delete();
                }
            }
            viewMsg.setCode(1);
            viewMsg.setMsg("删除成功!");
            return viewMsg;
        }
        return viewMsg;
    }

    @Override
    public ViewMsg changeStautsAll(List<Integer> idList, String sid) {
        ViewMsg viewMsg = new ViewMsg();
        viewMsg.setCode(0);
        viewMsg.setMsg("审核失败!");
        if (sid != null) {
            if (iNoteDao.changeAllstauts(idList, Integer.parseInt(sid)) > 0) {
                viewMsg.setCode(1);
                viewMsg.setMsg("审核成功!");
                return viewMsg;
            }
        }
        return viewMsg;
    }

    @Override
    public ViewMsg dodel(String nid) {
        ViewMsg viewMsg = new ViewMsg();
        viewMsg.setCode(0);
        viewMsg.setMsg("删除失败!");
        if (nid != null) {
            int n = Integer.parseInt(nid);
            Note note = iNoteDao.getNoteById(n);
            if (note != null) {
                File file = new File(path + note.getPath());
                if (file.exists() && iNoteDao.delNoteById(n) > 0) {
                    file.delete();
                    viewMsg.setCode(1);
                    viewMsg.setMsg("删除成功!");
                    return viewMsg;
                } else {
                    int del = iNoteDao.delNoteById(n);
                    viewMsg.setCode(1);
                    viewMsg.setMsg("记录已删除!");
                    return viewMsg;
                }
            }
        }
        return viewMsg;
    }

    @Override
    public ModelAndView doForChange(String nid) {
        ModelAndView mv = new ModelAndView("management/admin-note-edit");
        if (nid != null) {
            Note note = iNoteDao.getNoteById(Integer.parseInt(nid));
            List<Notetype> notetypes = iNoteDao.getNoteType();
            mv.addObject("note", note);
            mv.addObject("types", notetypes);
        }
        return mv;
    }

    @Override
    public ViewMsg doChange(String tid, String nid, String title) {
        ViewMsg viewMsg = new ViewMsg();
        viewMsg.setCode(0);
        viewMsg.setMsg("修改失败!");
        if (nid != null && tid != null) {
            Note note = new Note();
            note.setNid(Integer.parseInt(nid));
            note.setTitle(title);
            note.setTid(Integer.parseInt(tid));
            if (iNoteDao.ChangeNoteByNid(note) == 1) {
                viewMsg.setCode(1);
                viewMsg.setMsg("修改成功!");
                return viewMsg;
            }
        }
        return viewMsg;
    }

    @Override
    public void download(String nid, HttpServletRequest req, HttpServletResponse response) {
        if (nid != null) {
            Note note = iNoteDao.getNoteById(Integer.parseInt(nid));
            String filename = note.getPath();
            //获取文件保存的路径
            String filePath = path + filename;
            File file = new File(filePath);
            if (file.exists()) {
                //fileName是要下载文件的磁盘绝对路径
                InputStream f = null;
                System.out.println("要下载的文件是：" + filePath);
                try {
                    f = new FileInputStream(filePath);
                    System.out.println("下载：" + filePath);
                    response.reset();
                    response.setHeader("Content-Disposition",
                            "attachment; filename=\"" + filename + "\"");
                    //设置下载文件的大小信息
                    response.addHeader("Content-Length", "" + f.available());
                    //设置文件response返回的内容类型，浏览器接收到这个类型就会以下载文件形式处理
                    response.setContentType("application/octet-stream;charset=UTF-8");
                    OutputStream outputStream = new BufferedOutputStream(
                            response.getOutputStream());

                    //把文件数据写入到outputstream中
                    byte[] b = new byte[1024];
                    int len = f.read(b);
                    while (len != -1) {
                        outputStream.write(b);
                        len = f.read(b);
                    }

                    outputStream.flush();
                    outputStream.close();
                    note.setTimes(note.getTimes() + 1);
                    int update = iNoteDao.Addtimes(note);
                    System.out.println(update);
                } catch (IOException e1) {
                    // TODO Auto-generated catch block
                    e1.printStackTrace();
                }
            }
        }
    }

    @Override
    public void doSearch(String title, HttpSession session) {
        if (title != null) {
            title = "%" + title + "%";
            System.out.println(title);
            session.setAttribute("title", title);
        }
    }

    @Override
    public void doSearchByType(String tid, HttpSession session) {
        session.setAttribute("tid", tid);
    }

    @Override
    public ViewMsg<List<Notes>> getHotNotes() {
        ViewMsg<List<Notes>> viewMsg = new ViewMsg<>();
        List<Notes> notes = iNoteDao.getHotNotes();
        viewMsg.setCode(notes.size());
        viewMsg.setData(notes);
        return viewMsg;
    }
}
