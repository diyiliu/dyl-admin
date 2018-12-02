package com.dyl.admin.support.filter;

import com.dyl.admin.support.util.WebUtils;
import com.dyl.admin.web.console.blog.dto.Article;
import com.dyl.admin.web.console.blog.facade.ArticleJpa;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * Description: AccessStatisticsFilter
 * Author: DIYILIU
 * Update: 2018-11-26 20:58
 */

@Slf4j
@Aspect
@Component
public class AccessStatisticsFilter {

    @Resource
    private WebUtils webUtils;

    @Resource
    private ArticleJpa articleJpa;

    @After("execution(* com.dyl.admin.web.portal.BlogPortalController.article(..))")
    public void doAfter(JoinPoint joinPoint) {
        String ip = webUtils.getRemoteHost();
        log.info("[{}]阅读文章 ... ", ip);

        Object[] args = joinPoint.getArgs();
        long articleId = (long) args[0];

        Article article = articleJpa.findById(articleId).get();
        article.setSeeCount(article.getSeeCount() + 1);
        articleJpa.save(article);
    }
}
