package com.dyl.admin.web.console.nav;

import com.dyl.admin.support.util.JacksonUtil;
import com.dyl.admin.web.BaseController;
import com.dyl.admin.web.console.nav.dto.SiteType;
import com.dyl.admin.web.console.nav.dto.Website;
import com.dyl.admin.web.console.nav.facade.SiteTypeJpa;
import com.dyl.admin.web.console.nav.facade.WebsiteJpa;
import com.dyl.admin.web.console.sys.dto.ResImg;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.env.Environment;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;
import javax.persistence.criteria.*;
import java.io.*;
import java.net.URI;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * Description: NavController
 * Author: DIYILIU
 * Update: 2018-05-15 21:08
 */


@RestController
@RequestMapping("/console/nav")
public class NavController extends BaseController {

    @Resource
    private Environment environment;

    @Resource
    private WebsiteJpa websiteJpa;

    @Resource
    private SiteTypeJpa siteTypeJpa;


    @PostMapping("/siteList")
    public Map siteList(@RequestParam int pageNo, @RequestParam int pageSize,
                        @RequestParam(required = false) String search, @RequestParam(required = false) Long typeId) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize, Sort.by(Sort.Direction.DESC, "createTime"));

        Page<Website> sitePage;
        if (StringUtils.isEmpty(search) && typeId == null) {
            sitePage = websiteJpa.findAll(pageable);
        } else {
            sitePage = websiteJpa.findAll(
                    (Root<Website> root, CriteriaQuery<?> query, CriteriaBuilder cb) -> {
                        Path<String> nameExp = root.get("name");
                        Path<String> urlExp = root.get("url");
                        Path<SiteType> typeExp = root.get("siteType");

                        List<Predicate> list = new ArrayList();
                        if (StringUtils.isNotEmpty(search)) {
                            String like = "%" + search + "%";
                            Predicate predicate = cb.or(new Predicate[]{cb.like(nameExp, like), cb.like(urlExp, like)});
                            list.add(predicate);
                        }
                        if (typeId != null) {
                            Predicate predicate = cb.equal(typeExp, new SiteType(typeId));
                            list.add(predicate);
                        }

                        Predicate[] predicates = list.toArray(new Predicate[]{});
                        return cb.and(predicates);
                    }, pageable);
        }

        Map respMap = new HashMap();
        respMap.put("data", sitePage.getContent());
        respMap.put("total", sitePage.getTotalElements());

        return respMap;
    }

    @PostMapping("/typeList")
    public Map typeList() {
        List<SiteType> siteTypeList = siteTypeJpa.findAll(Sort.by("sort"));

        Map respMap = new HashMap();
        respMap.put("data", siteTypeList);
        respMap.put("total", siteTypeList.size());

        return respMap;
    }


    @PostMapping("/site")
    public Integer saveSite(Website website) throws Exception {
        if (website.getId() != null) {

            return modifySite(website);
        }

        website.setCreateTime(new Date());
        // 抓取图片
        byte[] imgBytes = fetchICO(website.getUrl());
        if (imgBytes == null) {
            website.setImage(0l);
        } else {
            website.setImage(saveImg(imgBytes));
        }

        // 未设置网站分组
        if (website.getSiteType() != null && website.getSiteType().getId() == null) {
            website.setSiteType(null);
        }

        website = websiteJpa.save(website);
        if (website == null) {

            return 0;
        }

        return 1;
    }

    public Integer modifySite(Website website) {
        Website temp = websiteJpa.findById(website.getId()).get();

        website.setImage(temp.getImage());
        website.setCreateTime(temp.getCreateTime());
        website = websiteJpa.save(website);
        if (website == null) {

            return 0;
        }

        return 1;
    }

    @DeleteMapping("/site")
    public Integer deleteSite(@RequestBody List<Long> ids) throws IOException {
        List<Website> list = websiteJpa.findByIdIn(ids);

        // 删除文件
        for (Website site : list) {
            /*
            String imgPath = site.getImage();
            if (StringUtils.isEmpty(imgPath) || "unknown.png".equals(imgPath)) {
                continue;
            }

            String picDir = environment.getProperty("upload.guide.icon");
            org.springframework.core.io.Resource localRes = new UrlResource(picDir + imgPath);
            if (localRes.exists()) {
                if (!localRes.getFile().delete()) {
                    System.err.println("删除文件[{}]失败!");
                }
            }
            */
        }

        // 删除数据
        websiteJpa.deleteAll(list);

        return 1;
    }

    @DeleteMapping("/site/{id}")
    public Integer deleteSite(@PathVariable long id) throws Exception {
        Website site = websiteJpa.findById(id).get();

        // 删除图片
        long imgId = site.getImage();
        deleteImg(imgId);

        // 删除网址
        websiteJpa.delete(site);

        return 1;
    }

    @PutMapping("/icon/{id}")
    public Integer modifyIcon(@PathVariable long id){
        Website site = websiteJpa.findById(id).get();

        // 抓取图片
        byte[] imgBytes = fetchICO(site.getUrl());
        if (imgBytes == null){

            return 0;
        }

        try {
            deleteImg(site.getImage());
            long newId = saveImg(imgBytes);
            site.setImage(newId);
            websiteJpa.save(site);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }

        return 1;
    }


    @PostMapping("/modifyType")
    public Integer modifyType(long id, String name) {
        SiteType type = siteTypeJpa.findById(id).get();
        type.setName(name);
        siteTypeJpa.save(type);

        return 1;
    }

    @PostMapping("/type")
    public Integer type(SiteType siteType) {
        siteTypeJpa.save(siteType);

        return 1;
    }

    @DeleteMapping("/type/{id}")
    public Integer type(@PathVariable long id) {
        SiteType type = siteTypeJpa.findById(id).get();
        if (CollectionUtils.isNotEmpty(type.getSiteList())) {

            return 0;
        }
        siteTypeJpa.deleteById(id);

        return 1;
    }


    @PostMapping("/sort")
    public Integer saveSort(@RequestBody String json) throws Exception {
        List list = JacksonUtil.toList(json, Map.class);
        List<SiteType> siteTypes = siteTypeJpa.findAll(Sort.by("sort"));
        Map<Long, SiteType> typeMap = siteTypes.stream().collect(Collectors.toMap(SiteType::getId, type -> type));

        List<SiteType> typeList = new ArrayList();
        List<Website> siteList = new ArrayList();
        for (int i = 0; i < list.size(); i++) {
            int sort = i + 1;
            Map map = (Map) list.get(i);
            long id = Long.parseLong(String.valueOf(map.get("id")));
            if (typeMap.containsKey(id)) {
                SiteType type = typeMap.get(id);
                if (type.getSort() != sort) {
                    type.setSort(sort);
                    typeList.add(type);
                }

                List children = (List) map.get("children");
                List<Website> sList = type.getSiteList();
                if (CollectionUtils.isEmpty(children) || CollectionUtils.isEmpty(sList)) {

                    continue;
                }

                Map<Long, Website> siteMap = sList.stream().collect(Collectors.toMap(Website::getId, site -> site));
                for (int j = 0; j < children.size(); j++) {
                    int top = j + 1;
                    Map m = (Map) children.get(j);
                    long key = Long.parseLong(String.valueOf(m.get("id")));
                    if (siteMap.containsKey(key)) {
                        Website website = siteMap.get(key);
                        if (website.getSort() != top) {
                            website.setSort(top);
                            siteList.add(website);
                        }
                    }
                }
            }
        }

        List tList = siteTypeJpa.saveAll(typeList);
        List sList = websiteJpa.saveAll(siteList);
        if (tList == null || sList == null) {

            return 0;
        }

        return 1;
    }

    private long saveImg(byte[] imgBytes) throws Exception {
        String picDir = environment.getProperty("upload.nav.icon");
        org.springframework.core.io.Resource resDir = new UrlResource(picDir);

        File tempFile = File.createTempFile("icon", ".png", resDir.getFile());
        FileCopyUtils.copy(imgBytes, tempFile);
        ResImg resImg = save(tempFile);
        if (resImg == null) {

            return 0;
        }

        return resImg.getId();
    }


    /**
     * 抓取网站图标
     *
     * @param location
     * @return
     */
    private byte[] fetchICO(String location) {
        String userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36";
        String scheme = "http";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.USER_AGENT, userAgent);

        ResponseEntity<byte[]> responseEntity = restTemplate.exchange(
                scheme + "://" + location,
                HttpMethod.GET,
                new HttpEntity<byte[]>(headers),
                byte[].class);

        int statusCode = responseEntity.getStatusCode().value();
        if (301 == statusCode || 302 == statusCode || 308 == statusCode) {
            URI uri = responseEntity.getHeaders().getLocation();
            scheme = uri.getScheme();
            location = uri.getHost();

            responseEntity = restTemplate.exchange(
                    uri,
                    HttpMethod.GET,
                    new HttpEntity<byte[]>(headers),
                    byte[].class);
            statusCode = responseEntity.getStatusCode().value();
        }

        String icoPath = null;
        try {
            if (200 == statusCode) {
                InputStream inputStream = new ByteArrayInputStream(responseEntity.getBody());
                BufferedReader br = new BufferedReader(new InputStreamReader(inputStream, "utf-8"));
                String line;
                while ((line = br.readLine()) != null) {
                    if (line.contains(".ico") || line.contains("icon")) {
                        // 取出有用的范围
                        Pattern p = Pattern.compile("<link[^<]+rel=\"[^\"]*icon[^\"]*\"[^>]+>");
                        Matcher m = p.matcher(line.trim());
                        if (m.find()) {
                            String path = m.group();
                            int index = path.indexOf("href=");
                            path = path.substring(index + 6);
                            index = path.indexOf("\"");
                            path = path.substring(0, index);

                            if (!path.startsWith("http") && !path.startsWith("/")){
                                path = "/" + path;
                            }
                            if (!path.contains("//")) {
                                path = scheme + "://" + location + path;
                            }
                            if (!path.startsWith("http")) {
                                path = scheme + ":" + path;
                            }
                            icoPath = path;
                            break;
                        }
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (icoPath == null) {
            icoPath = "http://statics.dnspod.cn/proxy_favicon/_/favicon?domain=" + location;
        }
        responseEntity = restTemplate.exchange(
                icoPath,
                HttpMethod.GET,
                new HttpEntity<byte[]>(headers),
                byte[].class);

        statusCode = responseEntity.getStatusCode().value();
        if (statusCode == 200) {
            byte[] bytes = responseEntity.getBody();
            // 默认图标
            if (bytes.length != 726) {
                return bytes;
            }
        }
        return null;
    }
}
