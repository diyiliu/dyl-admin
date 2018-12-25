package com.dyl.admin.web.console.blog;

import com.dyl.admin.support.model.RespBody;
import com.dyl.admin.web.BaseController;
import com.dyl.admin.web.console.blog.dto.Article;
import com.dyl.admin.web.console.blog.dto.Tag;
import com.dyl.admin.web.console.blog.facade.ArticleJpa;
import com.dyl.admin.web.console.blog.facade.TagJpa;
import com.dyl.admin.web.console.sys.dto.ResImg;
import com.dyl.admin.web.console.sys.dto.SysUser;
import com.dyl.admin.web.console.sys.facade.ResImgJpa;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.*;

/**
 * Description: BlogController
 * Author: DIYILIU
 * Update: 2018-11-14 15:28
 */

@RestController
@RequestMapping("/console/blog")
public class BlogController extends BaseController {

    @Resource
    private ArticleJpa articleJpa;

    @Resource
    private TagJpa tagJpa;

    @PostMapping("/save")
    public RespBody save(Article article, HttpSession session) throws Exception {

        Article temp;
        String tags = article.getTags();
        if (article.getId() == null) {
            SysUser user = (SysUser) session.getAttribute("user");

            article.setResImg(handleImg(article.getContent(), session));
            article.setUser(user);
            article.setSeeCount(0);
            article.setCreateTime(new Date());
            article.setUpdateTime(new Date());
            temp = articleJpa.save(article);
        } else {
            long id = article.getId();
            temp = articleJpa.findById(id).get();
            Long resImg = handleImg(article.getContent(), session);

            article.setUser(temp.getUser());
            article.setCreateTime(temp.getCreateTime());
            article.setUpdateTime(new Date());
            article.setSeeCount(temp.getSeeCount());
            article.setResImg(resImg == null ? temp.getResImg() : resImg);
            temp = articleJpa.save(article);
        }
        RespBody respBody = new RespBody();
        // 操作失败
        if (temp == null) {
            respBody.setStatus(0);
            return respBody;
        }

        long id = temp.getId();
        handleTags(id, tags);
        respBody.setStatus(1);
        respBody.setData(id);

        return respBody;
    }

    @PostMapping("/articles")
    public Map articleList(@RequestParam int pageNo, @RequestParam int pageSize,
                           @RequestParam(required = false) String search) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize, Sort.by(Sort.Direction.DESC, "updateTime"));
        Page<Article> userPage = articleJpa.findAll(pageable);

        Map respMap = new HashMap();
        respMap.put("data", userPage.getContent());
        respMap.put("total", userPage.getTotalElements());

        return respMap;
    }

    @DeleteMapping("/article/{id}")
    public Integer deleteArticle(@PathVariable("id") long id) {
        Article article = articleJpa.findById(id).get();
        Long imgId = article.getResImg();

        articleJpa.deleteById(id);
        tagJpa.deleteByArticleId(id);
        // 删除图片
        try {
            if (imgId != null){
                deleteImg(imgId);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return 1;
    }

    @PutMapping("/article/{item}")
    public Integer modify(@PathVariable String item, @RequestParam long id, @RequestParam int val) {
        Article article = articleJpa.findById(id).get();
        if (item.equals("top")){
            article.setIsTop(val);
        }else {
            article.setStatus(val);
        }
        article = articleJpa.save(article);
        if (article == null){

            return 0;
        }

        return 1;
    }

//    @PostMapping("/editor/{id}")
//    public void editor(@PathVariable("id") long id, HttpServletResponse response,
//                       RedirectAttributes redirectAttributes) throws IOException {
//
//        redirectAttributes.addFlashAttribute("article", id);
//        response.sendRedirect("/console/editor");
//    }

    private void handleTags(long id, String tags) {
        tagJpa.deleteByArticleId(id);
        if (StringUtils.isNotEmpty(tags)) {
            String[] tagArray = tags.split(",");
            List<Tag> tagList = new ArrayList();
            int i = 0;
            for (String tag : tagArray) {
                Tag t = new Tag();
                t.setArticleId(id);
                t.setName(tag);
                t.setSort(++i);
                tagList.add(t);
            }
            tagJpa.saveAll(tagList);
        }
    }

    private Long handleImg(String content, HttpSession session) throws Exception {
        List<ResImg> imgList = (List<ResImg>) session.getAttribute("temp_pic");

        Long imgView = null;
        if (CollectionUtils.isNotEmpty(imgList)) {
            for (Iterator<ResImg> iterator = imgList.iterator(); iterator.hasNext(); ) {
                ResImg img = iterator.next();
                long time = img.getCreateTime().getTime();
                String url = "/image/show/" + time + "/" + img.getId();

                if (!content.contains(url)) {
                    // 删除图片
                    deleteImg(img.getId());
                } else {
                    if (imgView == null) {
                        imgView = img.getId();

                        String path = img.getPath();
                        // 创建缩略图
                        org.springframework.core.io.Resource imgRes = new UrlResource("file:" + path);
                        if (imgRes.exists()){
                            String dir = environment.getProperty("upload.pic") + "thumb";
                            org.springframework.core.io.Resource resDir = new UrlResource(dir);

                            // 缩略图文件
                            File tempFile = File.createTempFile("small", path.substring(path.lastIndexOf(".")).toLowerCase(), resDir.getFile());
                            // 图片高度
                            int height = 240;
                            Thumbnails.of(imgRes.getFile().getPath()).height(height).toFile(tempFile.getPath());
                            String thumbPath = tempFile.getPath();
                            //保持纵横比，质量降低
                            Thumbnails.of(thumbPath).scale(1).outputQuality(0.5).toFile(thumbPath);

                            img.setThumb(thumbPath.replaceAll("\\\\", "/"));
                            resImgJpa.save(img);
                        }
                    }
                }
                iterator.remove();
            }
        }

        return imgView;
    }
}
