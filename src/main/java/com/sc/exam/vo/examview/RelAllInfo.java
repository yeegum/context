package com.sc.exam.vo.examview;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;



@Data
@AllArgsConstructor
@NoArgsConstructor
public class RelAllInfo {
    private Integer rel_id;
    private String rel_name;
    private List<RelInfoVo> relInfoVoList;
}
