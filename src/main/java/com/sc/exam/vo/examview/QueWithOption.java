package com.sc.exam.vo.examview;

import com.sc.exam.pojo.Que;
import com.sc.exam.pojo.QueOption;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 用来包装
 * 题目信息 和 对应的选项
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class QueWithOption {

    private Que que;
    private List<QueOption> optionList;

}
