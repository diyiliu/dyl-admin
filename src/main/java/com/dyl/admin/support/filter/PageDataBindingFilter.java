package com.dyl.admin.support.filter;

import com.dyl.admin.web.console.blog.dto.Classify;
import com.dyl.admin.web.console.blog.facade.ClassifyJpa;
import com.dyl.admin.web.console.nav.dto.SiteType;
import com.dyl.admin.web.console.nav.facade.SiteTypeJpa;
import com.dyl.admin.web.console.sys.dto.SysRole;
import com.dyl.admin.web.console.sys.dto.SysUser;
import com.dyl.admin.web.console.sys.facade.SysRoleJpa;
import com.dyl.admin.web.console.sys.facade.SysUserJpa;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Description: PageDataBindingFilter
 * Author: DIYILIU
 * Update: 2018-05-11 10:14
 */

@Aspect
@Component
public class PageDataBindingFilter {

    @Resource
    private SysRoleJpa sysRoleJpa;

    @Resource
    private SysUserJpa sysUserJpa;

    @Resource
    private ClassifyJpa classifyJpa;

    @Resource
    private SiteTypeJpa siteTypeJpa;


    @After("execution(* com.dyl.admin.web.console.LoginController.display(..))")
    public void doAfter(JoinPoint joinPoint) {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();

        Object[] args = joinPoint.getArgs();
        String menu = (String) args[0];

        if ("user".equals(menu)) {
            List<SysRole> roleList = sysRoleJpa.findAll();
            request.setAttribute("roles", roleList);

            List<SysUser> userList = sysUserJpa.findAll();
            List<String> usernameList = userList.stream().map(SysUser::getUsername).collect(Collectors.toList());
            List<String> nameList = userList.stream().map(SysUser::getName).collect(Collectors.toList());
            nameList.addAll(usernameList);
            request.setAttribute("names", nameList);

            return;
        }


        if ("editor".equals(menu)) {
            List<Classify> classifyList = classifyJpa.findByType(1, Sort.by(new String[]{"pid", "sort"}));
            request.setAttribute("classifys", classifyList);

            return;
        }

        if (menu.startsWith("site")) {
            List<SiteType> siteTypes = siteTypeJpa.findAll(Sort.by("sort"));
            request.setAttribute("types", siteTypes);

            // 主页面 添加chosen
            if (menu.contains(".1")) {
                List<String> names = siteTypes.stream().map(SiteType::getName).collect(Collectors.toList());
                request.setAttribute("tNames", names);
            }

            return;
        }
    }
}
