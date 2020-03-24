package com.sc.exam.vo.examview;

import com.sc.exam.pojo.RelInfo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RelInfoVo {
    private String typeName; //类型名
    private RelInfo relInfo;    //模板类
}
