package com.sc.exam.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Paper {
    private Integer par_id;
    private Integer rel_id;
    private Integer sub_id;
    private String  par_name;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Timestamp test_start_time;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Timestamp test_end_time;
    private Integer test_length_time;
    private Integer status;
    private String sub_name;
    private String status_name;
    private String rel_name;

}
