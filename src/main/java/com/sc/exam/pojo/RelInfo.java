package com.sc.exam.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RelInfo {
    private Integer id;
    private Integer rel_id;
    private Integer que_type_id;
    private Integer que_count;
    private Integer que_score;
}
