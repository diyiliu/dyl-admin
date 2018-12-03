package com.dyl.admin.web.portal;

import com.dyl.admin.web.console.nav.dto.SiteType;
import com.dyl.admin.web.console.nav.facade.SiteTypeJpa;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Description: NavPortalController
 * Author: DIYILIU
 * Update: 2018-12-02 22:03
 */

@Controller
@RequestMapping("/nav")
public class NavPortalController {

    @Resource
    private SiteTypeJpa siteTypeJpa;

    @GetMapping
    public String index(Model model) {
        List<SiteType> siteTypes = siteTypeJpa.findAll(Sort.by("sort"));

        List<SiteType> typeList = siteTypes.stream().filter(t -> CollectionUtils.isNotEmpty(t.getSiteList())).collect(Collectors.toList());
        model.addAttribute("typeList", typeList);

        return "nav/index";
    }
}
