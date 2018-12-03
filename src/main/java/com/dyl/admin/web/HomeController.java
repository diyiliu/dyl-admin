package com.dyl.admin.web;

import com.dyl.admin.web.console.sys.dto.ResImg;
import com.dyl.admin.web.console.sys.dto.SysUser;
import com.dyl.admin.web.console.sys.facade.ResImgJpa;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;

/**
 * Description: HomeController
 * Author: DIYILIU
 * Update: 2018-12-02 21:53
 */

@Component
public class HomeController {

    @Autowired
    protected HttpServletRequest request;

    @Autowired
    protected HttpSession session;

    @Resource
    private ResImgJpa resImgJpa;

    protected ResImg uploadImg(MultipartFile file, String dir) throws Exception {
        org.springframework.core.io.Resource resDir = new UrlResource(dir);
        if (!resDir.getFile().exists()) {
            resDir.getFile().mkdir();
        }

        String fileName = file.getOriginalFilename();
        // 创建临时文件
        File tempFile = File.createTempFile("img", fileName.substring(fileName.lastIndexOf(".")).toLowerCase(), resDir.getFile());
        FileCopyUtils.copy(file.getBytes(), tempFile);

        return  save(tempFile);
    }

    protected ResImg save(File file){
        SysUser user = (SysUser) session.getAttribute("user");
        ResImg img = new ResImg();

        img.setPath(file.getPath().replaceAll("\\\\", "/"));
        img.setUserId(user.getId());
        img.setCreateTime(new Date());

        return  resImgJpa.save(img);
    }
}
