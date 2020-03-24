package com.sc.exam.service.impl;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.exam.dao.ITestDao;
import com.sc.exam.pojo.*;
import com.sc.exam.service.ITestService;
import com.sc.exam.vo.ViewMsg;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service
public class TestServiceImpl implements ITestService {
    @Autowired
    ITestDao testDao;
    @Override
    public int addPaper(Paper paper) {
        return testDao.addPaper(paper);
    }

    @Override
    public List<Sub> getSubs() {
        return testDao.getSubs();
    }

    @Override
    public List<Rel> getRels() {
        return testDao.getRels();
    }

    @Override
    public List<RelInfo> getRelinfoById(Integer rel_id) {
        return testDao.getRelinfoById(rel_id);
    }

    @Override
    public Paper getPaperByname(String par_name) {
        return testDao.getPaperByname(par_name);
    }

    @Override
    public List<Que> getQues(Integer sub_id, Integer que_type_id, Integer amount) {
        return testDao.getQues(sub_id,que_type_id,amount);
    }

    @Override
    public int addParQues(List<ParQue> ques) {
        return testDao.addParQues(ques);
    }

    @Override
    public ViewMsg createPaper(Paper p) {
        ViewMsg vm=new ViewMsg();
        int k=testDao.addPaper(p);
        if(k==0){
            vm.setCode(201);
            vm.setMsg("试卷信息更新失败");
            return vm;
        }
        Paper paper=testDao.getPaperByname(p.getPar_name());
        System.out.println("Paper:"+paper);
        List<RelInfo> infos=getRelinfoById(paper.getRel_id());
        List<Que> qs=new ArrayList<>();
        for(RelInfo r:infos){
            qs.addAll(testDao.getQues(paper.getSub_id(),r.getQue_type_id(),r.getQue_count()));
        }
        System.out.println("Qs:"+qs);
        List<ParQue> pqs=new ArrayList<>();
        for(Que q:qs){
            ParQue pq=new ParQue();
            pq.setPar_id(paper.getPar_id());
            pq.setQue_id(q.getQue_id());
            pqs.add(pq);
        }
        System.out.println("Pqs:"+pqs);
        int pq=testDao.addParQues(pqs);
        if(pq==0){
            vm.setCode(202);
            vm.setMsg("题库信息更新失败");
            return vm;
        }
        vm.setCode(200);
        vm.setMsg("试卷已生成");
        return vm;
    }
    @Override
    public PageInfo<Que> getQueList( Integer page, int size) {
        PageHelper.startPage(page, size);
        List<Que> list = testDao.getQueList();
        PageInfo<Que> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }
    @Override
    public PageInfo<Paper> getPapers(Integer page,Integer limit) {
        PageHelper.startPage(page,limit);
        List<Paper> list=testDao.getPapers();
        for(int i=0;i<list.size();i++){
            Paper p=list.get(i);
            if(p.getStatus()==0){
                p.setStatus_name("未发布");
            }else {
                p.setStatus_name("已发布");
            }
        }
        PageInfo<Paper> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public String getSubName(Integer id) {
        return testDao.getSubName(id);
    }

    @Override
    public String getRelName(Integer id) {
        return testDao.getRelName(id);
    }

    @Override
    public ViewMsg paperAlt(Paper paper) {
        int k=testDao.altPaper(paper);
        ViewMsg vm=new ViewMsg();
        if(k==0){
            vm.setCode(201);
            vm.setMsg("修改失败");
        }
        vm.setCode(200);
        vm.setMsg("修改成功");
        return vm;
    }

    @Override
    public PageInfo<Que> queSearch( Integer sub_id, String ask,Integer page, int size) {
        PageHelper.startPage(page,size);
        List<Que> list=testDao.queSearch( sub_id, ask);

        PageInfo<Que> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public List<QueType> getTypeList() {
        return testDao.getTypeList();
    }

    @Override
    public int addQue(Que que) {
        return testDao.addQue(que);
    }

    @Override
    public  int addOption(List<QueOption> ops) {
        return testDao.addOption(ops);
    }

    @Override
    public ViewMsg queAdd(Que q, List<QueOption> ops) {
        ViewMsg vm=new ViewMsg();
        int k=testDao.addQue(q);
        if(k==0){
            vm.setCode(201);
            vm.setMsg("题库更新失败");
            return vm;
        }
        Que que=testDao.getQue();
        System.out.println(que);
        String[] keys=que.getRight_ask().split(",");
        if(ops.size()!=0){
            for(int i=0;i<ops.size();i++){
                QueOption op=ops.get(i);
                if("0".equals(op.getStatement())){
                    ops.remove(i);
                    i--;
                }else {
                    op.setQue_id(que.getQue_id());
                    for(String s:keys){
                        if(op.getQue_op().equals(s)){
                            op.setStatus(1);
                        }
                    }
                }
            }
            int f=testDao.addOption(ops);
            if(f==0){
                vm.setCode(202);
                vm.setMsg("题库选项更新失败");
                return vm;
            }
        }
        vm.setCode(200);
        vm.setMsg("题库更新成功");
        return vm;
    }

    @Override
    public Que getQue() {
        return testDao.getQue();
    }

    @Override
    public int delQueById(List<Integer> idList) {
        int k=testDao.delQueById(idList);
        int i=testDao.delOptionByQueId(idList);
        return i;
    }

    @Override
    public int delOptionByQueId(List<Integer> idList) {
        return testDao.delOptionByQueId(idList);
    }

    @Override
    public Que getQueById(Integer id) {
        return testDao.getQueById(id);
    }

    @Override
    public ViewMsg queChange(Que q,List<QueOption> ops) {
        ViewMsg vm=new ViewMsg();
        int k=testDao.queChange(q);
        if(k==0){
            vm.setCode(201);
            vm.setMsg("题目更新失败");
        }
        System.out.println(q);
        String[] keys=q.getRight_ask().split(",");
        if(ops.size()!=0){
            for(int i=0;i<ops.size();i++){
                QueOption op=ops.get(i);
                if("0".equals(op.getStatement())){
                    ops.remove(i);
                    i--;
                }else {
                    op.setQue_id(q.getQue_id());
                    for(String s:keys){
                        if(op.getQue_op().equals(s)){
                            op.setStatus(1);
                        }
                    }
                }
            }
            int f=testDao.altOps(ops);
            if(f==0){
                vm.setCode(202);
                vm.setMsg("题目选项更新失败");
                return vm;
            }
        }
        vm.setCode(200);
        vm.setMsg("修改成功");
        return vm;
    }
    @Override
    public List<QueOption> getOptionsByQueId(Integer que_id) {
        return testDao.getOptionsByQueId(que_id);
    }

    @Override
    public int altOps(List<QueOption> ops) {
        return testDao.altOps(ops);
    }

    @Override
    public int delPaper(Integer par_id) {

       testDao.delPaper(par_id);
       int i=testDao.delPRQ(par_id);
       return i;
    }

    @Override
    public int delPRQ(Integer par_id) {
        return testDao.delPRQ(par_id);
    }

    @Override
    public int altPaper(Paper paper) {
        return testDao.altPaper(paper);
    }

    @Override
    public int issue(Integer par_id, Integer s) {
        return testDao.issue(par_id,s);
    }



}
