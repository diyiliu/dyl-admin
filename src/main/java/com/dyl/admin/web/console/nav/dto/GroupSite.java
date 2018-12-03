package com.dyl.admin.web.console.nav.dto;

import lombok.Data;

import java.util.List;

/**
 * Description: GroupSite
 * Author: DIYILIU
 * Update: 2017-10-20 11:33
 */

@Data
public class GroupSite {

    private String type;
    private List<Website> websiteList;
}
