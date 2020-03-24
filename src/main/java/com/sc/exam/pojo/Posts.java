package com.sc.exam.pojo;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Blob;
import java.sql.Timestamp;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Posts {
    private Integer post_id;
    private Integer plate_typeid;
//    帖子的板块id
    private String post_content;
//    帖子的内容
    private String post_image;
//    帖子的图片内容
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Timestamp posting_time;
    //  帖子记录的时间
    private String post_title;
//    帖子的标题
    private Integer user_id;
//    发帖人的id
    private Integer post_status;
//    是否启用或禁用 0：禁用 1：启用
    private Integer post_numbers;
//    帖子被访问的次数
    private Integer post_essence;
//    是否是精华表，默认是0，只有后台才能修改，1代表精华表
    private Integer post_roof_placement;
//    是否置顶，0为默认不置顶，1为置顶
//    private List<ReplyPosts> replyPosts;
    private String user_name;
//    作者的名字
}
