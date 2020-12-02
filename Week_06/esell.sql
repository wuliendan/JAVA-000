/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3306
 Source Schema         : esell

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 25/11/2020 23:21:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE if not exists `esell`; 
USE `esell`;

# 订单详情表，一个订单对应一个店铺，一个店铺对应多个商品
-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `Id` tinyint(50) NOT NULL,
  `OrderId` tinyint(50) NOT NULL COMMENT '订单用户信息',
  `SellerId` tinyint(50) NOT NULL COMMENT '店铺信息（一个订单对应一个店铺，一个店铺对应多个商品）',
  `OrderStatus` tinyint(3) NOT NULL DEFAULT 0 COMMENT '订单状态，默认为0：新下单，1：已支付...',
  `CreateTime` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `UpdateTime` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_detail
-- ----------------------------

# 订单买家信息表，包含买家具体信息，买家地址，订单的总额，支付状态
-- ----------------------------
-- Table structure for order_info
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info`  (
  `Id` tinyint(50) NOT NULL DEFAULT 0,
  `OrderCode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单编号',
  `UserId` tinyint(50) NOT NULL COMMENT '买家信息',
  `UserAddressId` tinyint(255) NOT NULL COMMENT '买家地址',
  `OrderAmount` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单总额',
  `PayStatus` tinyint(3) NOT NULL DEFAULT 0 COMMENT '支付状态，默认为0：未支付',
  `CreateTime` datetime(0) NOT NULL COMMENT '创建时间',
  `UpdateTime` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_info
-- ----------------------------

# 订单商品关系表，一个订单对应一个店铺，一个店铺对应多个商品，商品的名称、当前价格以及购买数量
-- ----------------------------
-- Table structure for order_product_rel
-- ----------------------------
DROP TABLE IF EXISTS `order_product_rel`;
CREATE TABLE `order_product_rel`  (
  `Id` tinyint(50) NOT NULL,
  `OrderId` tinyint(50) NOT NULL COMMENT '订单信息',
  `SellerId` tinyint(50) NOT NULL COMMENT '店铺信息',
  `ProductId` tinyint(50) NOT NULL COMMENT '商品信息',
  `ProductName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称',
  `ProductCurPrice` decimal(10, 2) NOT NULL COMMENT '商品当前价格',
  `Quantity` tinyint(3) NOT NULL DEFAULT 1 COMMENT '购买数量，默认为1',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_product_rel
-- ----------------------------

# 商品厂商表，商品厂商，厂商地址，厂商编号
-- ----------------------------
-- Table structure for product_company
-- ----------------------------
DROP TABLE IF EXISTS `product_company`;
CREATE TABLE `product_company`  (
  `Id` tinyint(50) NOT NULL AUTO_INCREMENT,
  `CompanyName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品厂商',
  `CompanyAddress` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '厂商地址',
  `CompanyCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '厂商编号',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_company
-- ----------------------------

# 订单信息表，商品名称、商品厂商、商品描述、所属店铺
# 每个厂家多个商品
# 一个商品只属于一个店铺
-- ----------------------------
-- Table structure for product_info
-- ----------------------------
DROP TABLE IF EXISTS `product_info`;
CREATE TABLE `product_info`  (
  `Id` tinyint(50) NOT NULL AUTO_INCREMENT,
  `ProductName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称',
  `CompanyId` tinyint(50) NOT NULL COMMENT '商品厂商',
  `Description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品描述',
  `SellerId` tinyint(50) NOT NULL COMMENT '所属店铺',
  `CreateTime` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `UpdateTime` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_info
-- ----------------------------

# 商品型号表，型号，规格，价格，库存，缩略图，商品状态
# 每个商品有多个型号
-- ----------------------------
-- Table structure for product_model
-- ----------------------------
DROP TABLE IF EXISTS `product_model`;
CREATE TABLE `product_model`  (
  `Id` tinyint(50) NOT NULL,
  `ModelName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '型号',
  `ModelSpec` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规格',
  `Price` decimal(10, 2) NOT NULL COMMENT '商品价格',
  `Stock` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品库存',
  `Icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品缩略图',
  `Status` tinyint(3) NOT NULL COMMENT '商品状态：0-正常、1-下架',
  `ProductId` tinyint(50) NOT NULL COMMENT '商品信息',
  `CreateTime` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `UpdateTime` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_model
-- ----------------------------

# 店铺信息表，店铺名称、店铺账号、店铺密码、店铺描述、店铺地址
-- ----------------------------
-- Table structure for seller_info
-- ----------------------------
DROP TABLE IF EXISTS `seller_info`;
CREATE TABLE `seller_info`  (
  `Id` tinyint(50) NOT NULL,
  `UserName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '店铺名称',
  `LoginName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '店铺账号',
  `Password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '店铺密码',
  `Description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '店铺描述',
  `Address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '店铺地址',
  `CreateTime` datetime(0) NOT NULL COMMENT '创建时间',
  `UpdateTime` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seller_info
-- ----------------------------

# 用户信息表，用户登陆名，用户密码，用户电话，用户性别，用户出生日期
-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `Id` bigint(50) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户登录名',
  `Password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户登陆密码',
  `Telephone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户电话',
  `Gender` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户性别',
  `IdNo` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户身份证号',
  `Birthday` datetime(0) NULL DEFAULT NULL COMMENT '用户出生日期',
  `CreateTime` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `UpdateTime` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000001 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------

# 用户地址表，用户地址
# 每个用户可以填写多个地址
-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address`  (
  `Id` tinyint(50) NOT NULL AUTO_INCREMENT,
  `Address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户地址',
  `UserId` tinyint(50) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_address
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
