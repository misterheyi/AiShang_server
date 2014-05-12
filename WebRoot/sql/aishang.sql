/*
MySQL Data Transfer
Source Host: localhost
Source Database: aishang
Target Host: localhost
Target Database: aishang
Date: 2014/5/12 21:10:51
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for adpicture
-- ----------------------------
CREATE TABLE `adpicture` (
  `adPicture_id` int(11) NOT NULL AUTO_INCREMENT,
  `adPicture_path` varchar(200) NOT NULL,
  `adPicture_desc` varchar(200) DEFAULT NULL,
  `adPicture_count` int(11) DEFAULT '0',
  `users_id` int(11) NOT NULL,
  `adPictureGroup_id` int(11) NOT NULL,
  PRIMARY KEY (`adPicture_id`)
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for advideo
-- ----------------------------
CREATE TABLE `advideo` (
  `adVideo_id` int(11) NOT NULL AUTO_INCREMENT,
  `adVideo_path` varchar(200) NOT NULL,
  `adVideo_desc` varchar(45) NOT NULL,
  `adVideo_count` int(11) DEFAULT '0',
  `users_id` int(11) NOT NULL,
  `adVideo_type` int(11) NOT NULL,
  PRIMARY KEY (`adVideo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for appversion
-- ----------------------------
CREATE TABLE `appversion` (
  `av_id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`av_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for hairstyle
-- ----------------------------
CREATE TABLE `hairstyle` (
  `hairStyle_id` int(11) NOT NULL AUTO_INCREMENT,
  `hairStyle_sex` varchar(45) NOT NULL,
  `hairStyle_area` varchar(45) NOT NULL,
  `hairStyle_height` varchar(45) NOT NULL,
  `hairStyle_desc` varchar(45) NOT NULL,
  `hairStyle_path` varchar(200) NOT NULL,
  `users_id` int(11) NOT NULL,
  PRIMARY KEY (`hairStyle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for hairstyle_area
-- ----------------------------
CREATE TABLE `hairstyle_area` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for hairstyle_desc
-- ----------------------------
CREATE TABLE `hairstyle_desc` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for hairstyle_height
-- ----------------------------
CREATE TABLE `hairstyle_height` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for hairstyle_sex
-- ----------------------------
CREATE TABLE `hairstyle_sex` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for markhairstyle
-- ----------------------------
CREATE TABLE `markhairstyle` (
  `markHairStyle_id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) NOT NULL,
  `hairStyle_id` int(11) NOT NULL,
  PRIMARY KEY (`markHairStyle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for system_setting
-- ----------------------------
CREATE TABLE `system_setting` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `setting_type` varchar(45) NOT NULL,
  `setting_value` varchar(45) NOT NULL,
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uploadauth
-- ----------------------------
CREATE TABLE `uploadauth` (
  `auth_id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) NOT NULL,
  `allow_video_num` int(11) NOT NULL DEFAULT '0',
  `allow_picture_num` int(11) NOT NULL DEFAULT '0',
  `used_video_num` int(11) NOT NULL DEFAULT '0',
  `used_picture_num` int(11) NOT NULL DEFAULT '0',
  `is_open` char(1) NOT NULL COMMENT '1为开通，0为不开通',
  PRIMARY KEY (`auth_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for usergroup
-- ----------------------------
CREATE TABLE `usergroup` (
  `userGroup_id` int(11) NOT NULL AUTO_INCREMENT,
  `userGroup_name` varchar(45) NOT NULL,
  `userGroup_desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`userGroup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for userrelation
-- ----------------------------
CREATE TABLE `userrelation` (
  `userRelation_id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) NOT NULL,
  `users_id2` int(11) NOT NULL,
  PRIMARY KEY (`userRelation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for users
-- ----------------------------
CREATE TABLE `users` (
  `users_id` int(11) NOT NULL AUTO_INCREMENT,
  `users_name` varchar(45) NOT NULL,
  `users_email` varchar(45) NOT NULL,
  `users_password` varchar(45) NOT NULL,
  `users_face` varchar(256) NOT NULL DEFAULT 'resources/images/user_default.png',
  `users_IMEI` varchar(45) NOT NULL,
  `userGroup_id` int(11) NOT NULL,
  PRIMARY KEY (`users_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10072 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `adpicture` VALUES ('118', '/ad/picture/10037/2f60f796-899f-4e33-884f-bfee7f9582d9.png', '', '0', '10037', '1');
INSERT INTO `adpicture` VALUES ('119', '/ad/picture/10037/d9d421c3-01c3-4508-95df-76050e77f253.png', '', '0', '10037', '2');
INSERT INTO `adpicture` VALUES ('120', '/ad/picture/10037/c3a1ac1b-85cb-46a1-91a9-5918480dc4d8.png', '', '0', '10037', '3');
INSERT INTO `adpicture` VALUES ('152', '/ad/picture/10040/7de8f5d3-820c-443c-9710-15dd3bd399a2.png', 'xx', '0', '10040', '1');
INSERT INTO `adpicture` VALUES ('158', '/ad/picture/10003/4f729c28-8faa-488b-b1fb-d89701533697.jpg', '001', '0', '10003', '3');
INSERT INTO `adpicture` VALUES ('160', '/ad/picture/10003/9f2c2c86-1657-4ee9-9b4a-2e36bcd072a8.jpg', 'J002', '0', '10003', '3');
INSERT INTO `adpicture` VALUES ('161', '/ad/picture/10003/d9cfbbe5-8f12-4ff9-a465-1bfe2c351c86.jpg', 'J003', '0', '10003', '3');
INSERT INTO `adpicture` VALUES ('162', '/ad/picture/10003/58b10b4c-7792-464d-be6f-f2515f6897ff.jpg', 'J005', '0', '10003', '3');
INSERT INTO `adpicture` VALUES ('163', '/ad/picture/10003/feaf3ebf-f70d-480c-bfb5-a8e7949085c5.jpg', 'J006', '0', '10003', '3');
INSERT INTO `adpicture` VALUES ('164', '/ad/picture/10003/6428767b-43a1-4f49-96c5-d79c516cfdc0.jpg', 'J007', '0', '10003', '3');
INSERT INTO `adpicture` VALUES ('165', '/ad/picture/10003/51fe0dd5-1e39-4d52-be41-d6a671cce33b.jpg', 'J008', '0', '10003', '3');
INSERT INTO `adpicture` VALUES ('166', '/ad/picture/10003/2d12a16f-ad58-4391-a682-d3f9ccabe1b8.jpg', 'T001', '0', '10003', '2');
INSERT INTO `adpicture` VALUES ('167', '/ad/picture/10003/6e244ffc-1a58-48f4-a223-72b366bc74e5.jpg', 'T002', '0', '10003', '2');
INSERT INTO `adpicture` VALUES ('168', '/ad/picture/10003/8ef131cc-c325-4f80-a18f-c42980c221f7.jpg', 'C001', '0', '10003', '1');
INSERT INTO `adpicture` VALUES ('169', '/ad/picture/10003/f1be5f47-7898-4644-8c78-4063868c6d04.jpg', 'C002', '0', '10003', '1');
INSERT INTO `adpicture` VALUES ('170', '/ad/picture/10003/a9264558-28e2-4878-b4ca-34d550ac6ce7.jpg', 'C003', '0', '10003', '1');
INSERT INTO `adpicture` VALUES ('257', '/ad/picture/10056/44a3addd-9646-412f-b0da-4aaeb31ea500.jpg', '1', '0', '10056', '1');
INSERT INTO `adpicture` VALUES ('258', '/ad/picture/10056/72a9e56a-482b-4f20-b364-0839d4f676c2.jpg', '2', '0', '10056', '1');
INSERT INTO `adpicture` VALUES ('259', '/ad/picture/10056/5e407cda-e26e-4bea-be8b-79483dfd51e2.jpg', '3', '0', '10056', '1');
INSERT INTO `adpicture` VALUES ('260', '/ad/picture/10056/af9835ef-560c-4905-941e-5ded22212b4d.jpg', '12', '0', '10056', '2');
INSERT INTO `adpicture` VALUES ('261', '/ad/picture/10056/c06e4412-a9bf-4cb0-9305-dda35df96394.jpg', '14', '0', '10056', '2');
INSERT INTO `adpicture` VALUES ('262', '/ad/picture/10056/d7da7bf7-87b7-4f3e-8cd0-cfb5acfa19c0.jpg', '11', '0', '10056', '2');
INSERT INTO `adpicture` VALUES ('263', '/ad/picture/10056/5a1479a1-4eb3-444b-9db1-3a9710a52b2f.jpg', 'a', '0', '10056', '3');
INSERT INTO `adpicture` VALUES ('264', '/ad/picture/10056/e881fbf2-1d2a-479e-863f-230aa3df7f5e.jpg', 'b', '0', '10056', '3');
INSERT INTO `adpicture` VALUES ('265', '/ad/picture/10054/2799ad58-02c0-4a84-a725-e29c528a5a7c.jpg', '123', '1', '10054', '4');
INSERT INTO `adpicture` VALUES ('266', '/ad/picture/10054/7b565634-2d6c-42cb-b7e8-171f6916420c.jpg', '134', '1', '10054', '4');
INSERT INTO `adpicture` VALUES ('269', '/ad/picture/10065/3b655223-6e8f-405f-9e8a-c409cda2cefa.jpg', '123', '0', '10065', '1');
INSERT INTO `adpicture` VALUES ('270', '/ad/picture/10065/9be2638c-c101-4424-ac3a-1a9b42323bd1.jpg', '124', '0', '10065', '1');
INSERT INTO `adpicture` VALUES ('271', '/ad/picture/10065/e3fb9831-d153-468f-9804-dc4d86ba85d2.jpg', '125', '0', '10065', '1');
INSERT INTO `adpicture` VALUES ('272', '/ad/picture/10065/1912f6e3-61ef-4bfd-9730-8a6f5ad522a3.jpg', '210', '0', '10065', '2');
INSERT INTO `adpicture` VALUES ('274', '/ad/picture/10065/3668d8db-8497-4d64-8fbd-795197b520c1.jpg', '212', '0', '10065', '2');
INSERT INTO `adpicture` VALUES ('275', '/ad/picture/10065/d33e5a65-c874-4ad8-8698-6f253ce33e96.jpg', '311', '0', '10065', '3');
INSERT INTO `adpicture` VALUES ('277', '/ad/picture/10065/8e264161-af38-404f-9e01-d2e78ecef200.jpg', '213', '0', '10065', '3');
INSERT INTO `adpicture` VALUES ('278', '/ad/picture/10065/0f3c1f47-32de-4edf-a7ed-52908ca2e651.jpg', '214', '0', '10065', '3');
INSERT INTO `adpicture` VALUES ('279', '/ad/picture/10065/aa1e9897-521e-4c21-acff-15b46334f9f3.jpg', '215', '0', '10065', '3');
INSERT INTO `adpicture` VALUES ('280', '/ad/picture/10065/579234e7-81b9-44a2-af2a-d42d565e2d02.jpg', '216', '0', '10065', '3');
INSERT INTO `adpicture` VALUES ('282', '/ad/picture/10065/1c6c2010-b27b-4ac6-a563-9a627001e988.jpg', '217', '0', '10065', '3');
INSERT INTO `adpicture` VALUES ('283', '/ad/picture/10055/ccd7ade1-0356-4856-8785-902d6a03d365.jpg', '001', '1', '10055', '4');
INSERT INTO `adpicture` VALUES ('284', '/ad/picture/10055/1ca58194-31c1-4c6f-b0c4-87bcce25cec7.jpg', '002', '1', '10055', '4');
INSERT INTO `adpicture` VALUES ('285', '/ad/picture/10055/b2935e51-6eb0-44c8-bef4-1e1dd3522be7.jpg', '003', '1', '10055', '4');
INSERT INTO `adpicture` VALUES ('286', '/ad/picture/10055/b094eb0c-5899-4504-9585-b22faafb7415.jpg', '004', '1', '10055', '4');
INSERT INTO `adpicture` VALUES ('287', '/ad/picture/10055/a1229f73-8664-4159-9ed9-94547d5f6aa1.jpg', '005', '1', '10055', '4');
INSERT INTO `adpicture` VALUES ('288', '/ad/picture/10055/a9018615-0e74-452d-b933-1a96ef0c2d7b.jpg', '006', '1', '10055', '4');
INSERT INTO `adpicture` VALUES ('289', '/ad/picture/10055/6de48ec2-7ccc-4a0c-9eb1-25b2205f4ac6.jpg', '007', '1', '10055', '4');
INSERT INTO `adpicture` VALUES ('290', '/ad/picture/10055/ebf9de99-5a05-43b3-85df-5015ec7e347f.jpg', '008', '1', '10055', '4');
INSERT INTO `adpicture` VALUES ('291', '/ad/picture/10055/774b96b6-896b-47fa-9391-e68b7ce2c05d.jpg', '009', '1', '10055', '4');
INSERT INTO `adpicture` VALUES ('292', '/ad/picture/10055/29a4a4eb-b378-47d4-9155-79451c53edfc.jpg', '009', '1', '10055', '4');
INSERT INTO `adpicture` VALUES ('293', '/ad/picture/10055/6b381cc7-b741-468a-b1fe-b59b05d1164f.jpg', '010', '1', '10055', '4');
INSERT INTO `adpicture` VALUES ('294', '/ad/picture/10055/11fa31cc-b265-4b61-a509-05c10fef7993.jpg', '012', '1', '10055', '4');
INSERT INTO `adpicture` VALUES ('295', '/ad/picture/10001/fc7519aabba1465a8f1528b68952d9dd.jpg', '发捷标志', '1', '10001', '4');
INSERT INTO `adpicture` VALUES ('296', '/ad/picture/10001/7db35a6af802428c8e709eba144b7056.jpg', '滚动广告金圣', '1', '10001', '4');
INSERT INTO `adpicture` VALUES ('297', '/ad/picture/10001/90c9276b41124724b2d3972d3336455f.jpg', '滚动广告香烟红塔山', '1', '10001', '4');
INSERT INTO `adpicture` VALUES ('298', '/ad/picture/10001/0960d6ed006545008b4c7ccb8151c492.jpg', '滚动广告香烟黄鹤楼', '1', '10001', '4');
INSERT INTO `adpicture` VALUES ('299', '/ad/picture/10001/d4d07edc7bf042c78a0de233f3a6576a.jpg', '滚动广告香烟七匹狼', '1', '10001', '4');
INSERT INTO `adpicture` VALUES ('304', 'upload/ad/picture/10003/84cb4f9338c4472d95c7c59ef08ed9d9.png', '11', '0', '10003', '1');
INSERT INTO `advideo` VALUES ('72', '/ad/video/10001/f9b34756-89b7-4775-93f6-b0475dcdd2d4.mp4', '高清大众汽车', '9171', '10001', '0');
INSERT INTO `advideo` VALUES ('73', '/ad/video/10001/91b4a23b-0181-4e7b-8890-0c23536f5d01.mp4', '高清ZP', '5204', '10001', '0');
INSERT INTO `advideo` VALUES ('74', '/ad/video/10001/2ac1c2bc-ac07-4e2c-a91a-93de40b23b25.mp4', '高清三星', '5264', '10001', '0');
INSERT INTO `advideo` VALUES ('75', '/ad/video/10001/a5c37e13-37df-49f6-af37-19962e035713.mp4', '高清三星相机', '6592', '10001', '0');
INSERT INTO `advideo` VALUES ('76', '/ad/video/10001/bc16d8b1-3429-4077-8c9d-c7ae574527fe.mp4', '高清丰田', '7222', '10001', '0');
INSERT INTO `advideo` VALUES ('77', '/ad/video/10001/9dc6a1fd-ec51-46f2-acf0-c0d376b2f1db.mp4', '高清香水', '9807', '10001', '0');
INSERT INTO `advideo` VALUES ('79', '/ad/video/10001/b9cf9ac8-526c-47cd-9951-225b5a53a3bf.mp4', '高清三星超薄电脑2', '5973', '10001', '0');
INSERT INTO `advideo` VALUES ('87', '/ad/video/10054/e740ac29-9aaa-40f5-a322-e64a2e0781f0.mp4', '456', '5212', '10054', '0');
INSERT INTO `advideo` VALUES ('88', '/ad/video/10054/81040ed5-5042-4318-a804-6b78370cae3a.mp4', '564', '5267', '10054', '0');
INSERT INTO `advideo` VALUES ('92', '/ad/video/10000/def5167e-f89f-4364-a92c-7aef68aa95a0.mp4', '超级管理员点选视频测试', '301', '10000', '1');
INSERT INTO `advideo` VALUES ('93', '/ad/video/10055/66c4aa8e-115b-476d-961e-40d03c384915.mp4', '美发厅视频', '7042', '10055', '0');
INSERT INTO `advideo` VALUES ('94', 'upload/ad/video/10000/0e41cebae6e346abb06d2971cb63c58c.mp4', '测试视频1', '0', '10000', '0');
INSERT INTO `hairstyle` VALUES ('132', '女性', '亚洲', '长', '新锐个性', '/hairstyle/10001/684bec5a-1f27-4481-8be5-824ccb8b1537.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('133', '女性', '亚洲', '长', '新锐个性', '/hairstyle/10001/433a9da2-860b-4830-8434-ee844819ea99.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('134', '女性', '欧洲', '长', '新锐个性', '/hairstyle/10001/c6a07fe8-8b78-4426-96c5-001db2f6009f.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('135', '女性', '亚洲', '长', '新锐个性', '/hairstyle/10001/bdfe7639-e599-4771-89c9-4dedb713a94d.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('136', '女性', '欧洲', '长', '新锐个性', '/hairstyle/10001/77cd6bd5-6d5f-4360-bce9-a429282a64c2.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('137', '女性', '亚洲', '长', '端庄典雅', '/hairstyle/10001/b63d2447-ee6e-4f0b-b820-420d4e6d7f28.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('138', '女性', '亚洲', '中', '活泼可爱', '/hairstyle/10001/e88445fa-c74e-4be9-b861-eca4f7a6d61a.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('139', '女性', '亚洲', '中', '优雅时尚', '/hairstyle/10001/dcace6f1-051d-4815-aa3c-79dc8b302067.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('140', '女性', '亚洲', '长', '端庄典雅', '/hairstyle/10001/fb038b8a-e97c-4d8d-8ea8-3a8e64c5e909.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('141', '女性', '亚洲', '长', '端庄典雅', '/hairstyle/10001/44fbbd4b-4a6f-43c2-bd86-6bff278414a9.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('142', '女性', '亚洲', '短', '优雅时尚', '/hairstyle/10001/876d5a86-1a13-4d05-be67-6ded01cc5073.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('143', '女性', '亚洲', '长', '新锐个性', '/hairstyle/10001/731a5cbb-bce8-46c3-84b7-2b37149910f1.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('144', '女性', '欧洲', '长', '新锐个性', '/hairstyle/10001/6646d8ed-ae83-4545-be2d-bd96c53a723b.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('145', '女性', '亚洲', '长', '端庄典雅', '/hairstyle/10001/3acb0be0-142d-48ef-886f-4e1b76e10074.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('146', '女性', '亚洲', '长', '新锐个性', '/hairstyle/10001/b541fa66-0303-43b5-b13e-7d938f8c9124.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('147', '女性', '亚洲', '长', '新锐个性', '/hairstyle/10001/44f7cf8b-23a2-4090-8846-de59f11fa54b.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('148', '女性', '欧洲', '中', '优雅时尚', '/hairstyle/10000/0cdf324f-c237-42e6-91d7-a2b9f64bfb5a.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('149', '男性', '欧洲', '短', '优雅时尚', '/hairstyle/10000/fa2724e0-393a-4d7a-ae2f-1dd5d7273c7b.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('150', '男性', '欧洲', '短', '新锐个性', '/hairstyle/10000/358ea943-6955-4595-8072-8f5ba82c6861.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('151', '女性', '欧洲', '短', '优雅时尚', '/hairstyle/10000/49b80422-6134-44d1-988f-1833062f4a65.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('152', '女性', '亚洲', '中', '优雅时尚', '/hairstyle/10000/108c9132-f4a2-4b1f-bc55-50e004e7de91.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('154', '男性', '亚洲', '短', '端庄典雅', '/hairstyle/10000/7bca8463-b30f-48cf-995e-bfe42c000c68.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('155', '女性', '亚洲', '中', '端庄典雅', '/hairstyle/10000/6246a144-a7b2-4c05-98e0-aad883e25fc7.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('156', '女性', '亚洲', '中', '优雅时尚', '/hairstyle/10000/1a09f456-b29a-432f-9310-8f7c58c2229e.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('157', '女性', '亚洲', '中', '优雅时尚', '/hairstyle/10000/eba6c07a-611e-4d0c-ac1c-72d77f8bffa9.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('158', '女性', '亚洲', '中', '活泼可爱', '/hairstyle/10000/fc2fcdc2-a92f-40bf-a3db-e2967585b238.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('159', '女性', '亚洲', '中', '活泼可爱', '/hairstyle/10000/ec117b35-d7fb-4c9d-88d1-e71a61612fb1.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('160', '女性', '亚洲', '中', '活泼可爱', '/hairstyle/10000/cc2f5c2a-c9b2-4b1c-a4c4-021b68e5122f.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('161', '女性', '亚洲', '长', '活泼可爱', '/hairstyle/10000/00449f1c-35ca-4b6d-a870-f888b7338a8f.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('162', '女性', '亚洲', '长', '活泼可爱', '/hairstyle/10000/5deb13db-154d-4ddb-bb5a-c1e1a6b61fa0.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('163', '女性', '欧洲', '短', '新锐个性', '/hairstyle/10000/fa68e885-b9c5-40de-abd6-863ff380b143.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('164', '男性', '欧洲', '短', '新锐个性', '/hairstyle/10000/4251bf57-757c-4366-b3c6-0acdb3f2f493.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('165', '女性', '亚洲', '中', '端庄典雅', '/hairstyle/10000/a6059cdb-ec82-4e1e-b17f-f91bfb0c0489.jpg', '10000');
INSERT INTO `hairstyle` VALUES ('166', '女性', '亚洲', '中', '端庄典雅', '/hairstyle/10001/c533fe99-0180-48f0-9fcf-98d6f49ff815.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('167', '女性', '亚洲', '中', '端庄典雅', '/hairstyle/10001/f34d9150-72da-4bcc-8f54-adcfe991dfd0.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('168', '女性', '亚洲', '短', '优雅时尚', '/hairstyle/10001/1d859eb4-61c7-47b3-bf61-5d0d4bdb8c33.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('169', '男性', '欧洲', '短', '新锐个性', '/hairstyle/10001/69f7fdd4-9094-415b-ad6e-498b6a0faf85.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('170', '女性', '亚洲', '短', '盘发扎发', '/hairstyle/10001/dfaf1fc3-1496-4dce-9f9b-0d1a11a99749.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('171', '女性', '亚洲', '中', '活泼可爱', '/hairstyle/10001/482841f8-6742-414b-b606-e7d949bda921.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('172', '女性', '亚洲', '中', '优雅时尚', '/hairstyle/10001/6d90df5c-f9ee-4086-bbaf-4e9e30385ed4.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('173', '女性', '亚洲', '中', '端庄典雅', '/hairstyle/10001/83e26e89-328d-4e23-9a87-ef6d0f465ee4.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('174', '女性', '亚洲', '中', '优雅时尚', '/hairstyle/10001/bbafea25-0b67-40a6-b190-dab317d5c559.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('175', '女性', '亚洲', '短', '活泼可爱', '/hairstyle/10001/f26afc53-ab3a-458c-ac54-c8add3d8d210.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('176', '女性', '亚洲', '中', '端庄典雅', '/hairstyle/10001/f9a33164-3873-42ed-b42c-c3da8144ef90.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('177', '女性', '亚洲', '长', '端庄典雅', '/hairstyle/10001/1dff7434-30de-40c7-8c42-ec007da2f8bb.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('178', '女性', '亚洲', '中', '端庄典雅', '/hairstyle/10001/7f50012f-774d-4e2d-b1c4-fc32afe57faa.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('179', '女性', '亚洲', '长', '优雅时尚', '/hairstyle/10001/c01cdaa2-ce4b-4f1d-b2ec-87583b334627.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('180', '女性', '亚洲', '中', '端庄典雅', '/hairstyle/10001/e86b4e28-9da2-4f97-8891-50b5dfa7876b.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('181', '女性', '亚洲', '长', '活泼可爱', '/hairstyle/10001/dad1235b-a860-4f96-a0a5-ddd447a3a1e6.jpg', '10001');
INSERT INTO `hairstyle` VALUES ('182', '女性', '亚洲', '中', '端庄典雅', '/hairstyle/10051/bd4aa362-c72d-46a9-bae1-9a36e88969ab.jpg', '10051');
INSERT INTO `hairstyle` VALUES ('183', '男性', '欧洲', '短', '新锐个性', '/hairstyle/10051/eafac9d8-142e-4243-8013-3011ebdbec58.jpg', '10051');
INSERT INTO `hairstyle` VALUES ('184', '女性', '亚洲', '长', '活泼可爱', '/hairstyle/10056/36a5863b-9e4a-44b3-a4f3-67ed6a157864.jpg', '10056');
INSERT INTO `hairstyle` VALUES ('185', '女性', '亚洲', '长', '活泼可爱', '/hairstyle/10056/6a495836-f63d-42a9-b570-29adb9e45e7a.jpg', '10056');
INSERT INTO `hairstyle` VALUES ('191', '女性', '欧洲', '长', '新锐个性', '/hairstyle/10065/49beae1d-c27f-45cc-91aa-c0142cbee2aa.jpg', '10065');
INSERT INTO `hairstyle` VALUES ('192', '女性', '亚洲', '中', '端庄典雅', '/hairstyle/10065/17b8204b-f6a6-4068-90ba-9f93b3baa6f8.jpg', '10065');
INSERT INTO `hairstyle` VALUES ('193', '女性', '欧洲', '长', '新锐个性', '/hairstyle/10065/96d3c0ac-efa8-4630-86ff-12cd46af6421.jpg', '10065');
INSERT INTO `hairstyle` VALUES ('194', '女性', '亚洲', '长', '活泼可爱', '/hairstyle/10065/2f2f55d2-3ffb-4692-8e9b-413a0fe86a46.jpg', '10065');
INSERT INTO `hairstyle` VALUES ('195', '女性', '亚洲', '长', '优雅时尚', '/hairstyle/10065/21bfd1ad-d35b-49b6-ae0d-6b263159d3e7.jpg', '10065');
INSERT INTO `hairstyle_area` VALUES ('1', '亚洲');
INSERT INTO `hairstyle_area` VALUES ('2', '欧洲');
INSERT INTO `hairstyle_desc` VALUES ('1', '活泼可爱');
INSERT INTO `hairstyle_desc` VALUES ('2', '端庄典雅');
INSERT INTO `hairstyle_desc` VALUES ('3', '优雅时尚');
INSERT INTO `hairstyle_desc` VALUES ('4', '新锐个性');
INSERT INTO `hairstyle_desc` VALUES ('5', '盘发扎发');
INSERT INTO `hairstyle_height` VALUES ('1', '长');
INSERT INTO `hairstyle_height` VALUES ('2', '中');
INSERT INTO `hairstyle_height` VALUES ('3', '短');
INSERT INTO `hairstyle_sex` VALUES ('1', '男性');
INSERT INTO `hairstyle_sex` VALUES ('2', '女性');
INSERT INTO `markhairstyle` VALUES ('2', '10047', '133');
INSERT INTO `markhairstyle` VALUES ('3', '10045', '170');
INSERT INTO `system_setting` VALUES ('1', 'upload_pwd', '123456');
INSERT INTO `usergroup` VALUES ('1', '超级管理员', '超级管理员');
INSERT INTO `usergroup` VALUES ('2', '代理商', '代理商');
INSERT INTO `usergroup` VALUES ('3', '美发店', '美发店');
INSERT INTO `usergroup` VALUES ('4', '发型师', '发型师');
INSERT INTO `userrelation` VALUES ('22', '10040', '10042');
INSERT INTO `userrelation` VALUES ('25', '10003', '10045');
INSERT INTO `userrelation` VALUES ('26', '10003', '10046');
INSERT INTO `userrelation` VALUES ('27', '10003', '10047');
INSERT INTO `userrelation` VALUES ('28', '10003', '10048');
INSERT INTO `userrelation` VALUES ('29', '10003', '10049');
INSERT INTO `userrelation` VALUES ('30', '10003', '10050');
INSERT INTO `userrelation` VALUES ('31', '10003', '10051');
INSERT INTO `userrelation` VALUES ('32', '10054', '10056');
INSERT INTO `userrelation` VALUES ('35', '10001', '10003');
INSERT INTO `userrelation` VALUES ('37', '10056', '10061');
INSERT INTO `userrelation` VALUES ('38', '10055', '10062');
INSERT INTO `userrelation` VALUES ('39', '10062', '10064');
INSERT INTO `userrelation` VALUES ('40', '10055', '10065');
INSERT INTO `userrelation` VALUES ('41', '10065', '10066');
INSERT INTO `userrelation` VALUES ('42', '10065', '10067');
INSERT INTO `userrelation` VALUES ('43', '10065', '10068');
INSERT INTO `userrelation` VALUES ('44', '10065', '10069');
INSERT INTO `userrelation` VALUES ('45', '10065', '10070');
INSERT INTO `userrelation` VALUES ('46', '10065', '10071');
INSERT INTO `users` VALUES ('10000', '超级管理员', 'admin@aishang.com', '123456', 'null', 'null', '1');
INSERT INTO `users` VALUES ('10001', '爱尚网-小刘', 'xiaoliu@aishang.com', '123456', 'null', 'null', '2');
INSERT INTO `users` VALUES ('10003', '标榜美发店', 'biaobang@aishang.com', '123456', 'null', 'null', '3');
INSERT INTO `users` VALUES ('10008', '爱尚网-小杨', 'xiaoyang@aishang.com', '123456', 'null', 'null', '2');
INSERT INTO `users` VALUES ('10025', '喵喵-XX', 'mm-xx@aishang.com', '12345', 'null', '111111234sds', '4');
INSERT INTO `users` VALUES ('10028', '店小二', '2@1.com', '1', 'upload/users/10027/195eabf0-bbfd-4e84-b219-97b03b19a283.jpg', '123123', '4');
INSERT INTO `users` VALUES ('10030', '王宇', '1113722061@qq.com', '', 'upload/users/10029/c195c124-7f48-457b-8647-f13caca33b1a.jpg', '123456', '4');
INSERT INTO `users` VALUES ('10038', '测试发型师', 'testFXS@qq.com', '123456', 'resources/images/user_default.png', '11111', '4');
INSERT INTO `users` VALUES ('10040', ' 皇室威妮', 'hswn@aishang.com', '123456', 'null', 'null', '3');
INSERT INTO `users` VALUES ('10041', '李正伟', '123@163.com', '123456', 'resources/images/user_default.png', '123456', '4');
INSERT INTO `users` VALUES ('10042', '李正伟', '11111111@163.com', '123456', '/users/10040/2804a6d5-7aac-47ad-b926-9415673a71c7.jpg', '123456', '4');
INSERT INTO `users` VALUES ('10045', '周鸿乾', 'zhouhongqian@aishang.com', '123456', '/users/10003/a9e05201-25d7-41ad-b044-e7f7b9dfb724.jpg', '123456', '4');
INSERT INTO `users` VALUES ('10046', 'USKI', 'USKI@aishang.com', '123456', '/users/10003/464cb9cf-69b9-49b2-bc18-0922f14edc44.jpg', '123456', '4');
INSERT INTO `users` VALUES ('10047', '比利', 'bili@aishang.com', '123456', '/users/10003/2b25ba72-5865-459c-8ece-33797e8bc12d.jpg', '123456', '4');
INSERT INTO `users` VALUES ('10048', '郭建平', ' guojianpin@aishang.com', '123456', '/users/10003/d004c8d3-9308-48db-b706-5fe2d8f7dee0.jpg', '123456', '4');
INSERT INTO `users` VALUES ('10049', '李林', 'lilin@aishang.com', '123456', '/users/10003/9c2c97ca-29b6-4860-96d4-7f9d2962d168.jpg', '123', '4');
INSERT INTO `users` VALUES ('10050', '阿乐', 'ale@aishang.com', '123456', '/users/10003/0766cf71-2ecb-409e-a41b-2b9c4ea8828e.jpg', '123456', '4');
INSERT INTO `users` VALUES ('10051', '皇室威妮', 'huangshiweini@aishang.com', '123456', '/users/10003/d4d6e376-344b-4cfa-adad-5400f6228985.jpg', '123456', '4');
INSERT INTO `users` VALUES ('10054', '测试代理商1', 'dailishang1@aishang.com', '123456', 'null', 'null', '2');
INSERT INTO `users` VALUES ('10055', '测试代理商2', 'dailishang2@aishang.com', '123456', 'null', 'null', '2');
INSERT INTO `users` VALUES ('10056', '测试代理商1美发店1', 'd1m1@aishang.com', '123456', 'resources/images/user_default.png', 'null', '3');
INSERT INTO `users` VALUES ('10061', '123', '123@aishang.com', '123456', '/users/10056/02fa5ff9-63de-43ed-b27a-bc5cbe1076c1.jpg', '123', '4');
INSERT INTO `users` VALUES ('10062', '代理商2测试美发店2', 'd2m2@aishang.com', '123456', 'null', 'null', '3');
INSERT INTO `users` VALUES ('10063', '测试发型师2', 'd2m2f2@aishang.com', '123456', 'null', '123', '4');
INSERT INTO `users` VALUES ('10064', '测试发型师2', 'd2m2fa1@aishang.com', '123456', 'null', '123', '4');
INSERT INTO `users` VALUES ('10065', '美发店专用测试号', '1234@aishang.com', '123456', 'null', 'null', '3');
INSERT INTO `users` VALUES ('10066', '0000', '0000@aishang.com', '123456', '/users/10065/0c79418f-cf96-4aed-8f5e-87ed956f0441.jpg', '123456', '4');
INSERT INTO `users` VALUES ('10067', '0001', '0001@aishang.com', '123456', '/users/10065/a411772b-dc24-4afd-a324-8451230dfce2.jpg', '123456', '4');
INSERT INTO `users` VALUES ('10068', '0002', '0002@aishang.com', '123456', '/users/10065/a34c417a-7a9f-485a-b50e-8434939c4972.jpg', '123456', '4');
INSERT INTO `users` VALUES ('10069', '0003', '0003@aishang.com', '123456', '/users/10065/47a05eb0-837b-476e-a8da-3acb9adf474b.jpg', '123456', '4');
INSERT INTO `users` VALUES ('10070', '0004', '0004@aishang.com', '123456', '/users/10065/fb383b60-f65b-4c8c-ab3e-e5ce1aa184dc.jpg', '123456', '4');
INSERT INTO `users` VALUES ('10071', '0005', '0005@aishang.com', '123456', '/users/10065/0f2561af-3071-433e-a652-caefba3b3da7.jpg', '123456', '4');
