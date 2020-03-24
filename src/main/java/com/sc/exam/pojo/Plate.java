package com.sc.exam.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.mapping.FetchType;


import java.sql.Blob;
import java.sql.Timestamp;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Plate {
    private Integer plate_id;
    private String plate_type;
//    private Blob plate_plateimg;

    private String plate_plateimg;
    //
    //板块图片
    private Integer plate_status;
//    板块的状态0；禁用 1：启用
@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Timestamp plate_createtime;
    private List<Posts> posts;
}
