package com.dyl.admin.web.console.nav.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import javax.persistence.*;
import java.util.List;

/**
 * Description: SiteType
 * Author: DIYILIU
 * Update: 2017-10-19 15:18
 */

@Data
@Entity
@Table(name = "nav_type")
public class SiteType {

    public SiteType() {
    }

    public SiteType(Long id) {
        this.id = id;
    }

    public SiteType(String name) {
        this.name = name;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String code;

    private String name;

    private Integer sort;

    @JsonIgnore
    @OrderBy("sort asc")
    @OneToMany(mappedBy = "siteType")
    private List<Website> siteList;
}
