package com.dyl.admin.web;

import com.dyl.admin.web.console.sys.dto.ResImg;
import com.dyl.admin.web.console.sys.dto.SysUser;
import com.dyl.admin.web.console.sys.facade.ResImgJpa;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;

/**
 * Description: BaseController
 * Author: DIYILIU
 * Update: 2018-12-02 21:53
 */

@Slf4j
@Component
public class BaseController {

    @Resource
    protected Environment environment;

    @Resource
    protected ResImgJpa resImgJpa;

    @Autowired
    protected HttpServletRequest request;

    @Autowired
    protected HttpSession session;

    public ResImg uploadImg(MultipartFile file, String dir) throws Exception {
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

    public ResImg save(File file){
        SysUser user = (SysUser) session.getAttribute("user");
        ResImg img = new ResImg();

        img.setPath(file.getPath().replaceAll("\\\\", "/"));
        img.setUserId(user.getId());
        img.setCreateTime(new Date());

        return  resImgJpa.save(img);
    }

    public void deleteImg(long id) throws IOException {
        if (id > 0){
            ResImg img = resImgJpa.findById(id).get();

            // 删除图片
            String path = img.getPath();
            deleteFile(path);
            // 删除缩略图
            String thumb = img.getThumb();
            deleteFile(thumb);

            // 删除数据库记录
            resImgJpa.delete(img);
        }
    }

    private void deleteFile(String path) throws IOException{
        org.springframework.core.io.Resource localRes = new UrlResource("file:" + path);
        if (localRes.exists()) {
            if (localRes.getFile().delete()) {
                log.info("删除文件[{}]成功!", path);
            }else {
                log.error("删除文件[{}]失败!", path);
            }
        }
    }
}
