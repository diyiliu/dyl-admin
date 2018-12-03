package com.dyl.admin.web.portal;

import com.dyl.admin.support.model.PageData;
import com.dyl.admin.support.model.RespBody;
import com.dyl.admin.web.HomeController;
import com.dyl.admin.web.console.blog.dto.Article;
import com.dyl.admin.web.console.blog.dto.Classify;
import com.dyl.admin.web.console.blog.dto.Tag;
import com.dyl.admin.web.console.blog.facade.ArticleJpa;
import com.dyl.admin.web.console.blog.facade.ClassifyJpa;
import com.dyl.admin.web.console.blog.facade.TagJpa;
import com.dyl.admin.web.console.sys.dto.ResImg;
import com.dyl.admin.web.console.sys.facade.ResImgJpa;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.env.Environment;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLConnection;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Description: BlogPortalController
 * Author: DIYILIU
 * Update: 2018-12-02 22:02
 */

@Slf4j
@Controller
public class BlogPortalController extends HomeController {

    @Resource
    private Environment environment;

    @Resource
    private ResImgJpa resImgJpa;

    @Resource
    private ClassifyJpa classifyJpa;

    @Resource
    private ArticleJpa articleJpa;

    @Resource
    private TagJpa tagJpa;

    @ModelAttribute
    public void classifyAttribute(Model model) {
        List<Classify> classifyList = classifyJpa.findAll(Sort.by(new String[]{"pid", "sort"}));
        classifyList.forEach(e -> {
            List articleList = articleJpa.findByStatusAndClassify_Id(1, e.getId());
            e.setCount(articleList.size());
        });

        // 根节点
        List<Classify> rootList = classifyList.stream().filter(a -> a.getPid() == 0).collect(Collectors.toList());
        // 子节点
        Map<Long, List<Classify>> listMap = classifyList.stream().filter(a -> a.getPid() > 0)
                .collect(Collectors.groupingBy(Classify::getPid));
        for (Classify clz : rootList) {
            Long id = clz.getId();
            clz.setChildren(listMap.get(id));
        }
        model.addAttribute("classifys", rootList);

        // 推荐
        Pageable pageable = PageRequest.of(0, 3, Sort.by(Sort.Direction.DESC, new String[]{"isTop", "updateTime"}));
        Page<Article> articlePage = articleJpa.findByStatusAndResImgIsNotNull(1, pageable);
        model.addAttribute("tops", articlePage.getContent());

        // 热门
        pageable = PageRequest.of(0, 2, Sort.by(Sort.Direction.DESC, "seeCount"));
        articlePage = articleJpa.findByStatusAndResImgIsNotNull(1, pageable);
        model.addAttribute("hots", articlePage.getContent());

        // 标签
        List<Object[]> tagArray = tagJpa.findOrderByCount();
        List tags = new ArrayList();
        for (int i = 0; i < tagArray.size(); i++) {
            Object[] objects = tagArray.get(i);
            tags.add(objects[0]);
            if (i > 11) {
                break;
            }
        }
        model.addAttribute("tags", tags);
    }

    @GetMapping("/")
    public String index(Model model) {
        List articles = articleJpa.findByStatus(1);
        model.addAttribute("totalNumber", articles.size());
        model.addAttribute("active", 0);

        return "index";
    }

    @GetMapping("/classify/{id}")
    public String classify(@PathVariable long id, Model model) {
        if (id == 0) {

            return "redirect:/";
        }
        Classify classify = classifyJpa.findById(id).get();
        model.addAttribute("classify", classify);

        List articles = articleJpa.findByStatusAndClassify_Id(1, id);
        model.addAttribute("totalNumber", articles.size());
        model.addAttribute("active", classify.getId());

        return "blog/classify";
    }

    @GetMapping("/article/{id}")
    public String article(@PathVariable long id, Model model) {
        Article article = articleJpa.findById(id).get();
        model.addAttribute("article", article);

        return "blog/article";
    }

    @GetMapping("/tag/{name}")
    public String tag(@PathVariable String name, Model model) {
        List<Tag> tagList = tagJpa.findByName(name);
        List<Long> ids = tagList.stream().map(Tag::getArticleId).distinct().collect(Collectors.toList());
        List<Article> articleList = articleJpa.findAllById(ids);

        model.addAttribute("articles", articleList);
        model.addAttribute("tag", name);

        return "blog/tag";
    }

    @ResponseBody
    @PostMapping("/classify/{id}")
    public PageData classify(PageData pageData, @PathVariable long id) {
        Pageable pageable = PageRequest.of(pageData.getPageNo() - 1, pageData.getPageSize(), Sort.by(Sort.Direction.DESC, "createTime"));

        Page<Article> articlePage;
        if (id == 0) {
            articlePage = articleJpa.findByStatus(1, pageable);
        } else {
            articlePage = articleJpa.findByStatusAndClassify_Id(1, id, pageable);
        }

        pageData.setTotal(articlePage.getTotalPages());
        pageData.setData(articlePage.getContent());

        return pageData;
    }


    @ResponseBody
    @PostMapping("/image/upload")
    public RespBody imgUpload(MultipartFile file) throws Exception {
        RespBody respBody = new RespBody();

        String imgPath = upload(file);
        if (StringUtils.isEmpty(imgPath)) {
            respBody.setStatus(0);
            respBody.setMessage("图片保存失败");
        } else {
            respBody.setStatus(1);
            respBody.setData(imgPath);
        }

        return respBody;
    }


    @GetMapping("/image/show/{time}/{id}")
    public void showPicture(@PathVariable long id, @PathVariable String time, HttpServletResponse response) {
        ResImg img = resImgJpa.findById(id).get();
        if (img != null) {
            try {
                org.springframework.core.io.Resource imgRes = new UrlResource("file:" + img.getPath());
                if (imgRes != null && imgRes.exists()) {
                    response.setHeader("Content-Type", URLConnection.guessContentTypeFromName(imgRes.getFilename()));
                    FileCopyUtils.copy(imgRes.getInputStream(), response.getOutputStream());
                    response.flushBuffer();
                }
            } catch (IOException e) {
                log.info("Error writing file to output stream. Filename was '{}'", img.getPath());
                throw new RuntimeException("IOError writing file to output stream");
            }
        }
    }

    @ResponseBody
    @RequestMapping("/ckeditor/upload")
    public Map editorUpload(MultipartFile upload) throws Exception {
        String fileName = upload.getOriginalFilename();
        String imgPath = upload(upload);

        Map respMap = new HashMap();
        respMap.put("uploaded", 1);
        respMap.put("fileName", fileName);
        respMap.put("url", imgPath);

        return respMap;
    }

    private String upload(MultipartFile file) throws Exception {
        String date = String.format("%1$tY%1$tm", new Date());
        String dir = environment.getProperty("upload.pic") + date + "/";

        ResImg img = uploadImg(file, dir);
        if (img != null) {
            List imgList = (List) session.getAttribute("temp_pic");
            if (imgList == null) {
                imgList = new ArrayList();
                session.setAttribute("temp_pic", imgList);
            }
            imgList.add(img);
            long time = img.getCreateTime().getTime();

            return "/image/show/" + time + "/" + img.getId();
        }

        return null;
    }
}
