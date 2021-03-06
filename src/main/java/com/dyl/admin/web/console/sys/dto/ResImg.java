package com.dyl.admin.web.console.sys.dto;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

/**
 * Description: ResImg
 * Author: DIYILIU
 * Update: 2018-11-14 14:41
 */

@Data
@Entity
@Table(name = "res_img")
public class ResImg {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String path;

    /** 缩略图 **/
    private String thumb;

    private Long userId;

    private Date createTime;
}
