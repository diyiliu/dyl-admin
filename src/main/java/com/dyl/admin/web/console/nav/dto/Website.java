package com.dyl.admin.web.console.nav.dto;

import com.dyl.admin.web.console.sys.dto.ResImg;
import lombok.Data;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.*;
import java.util.Date;

/**
 * Description: Website
 * Author: DIYILIU
 * Update: 2017-10-19 11:01
 */

@Data
@Entity
@Table(name = "nav_site")
public class Website {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String url;

    private Long image;

    @ManyToOne
    @JoinColumn(name = "type")
    @NotFound(action = NotFoundAction.IGNORE)
    private SiteType siteType;

    private String comment;

    private int sort;

    private Date createTime;

    public void setUrl(String url) {
        String regex = "[hH][tT]{2}[pP]://|[hH][tT]{2}[pP][sS]://|/+$";
        this.url = url.replaceAll(regex, "");
    }
}
