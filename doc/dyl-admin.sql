/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50721
Source Host           : localhost:3306
Source Database       : dyl-admin

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2018-12-20 22:35:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for blog_article
-- ----------------------------
DROP TABLE IF EXISTS `blog_article`;
CREATE TABLE `blog_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '所属用户',
  `title` varchar(50) DEFAULT NULL COMMENT '文章名称',
  `content` text COMMENT '文章内容',
  `overview` varchar(200) DEFAULT NULL,
  `res_img` int(11) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '栏目',
  `classify` tinyint(4) DEFAULT NULL COMMENT '所属分类',
  `open` tinyint(4) DEFAULT NULL COMMENT '0:私有; 1: 公开; 2: 好友可见;',
  `create_time` datetime DEFAULT NULL COMMENT '发布时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `is_top` tinyint(4) DEFAULT NULL COMMENT '置顶',
  `see_count` int(11) DEFAULT NULL COMMENT '查看人数',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_article
-- ----------------------------
INSERT INTO `blog_article` VALUES ('6', '1', 'Java 配置环境变量', '<ol>\r\n	<li>打开我的电脑--属性--<span style=\"color:#ff0000\">高级</span>--环境变量<br />\r\n	&nbsp;</li>\r\n	<li>新建系统变量<span style=\"color:#c0392b\"><strong>JAVA_HOME</strong></span>和<span style=\"color:#c0392b\"><strong>CLASSPATH</strong></span>\r\n	<blockquote>\r\n	<pre style=\"margin-left:0in; margin-right:0in\">\r\n变量名：JAVA_HOME\r\n\r\n变量值：C:\\Program Files\\Java\\jdk1.7.0\r\n\r\n变量名：CLASSPATH\r\n\r\n变量值：.;%JAVA_HOME%\\lib\\dt.jar;%JAVA_HOME%\\lib\\tools.jar;</pre>\r\n	</blockquote>\r\n	</li>\r\n	<li>选择&ldquo;系统变量&rdquo;中变量名为&ldquo;Path&rdquo;的环境变量，双击该变量，把JDK安装路径中bin目录的绝对路径，添加到Path变量的值中，并使用半角的分号和已有的路径进行分隔。&nbsp;\r\n	<blockquote>\r\n	<pre style=\"margin-left:0in; margin-right:0in\">\r\n变量名：Path\r\n\r\n变量值：;%JAVA_HOME%\\bin;%JAVA_HOME%\\jre\\bin;</pre>\r\n	</blockquote>\r\n\r\n	<p style=\"margin-left:0in; margin-right:0in\"><span style=\"color:#c0392b\"><strong>验证</strong></span>环境变量是否配置成功，<strong><span style=\"color:#c0392b\">javac</span></strong>&nbsp;有下面输出即可。</p>\r\n\r\n	<p style=\"margin-left:0in; margin-right:0in\"><img height=\"319\" src=\"/image/show/2018/5\" width=\"610\" /></p>\r\n\r\n	<p style=\"margin-left:0in; margin-right:0in\">&nbsp;</p>\r\n\r\n	<p style=\"margin-left:0in; margin-right:0in\">&nbsp;</p>\r\n\r\n	<p style=\"margin-left:0in; margin-right:0in\">&nbsp;</p>\r\n\r\n	<p style=\"margin-left:0in; margin-right:0in\">&nbsp;</p>\r\n\r\n	<p style=\"margin-left:0in; margin-right:0in\">&nbsp;</p>\r\n	</li>\r\n</ol>\r\n', '打开我的电脑--属性--高级--环境变量新建系统变量JAVA_HOME和CLASSPATH变量名：JAVA_HOME\n\n变量值：C:\\Program Files\\Java\\jdk1.7.0\n\n变量名：', '5', '1', '1', '1', '2018-11-23 16:50:57', '2018-11-29 22:02:02', '1', '54', '1');
INSERT INTO `blog_article` VALUES ('7', '1', 'Redis 开启远程访问', '<p>连接服务器：&nbsp;redis-cli -h host -p port -a password</p>\r\n\r\n<p><img src=\"/image/show/20181127 211851/6\" width=\"703\" /></p>\r\n\r\n<blockquote>&nbsp;redis<span style=\"color:#ff0000\">开启远程访问</span></blockquote>\r\n\r\n<p>redis默认只允许本地访问，要使redis可以远程访问可以修改<strong>redis.conf</strong></p>\r\n\r\n<p><span style=\"color:#ff0000\">解决办法：</span></p>\r\n\r\n<p>注释掉bind 127.0.0.1可以使所有的ip访问redis</p>\r\n\r\n<p>若是想指定多个ip访问，但并不是全部的ip访问，可以bind</p>\r\n\r\n<blockquote>&nbsp;在redis3.2之后，redis增加了<span style=\"color:#ff0000\">protected-mode</span></blockquote>\r\n\r\n<p>在这个模式下，即使注释掉了bind 127.0.0.1，再访问redisd时候还是报错</p>\r\n\r\n<p><span style=\"color:#ff0000\">修改办法：</span></p>\r\n\r\n<p><strong>protected-mode no</strong></p>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<p>&nbsp;</p>\r\n', '连接服务器： redis-cli -h host -p port -a password redis', '6', '1', '2', '1', '2018-11-27 21:19:38', '2018-11-30 21:26:00', null, '49', '1');
INSERT INTO `blog_article` VALUES ('9', '1', 'IDEA 开发工具激活', '<pre style=\"text-align:center\">\r\n<strong>首先感谢<span style=\"color:#3498db\"> lanyus</span> 的支持</strong></pre>\r\n\r\n<ol>\r\n	<li><a href=\"http://idea.lanyus.com/\">http://idea.lanyus.com</a>&nbsp;获取code，然后打开IDEA -》HELP -》Register<br />\r\n	<br />\r\n	<img height=\"430\" src=\"/image/show/20181128 103046/8\" width=\"610\" /><br />\r\n	&nbsp;</li>\r\n	<li>修改hosts文件 (<strong>‪C:\\Windows\\System32\\drivers\\etc\\hosts</strong>)<br />\r\n	添加&nbsp;<span style=\"color:#ff0000\"> 0.0.0.0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;account.jetbrains.com</span><br />\r\n	<br />\r\n	<img height=\"435\" src=\"/image/show/20181128 103330/9\" width=\"610\" /><br />\r\n	&nbsp;</li>\r\n	<li>重新打开IDEA可以看到过期时间，到期后可以重复上面操作。<br />\r\n	&nbsp;</li>\r\n</ol>\r\n', '首先感谢 lanyus 的支持http://idea.lanyus.com 获取code，然后打开IDEA -》HELP -》Register修改hosts文件 (‪C:\\Windows\\System', '8', '1', '1', '1', '2018-11-28 10:36:34', '2018-11-29 22:07:29', '1', '52', '1');
INSERT INTO `blog_article` VALUES ('18', '1', 'IDEA 开启 lombok 注解支持', '<blockquote>\r\n<pre>\r\n<strong><span style=\"color:#c0392b\"><code>Lombok</code> </span></strong>是一种 <code>Java&trade;</code> 实用工具，可用来帮助开发人员消除 Java 的冗长，\r\n尤其是对于简单的 Java 对象（POJO）。它通过注解实现这一目的。</pre>\r\n</blockquote>\r\n\r\n<p>添加依赖：</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compile group: &#39;org.projectlombok&#39;, name: &#39;lombok&#39;, version: &#39;1.16.20&#39;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>IDEA&nbsp;<span style=\"color:#c0392b\">安装&nbsp;lombok&nbsp;插件</span>：</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;<img height=\"377\" src=\"/image/show/20181130 091043/18\" width=\"610\" /></p>\r\n\r\n<p>&nbsp; &nbsp; 安装完成<span style=\"color:#c0392b\"><strong>重启</strong></span> IDEA。</p>\r\n\r\n<p>开启 lombok 注解功能：</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;<img alt=\"\" height=\"420\" src=\"/image/show/20181130 091318/19\" width=\"610\" /></p>\r\n', 'Lombok 是一种 Java™ 实用工具，可用来帮助开发人员消除 Java 的冗长，​​​​​​​尤其是对于简单的 Java 对象（POJO）。它通过注解实现这一目的。添加依赖：     compi', '18', '1', '1', '1', '2018-11-30 09:17:00', '2018-11-30 09:17:51', '1', '22', '1');
INSERT INTO `blog_article` VALUES ('19', '1', 'Gradle 配置本地仓库位置', '<ul>\r\n	<li>设置系统环境变量<br />\r\n	添加变量&nbsp;<strong><span style=\"color:#c0392b\">GRADLE_HOME</span></strong>，添加值为E:\\Develop\\Gradle\\gradle-3.5；<br />\r\n	<span style=\"color:#c0392b\"><strong>PATH&nbsp;</strong></span>环境变量中，添加%GRADLE_HOME%/bin；<br />\r\n	&nbsp;</li>\r\n	<li>配置 gradle 本地仓库位置 将 C:\\Users\\DIYILIU\\.gradle 的默认目录复制到（目标目录）E:\\Develop\\local\\repo\\.gradle，<br />\r\n	然后设置系统环境变量： <span style=\"color:#c0392b\"><strong>GRADLE_USER_HOME</strong></span>=E:\\Develop\\local\\repo\\.gradle<br />\r\n	<br />\r\n	<span style=\"color:#c0392b\"><strong>注意</strong></span>：修改完成后一定要<strong><span style=\"color:#ffffff\"><span style=\"background-color:#27ae60\">重启计算机</span></span></strong>才能生效。<br />\r\n	&nbsp;</li>\r\n</ul>\r\n\r\n<p><img align=\"left\" height=\"305\" src=\"/image/show/1543654292008/22\" style=\"margin-left:20px; margin-right:20px\" width=\"620\" /></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n', '设置系统环境变量添加变量 GRADLE_HOME，添加值为E:\\Develop\\Gradle\\gra', '22', '1', '1', '1', '2018-12-01 16:53:17', '2018-12-01 17:02:53', '1', '23', '1');
INSERT INTO `blog_article` VALUES ('20', '1', 'Spring Boot Jpa 显示 SQL 及参数', '<p>Jpa&nbsp;显示 SQL&nbsp;配置：</p>\n\n<blockquote>\n<p>&nbsp; # jpa<br />\n&nbsp; jpa:<br />\n&nbsp; &nbsp; properties:<br />\n&nbsp; &nbsp; &nbsp; hibernate:<br />\n&nbsp; &nbsp; &nbsp; &nbsp; format_sql: true<br />\n&nbsp; &nbsp; &nbsp; &nbsp; show_sql: true</p>\n\n<p><br />\n# log<br />\nlogging:<br />\n&nbsp; config: &#39;classpath:logback.xml&#39;</p>\n</blockquote>\n\n<p>&nbsp;</p>\n\n<p>显示 SQL&nbsp;参数需要配置 Hibernate&nbsp;日志级别: (测试中使用的是lombak.xml)<br />\n&nbsp; &nbsp; <strong>&lt;!-- 显示 SQL 的<span style=\"color:#c0392b\">绑定参数</span> --&gt;</strong><br />\n&nbsp; &nbsp; &lt;logger name=&quot;org.hibernate.type.descriptor.sql.BasicBinder&quot; level=&quot;<span style=\"color:#c0392b\">TRACE</span>&quot;/&gt;</p>\n\n<p>测试如下：</p>\n\n<p><!--StartFragment --></p>\n\n<p><img height=\"202\" src=\"/image/show/1543911953689/55\" width=\"610\" /></p>\n', 'Jpa 显示 SQL 配置：  # jpa  jpa:    properties:      hi', '55', '1', '1', '1', '2018-12-04 16:27:57', '2018-12-04 16:27:57', '1', '11', '1');

-- ----------------------------
-- Table structure for blog_classify
-- ----------------------------
DROP TABLE IF EXISTS `blog_classify`;
CREATE TABLE `blog_classify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL COMMENT '父ID',
  `user_id` int(11) DEFAULT NULL COMMENT '所属用户',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `note` varchar(100) DEFAULT NULL COMMENT '备注',
  `type` tinyint(4) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 COMMENT='博客分类';

-- ----------------------------
-- Records of blog_classify
-- ----------------------------
INSERT INTO `blog_classify` VALUES ('1', '0', '1', '编程', null, '1', '10');
INSERT INTO `blog_classify` VALUES ('2', '0', '1', '分布式', null, '1', '20');
INSERT INTO `blog_classify` VALUES ('3', '0', '1', '设计', null, '1', '30');
INSERT INTO `blog_classify` VALUES ('99', '0', '1', '其他', null, '1', '40');
INSERT INTO `blog_classify` VALUES ('100', '0', '1', '关于', null, null, '100');
INSERT INTO `blog_classify` VALUES ('1000', '0', '1', '首页', null, null, '1');

-- ----------------------------
-- Table structure for blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_tag`;
CREATE TABLE `blog_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) DEFAULT NULL COMMENT '文章ID',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `sort` tinyint(4) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8 COMMENT='标签';

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
INSERT INTO `blog_tag` VALUES ('31', '6', '环境变量', '1');
INSERT INTO `blog_tag` VALUES ('32', '6', 'Java', '2');
INSERT INTO `blog_tag` VALUES ('53', '9', 'IDEA', '1');
INSERT INTO `blog_tag` VALUES ('54', '9', '激活', '2');
INSERT INTO `blog_tag` VALUES ('55', '9', 'Java', '3');
INSERT INTO `blog_tag` VALUES ('56', '9', '开发工具', '4');
INSERT INTO `blog_tag` VALUES ('68', '18', 'Lombok', '1');
INSERT INTO `blog_tag` VALUES ('69', '18', 'Java', '2');
INSERT INTO `blog_tag` VALUES ('70', '18', 'IDEA', '3');
INSERT INTO `blog_tag` VALUES ('123', '7', 'Redis', '1');
INSERT INTO `blog_tag` VALUES ('124', '7', '远程访问', '2');
INSERT INTO `blog_tag` VALUES ('125', '7', '分布式', '3');
INSERT INTO `blog_tag` VALUES ('138', '19', 'Gradle', '1');
INSERT INTO `blog_tag` VALUES ('139', '19', '配置仓库', '2');
INSERT INTO `blog_tag` VALUES ('140', '19', 'Java', '3');
INSERT INTO `blog_tag` VALUES ('141', '20', 'JPA', '1');
INSERT INTO `blog_tag` VALUES ('142', '20', '显示SQL参数', '2');

-- ----------------------------
-- Table structure for nav_site
-- ----------------------------
DROP TABLE IF EXISTS `nav_site`;
CREATE TABLE `nav_site` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) DEFAULT NULL,
  `URL` varchar(200) DEFAULT NULL,
  `IMAGE` int(200) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `COMMENT` varchar(100) DEFAULT NULL,
  `SORT` int(11) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8 COMMENT='网站地址';

-- ----------------------------
-- Records of nav_site
-- ----------------------------
INSERT INTO `nav_site` VALUES ('98', '网易课堂', 'study.163.com', '24', '4', '网易在线课程', '1', '2018-05-16 22:10:35');
INSERT INTO `nav_site` VALUES ('101', '网络电子课程', 'yeybk.xzkfq.cn', '0', '34', '在线备课(宋老师)', '3', '2018-05-16 22:42:43');
INSERT INTO `nav_site` VALUES ('102', '百度', 'www.baidu.com', '25', '29', '百度一下', '1', '2018-05-17 20:47:31');
INSERT INTO `nav_site` VALUES ('103', '淘宝', 'www.taobao.com', '26', '30', '淘宝购物', '1', '2018-05-17 20:48:31');
INSERT INTO `nav_site` VALUES ('104', '京东', 'www.jd.com', '27', '30', '京东商城', '2', '2018-05-18 15:42:47');
INSERT INTO `nav_site` VALUES ('105', '开源中国', 'www.oschina.net', '28', '33', '开源中国社区', '2', '2018-05-19 22:19:59');
INSERT INTO `nav_site` VALUES ('108', 'GitHub', 'github.com', '29', '33', '代码托管中心', '1', '2018-05-19 23:53:56');
INSERT INTO `nav_site` VALUES ('109', 'Collect UI', 'www.collectui.com', '30', '31', 'Collect UI', '4', '2018-05-19 23:54:32');
INSERT INTO `nav_site` VALUES ('110', '优设', 'www.uisdc.com', '0', '31', '优设', '2', '2018-05-19 23:55:54');
INSERT INTO `nav_site` VALUES ('112', '追波', 'dribbble.com', '31', '31', '设计师创意作品', '3', '2018-05-19 23:57:38');
INSERT INTO `nav_site` VALUES ('113', '站酷', 'www.zcool.com.cn', '32', '31', '设计师互动平台', '1', '2018-05-21 09:01:50');
INSERT INTO `nav_site` VALUES ('114', '用友OA', '218.94.153.148:8888/seeyon/index.jsp', '0', '34', '天泽OA', '4', '2018-05-21 10:52:31');
INSERT INTO `nav_site` VALUES ('115', 'MVN仓库', 'mvnrepository.com', '0', '35', 'Maven Repository', '2', '2018-05-23 14:05:17');
INSERT INTO `nav_site` VALUES ('116', 'html模板', 'templated.co', '33', '36', '', '4', '2018-05-28 23:33:45');
INSERT INTO `nav_site` VALUES ('117', 'one page', 'onepagelove.com', '0', '36', '单页模版', '3', '2018-05-28 23:34:14');
INSERT INTO `nav_site` VALUES ('118', '禅道', '192.168.1.52:9999/zentao', '0', '34', '内网项目管理', '5', '2018-05-30 15:29:15');
INSERT INTO `nav_site` VALUES ('119', '用友NC', '218.94.153.148:666/hrss/login.jsp', '0', '34', '薪资管理', '6', '2018-06-04 09:09:32');
INSERT INTO `nav_site` VALUES ('120', 'Colorlib', 'colorlib.com', '0', '36', '免费网站模板', '2', '2018-06-13 10:02:54');
INSERT INTO `nav_site` VALUES ('121', '悬笔e绝', 'www.xuanbiyijue.com', '34', '37', '悬笔e绝 个人博客', '1', '2018-06-14 15:51:35');
INSERT INTO `nav_site` VALUES ('122', '绩效', '218.94.153.148:100', '0', '34', '天泽绩效', '7', '2018-06-20 16:35:43');
INSERT INTO `nav_site` VALUES ('123', '基站定位接口', 'www.cellocation.com/interfac', '0', '35', 'LBS数据仓库', '4', '2018-07-06 16:57:43');
INSERT INTO `nav_site` VALUES ('124', 'thinkrace', 'www.thinkrace.com', '0', '35', '智能设备', '6', '2018-07-09 23:12:50');
INSERT INTO `nav_site` VALUES ('125', '哈哈max', 'www.haha.mx', '35', '33', '搞笑那点儿事', '4', '2018-07-11 08:58:49');
INSERT INTO `nav_site` VALUES ('126', '经纬度查询', 'www.gpsspg.com/maps.htm', '36', '35', '经纬度地图', '5', '2018-07-16 17:04:55');
INSERT INTO `nav_site` VALUES ('127', 'icons8', 'icons8.com', '0', '31', 'Free Flat Icons免费图标', '5', '2018-07-21 21:48:39');
INSERT INTO `nav_site` VALUES ('129', ' SVG icons', 'www.iconfinder.com', '37', '31', '图标库', '7', '2018-07-21 21:50:58');
INSERT INTO `nav_site` VALUES ('130', 'html5', 'html5up.net', '0', '36', 'html5响应式模版', '6', '2018-07-24 14:51:02');
INSERT INTO `nav_site` VALUES ('131', 'CSDN', 'www.csdn.net', '38', '33', 'IT技术社区', '3', '2018-07-25 14:27:29');
INSERT INTO `nav_site` VALUES ('132', 'CSS Winner', 'www.csswinner.com', '39', '36', '样板网站', '7', '2018-07-25 15:47:19');
INSERT INTO `nav_site` VALUES ('134', 'WrapPixel', 'wrappixel.com', '0', '36', 'Bootstrap Admin ', '5', '2018-08-22 09:19:54');
INSERT INTO `nav_site` VALUES ('135', '格式转换', 'cn.office-converter.com', '0', '35', '在线格式转换', '3', '2018-09-26 16:06:46');
INSERT INTO `nav_site` VALUES ('137', '恒源监控平台', '58.218.48.238:2680', '0', '34', '', '1', '2018-10-18 20:02:24');
INSERT INTO `nav_site` VALUES ('139', '爱站', 'www.aizhan.com', '40', '38', '爱站网,  站长工具', '3', '2018-10-19 23:27:36');
INSERT INTO `nav_site` VALUES ('140', '站长之家', 'tool.chinaz.com', '0', '38', '站长工具，站长之家', '2', '2018-10-19 23:28:34');
INSERT INTO `nav_site` VALUES ('141', '广告联盟', 'www.shukoe.com', '0', '38', '广告联盟技巧', '5', '2018-10-23 22:23:30');
INSERT INTO `nav_site` VALUES ('143', '众人帮', 'zhongrenbang.net', '42', '38', '', '4', '2018-10-23 23:22:49');
INSERT INTO `nav_site` VALUES ('144', '百度统计', 'tongji.baidu.com', '43', '38', '集合网站、APP、线下零售统计，汇聚成全面的数据分析平台\r\n', '1', '2018-10-27 22:57:27');
INSERT INTO `nav_site` VALUES ('145', '365推广', 'www.365tui.com', '0', '38', '365流量点击专家', '6', '2018-10-28 00:51:02');
INSERT INTO `nav_site` VALUES ('147', '帝一流工具', 'dyltool.com', '0', '35', 'ICON图标在线转换', '1', '2018-11-01 14:42:04');
INSERT INTO `nav_site` VALUES ('148', '江苏教师教育', 'www.jste.net.cn/cmsplus/index.html', '0', '34', '江苏省教师教育网络联盟各成员单位共同建设的公益性、专业性、服务性的教师教育网站。', '2', '2018-11-05 08:15:12');
INSERT INTO `nav_site` VALUES ('149', '网站设计工作室', 'lorem.in', '0', '37', '一个有态度的开发团队', '3', '2018-11-05 14:11:36');
INSERT INTO `nav_site` VALUES ('150', '扣顶网络', 'blog.coding.net', '0', '37', '面向开发者和软件开发团队的专业云端开发平台', '4', '2018-11-05 14:13:10');
INSERT INTO `nav_site` VALUES ('151', 'Bootstrap Admin Templates', 'www.creative-tim.com', '0', '36', 'Download the best Bootstrap admin', '1', '2018-11-06 10:37:44');
INSERT INTO `nav_site` VALUES ('152', 'MATERIAL DESIGN', 'material.io/tools/icons', '44', '31', '原生图标', '6', '2018-11-06 15:27:46');
INSERT INTO `nav_site` VALUES ('153', 'css图标', 'materializecss.com', '0', '31', 'A modern responsive front-end framework based on Material Design', '8', '2018-11-09 13:26:10');
INSERT INTO `nav_site` VALUES ('154', '在线工具', 'tool.lu', '45', '38', '在线工具站', '0', '2018-11-10 22:41:45');
INSERT INTO `nav_site` VALUES ('169', '张甲博客', 'zhangjia.tv', '53', '37', '从初中开始就梦想着有一个自己的网站', '2', '2018-12-04 16:04:29');

-- ----------------------------
-- Table structure for nav_type
-- ----------------------------
DROP TABLE IF EXISTS `nav_type`;
CREATE TABLE `nav_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(5) DEFAULT NULL,
  `NAME` varchar(20) DEFAULT NULL,
  `SORT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='网址类型';

-- ----------------------------
-- Records of nav_type
-- ----------------------------
INSERT INTO `nav_type` VALUES ('4', null, '教程', '6');
INSERT INTO `nav_type` VALUES ('29', null, '综合', '1');
INSERT INTO `nav_type` VALUES ('30', null, '购物', '9');
INSERT INTO `nav_type` VALUES ('31', null, '设计', '7');
INSERT INTO `nav_type` VALUES ('33', null, '社区', '2');
INSERT INTO `nav_type` VALUES ('34', null, '办公', '10');
INSERT INTO `nav_type` VALUES ('35', null, 'IT', '3');
INSERT INTO `nav_type` VALUES ('36', null, 'HTML', '5');
INSERT INTO `nav_type` VALUES ('37', null, '博客', '8');
INSERT INTO `nav_type` VALUES ('38', null, 'SEO', '4');

-- ----------------------------
-- Table structure for rel_user_role
-- ----------------------------
DROP TABLE IF EXISTS `rel_user_role`;
CREATE TABLE `rel_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rel_user_role
-- ----------------------------
INSERT INTO `rel_user_role` VALUES ('48', '1', '1');

-- ----------------------------
-- Table structure for res_img
-- ----------------------------
DROP TABLE IF EXISTS `res_img`;
CREATE TABLE `res_img` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(100) DEFAULT NULL COMMENT '路径',
  `user_id` int(11) DEFAULT NULL COMMENT '所属用户',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COMMENT='图片资源';

-- ----------------------------
-- Records of res_img
-- ----------------------------
INSERT INTO `res_img` VALUES ('0', './upload/nav/unknown.png', null, null);
INSERT INTO `res_img` VALUES ('3', '.\\upload\\pic\\201811\\pic5204028673149667661.jpg', '1', '2018-11-16 10:28:54');
INSERT INTO `res_img` VALUES ('5', '.\\upload\\pic\\201811\\pic7550951990260583527.png', '1', '2018-11-23 16:49:47');
INSERT INTO `res_img` VALUES ('6', '.\\upload\\pic\\201811\\pic778904259101237387.jpg', '1', '2018-11-27 21:18:51');
INSERT INTO `res_img` VALUES ('8', '.\\upload\\pic\\201811\\pic1733341196402226671.jpg', '1', '2018-11-28 10:30:47');
INSERT INTO `res_img` VALUES ('9', '.\\upload\\pic\\201811\\pic8887282670831657456.png', '1', '2018-11-28 10:33:30');
INSERT INTO `res_img` VALUES ('10', '.\\upload\\pic\\201811\\pic3690816564149493613.jpg', '1', '2018-11-29 14:29:39');
INSERT INTO `res_img` VALUES ('15', '.\\upload\\pic\\201811\\pic1537625003943684602.jpg', '1', '2018-11-29 14:49:54');
INSERT INTO `res_img` VALUES ('16', '.\\upload\\pic\\201811\\pic5550947533808887582.jpg', '1', '2018-11-29 14:59:19');
INSERT INTO `res_img` VALUES ('17', '.\\upload\\pic\\201811\\pic3195053477649299809.jpg', '1', '2018-11-29 15:09:47');
INSERT INTO `res_img` VALUES ('18', '.\\upload\\pic\\201811\\pic8353165236788580441.png', '1', '2018-11-30 09:10:44');
INSERT INTO `res_img` VALUES ('19', '.\\upload\\pic\\201811\\pic6673666642545563428.png', '1', '2018-11-30 09:13:18');
INSERT INTO `res_img` VALUES ('20', '.\\upload\\pic\\201811\\pic255698524943846960.jpg', '1', '2018-11-30 22:29:22');
INSERT INTO `res_img` VALUES ('22', '.\\upload\\pic\\201812\\pic449347529002547911.png', '1', '2018-12-01 16:51:32');
INSERT INTO `res_img` VALUES ('24', './upload/nav/icon/icon6913048374137169941.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('25', './upload/nav/icon/icon4847216020769285621.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('26', './upload/nav/icon/icon6961302624607474104.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('27', './upload/nav/icon/icon2478977191638425815.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('28', './upload/nav/icon/icon1277877172443504134.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('29', './upload/nav/icon/icon1980162427419300092.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('30', './upload/nav/icon/icon8758936578823090736.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('31', './upload/nav/icon/icon4758864900014274635.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('32', './upload/nav/icon/icon2335670426781082746.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('33', './upload/nav/icon/icon4937138979905354104.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('34', './upload/nav/icon/icon6470490984486409721.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('35', './upload/nav/icon/icon3924112112093172094.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('36', './upload/nav/icon/icon7781571856844894725.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('37', './upload/nav/icon/icon5566927916572449782.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('38', './upload/nav/icon/icon1538902782487695558.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('39', './upload/nav/icon/icon3704146882469737955.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('40', './upload/nav/icon/icon4143416595776024217.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('41', './upload/nav/icon/icon2168067283061547766.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('42', './upload/nav/icon/icon6132438647135011705.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('43', './upload/nav/icon/icon1096774495345506151.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('44', './upload/nav/icon/icon6064730368314196762.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('45', './upload/nav/icon/icon7846155642767382404.png', '1', '2018-12-03 10:10:10');
INSERT INTO `res_img` VALUES ('53', './upload/nav/icon/icon1099619651465941541.png', '1', '2018-12-04 16:04:30');
INSERT INTO `res_img` VALUES ('55', './upload/pic/201812/img4442090588704517679.png', '1', '2018-12-04 16:25:54');

-- ----------------------------
-- Table structure for sys_asset
-- ----------------------------
DROP TABLE IF EXISTS `sys_asset`;
CREATE TABLE `sys_asset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '资源名称',
  `code` varchar(50) DEFAULT NULL COMMENT '资源代码',
  `pid` int(11) DEFAULT NULL COMMENT '父ID',
  `pids` varchar(80) DEFAULT NULL COMMENT '父节组ID',
  `type` varchar(50) DEFAULT NULL COMMENT '类型',
  `controller` varchar(100) DEFAULT NULL COMMENT '控制器',
  `view` varchar(100) DEFAULT NULL COMMENT '视图',
  `icon_css` varchar(100) DEFAULT NULL COMMENT '图标css',
  `is_menu` int(11) DEFAULT NULL COMMENT '是否菜单',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='系统资源';

-- ----------------------------
-- Records of sys_asset
-- ----------------------------
INSERT INTO `sys_asset` VALUES ('6', '用户管理', 'user', '5', '0/5', 'menu', 'console/user', 'console/sys/user', null, '1', '5');
INSERT INTO `sys_asset` VALUES ('7', '角色管理', 'role', '5', '0/5', 'menu', 'console/role', 'console/sys/role', null, '1', '10');
INSERT INTO `sys_asset` VALUES ('8', '菜单管理', 'menu', '5', '0/5', 'menu', 'console/menu', 'console/sys/menu', null, '1', '15');
INSERT INTO `sys_asset` VALUES ('1', '首页', 'index', '0', '0', 'menu', 'console', 'console/dashboard', 'dashboard', '1', '1');
INSERT INTO `sys_asset` VALUES ('5', '系统管理', 'sys', '0', '0', 'node', '', '', 'settings', '1', '100');
INSERT INTO `sys_asset` VALUES ('51', '我的博客', 'blog', '0', '0', 'node', '', '', 'chrome_reader_mode', '1', '20');
INSERT INTO `sys_asset` VALUES ('52', '文章管理', 'article', '51', '0/51', 'menu', 'console/article', 'console/blog/article', '', '1', '10');
INSERT INTO `sys_asset` VALUES ('53', '文章编辑', 'editor', '51', '0/51', 'menu', 'console/editor', 'console/blog/editor', '', '1', '20');
INSERT INTO `sys_asset` VALUES ('54', '导航管理', 'nav', '0', '0', 'node', '', '', 'near_me', '1', '50');
INSERT INTO `sys_asset` VALUES ('55', '网址管理', 'website', '54', '0/54', 'menu', 'console/site.1', 'console/nav/site', '', '1', '5');
INSERT INTO `sys_asset` VALUES ('56', '网址类型', 'siteType', '54', '0/54', 'menu', 'console/site.2', 'console/nav/type', '', '1', '10');

-- ----------------------------
-- Table structure for sys_privilege
-- ----------------------------
DROP TABLE IF EXISTS `sys_privilege`;
CREATE TABLE `sys_privilege` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `master` varchar(50) DEFAULT NULL,
  `master_value` varchar(100) DEFAULT NULL,
  `access` varchar(50) DEFAULT NULL,
  `access_value` varchar(200) DEFAULT NULL,
  `permission` varchar(50) DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=369 DEFAULT CHARSET=utf8 COMMENT='权限';

-- ----------------------------
-- Records of sys_privilege
-- ----------------------------
INSERT INTO `sys_privilege` VALUES ('366', 'role', '1', 'menu', '53', 'blog:editor', null);
INSERT INTO `sys_privilege` VALUES ('365', 'role', '1', 'menu', '52', 'blog:article', null);
INSERT INTO `sys_privilege` VALUES ('364', 'role', '1', 'menu', '8', 'sys:menu', null);
INSERT INTO `sys_privilege` VALUES ('363', 'role', '1', 'menu', '7', 'sys:role', null);
INSERT INTO `sys_privilege` VALUES ('362', 'role', '1', 'menu', '6', 'sys:user', null);
INSERT INTO `sys_privilege` VALUES ('361', 'role', '1', 'menu', '1', 'console:index', null);
INSERT INTO `sys_privilege` VALUES ('367', 'role', '1', 'menu', '55', 'nav:website', null);
INSERT INTO `sys_privilege` VALUES ('368', 'role', '1', 'menu', '56', 'nav:siteType', null);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) DEFAULT NULL COMMENT '角色名称',
  `code` varchar(30) DEFAULT NULL COMMENT '角色代码',
  `comment` varchar(100) DEFAULT NULL COMMENT '角色描述',
  `create_user` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', null, '管理员角色', 'admin', '管理员角色', 'admin', '2018-09-16 00:24:55');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `password` varchar(80) DEFAULT NULL COMMENT '登录密码',
  `salt` varchar(50) DEFAULT NULL COMMENT '盐',
  `name` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `tel` varchar(15) DEFAULT NULL COMMENT '联系电话',
  `org_id` int(11) DEFAULT NULL COMMENT '用户所属机构',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(50) DEFAULT NULL COMMENT '创建人',
  `status` int(11) DEFAULT NULL COMMENT '用户状态',
  `user_icon` varchar(100) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `login_count` int(11) DEFAULT NULL COMMENT '登陆次数',
  `last_login_ip` varchar(20) DEFAULT NULL COMMENT '最后登陆IP',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登陆时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'd120aa7fe2afdc7c2808b13d679d2e19', '65f5ee4e13d26a3ca645cf4dc111d299', '管理员', '87166669@dyl.com', '18086776931', null, '2018-11-13 09:15:36', null, null, 'icon26586743348640622.jpg', '积极进取，持之以恒。', '2020-05-20 00:00:00', '1513', '0:0:0:0:0:0:0:1', '2018-12-20 22:25:24');
