-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2017-02-04 09:02:19
-- 服务器版本： 10.1.9-MariaDB
-- PHP Version: 5.6.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chnshop`
--

-- --------------------------------------------------------

--
-- 表的结构 `chnshop_attribute`
--

CREATE TABLE `chnshop_attribute` (
  `attr_id` int(10) UNSIGNED NOT NULL COMMENT '主键id',
  `attr_name` varchar(32) NOT NULL COMMENT '属性名称',
  `type_id` smallint(5) UNSIGNED NOT NULL COMMENT '对应类型id',
  `attr_is_sel` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:唯一 1:多选',
  `attr_write_mod` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:手工  1:下拉列表选择',
  `attr_sel_opt` varchar(100) NOT NULL DEFAULT '' COMMENT '多选情况被选取的项目信息，多个值彼此使用,逗号分隔'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='商品属性表';

--
-- 转存表中的数据 `chnshop_attribute`
--

INSERT INTO `chnshop_attribute` (`attr_id`, `attr_name`, `type_id`, `attr_is_sel`, `attr_write_mod`, `attr_sel_opt`) VALUES
(1, '尺寸', 1, 1, 1, '14,15.6'),
(2, 'brand', 1, 1, 1, 'HP,Dell,Lenovo'),
(3, '颜色', 1, 0, 0, '红,蓝'),
(4, '产地', 1, 0, 0, '中国'),
(5, '品牌', 2, 1, 1, 'Apple,Sumsung,Huawei,Meizu'),
(6, '产地', 2, 0, 0, '');

-- --------------------------------------------------------

--
-- 表的结构 `chnshop_auth`
--

CREATE TABLE `chnshop_auth` (
  `auth_id` smallint(6) UNSIGNED NOT NULL,
  `auth_name` varchar(20) NOT NULL COMMENT '名称',
  `auth_pid` smallint(6) UNSIGNED NOT NULL COMMENT '父id',
  `auth_c` varchar(32) NOT NULL DEFAULT '' COMMENT '模块',
  `auth_a` varchar(32) NOT NULL DEFAULT '' COMMENT '操作方法',
  `auth_path` varchar(32) NOT NULL DEFAULT '' COMMENT '全路径',
  `auth_level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '基别'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `chnshop_auth`
--

INSERT INTO `chnshop_auth` (`auth_id`, `auth_name`, `auth_pid`, `auth_c`, `auth_a`, `auth_path`, `auth_level`) VALUES
(101, '商品管理', 0, '', '', '101', 0),
(102, '订单管理', 0, '', '', '102', 0),
(103, '权限管理', 0, '', '', '103', 0),
(104, '商品列表', 101, 'Goods', 'show', '101-104', 1),
(105, '添加商品', 101, 'Goods', 'add', '101-105', 1),
(106, '商品分类', 101, 'Category', 'showlist', '101-106', 1),
(107, '订单列表', 102, 'Order', 'showlist', '102-107', 1),
(108, '查询订单', 102, 'Order', 'look', '102-108', 1),
(109, '订单打印', 102, 'Order', 'dayin', '102-109', 1),
(110, '管理员列表', 103, 'Admin', 'showlist', '103-110', 1),
(111, '角色列表', 103, 'Role', 'showlist', '103-111', 1),
(112, '权限列表', 103, 'Auth', 'showlist', '103-112', 1),
(115, '会员管理', 0, '', '', '115', 0),
(116, '会员列表', 115, 'User', 'showlist', '115-116', 1),
(118, '商品列表Ajax', 101, 'Goods', 'showpage', '101-118', 1);

-- --------------------------------------------------------

--
-- 表的结构 `chnshop_category`
--

CREATE TABLE `chnshop_category` (
  `cat_id` smallint(5) UNSIGNED NOT NULL COMMENT '主键id',
  `cat_name` varchar(32) NOT NULL COMMENT '分类名称',
  `cat_pid` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上级id',
  `cat_path` varchar(32) NOT NULL DEFAULT '' COMMENT '全路径',
  `cat_level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '等级'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='商品分类表';

--
-- 转存表中的数据 `chnshop_category`
--

INSERT INTO `chnshop_category` (`cat_id`, `cat_name`, `cat_pid`, `cat_path`, `cat_level`) VALUES
(1, '电脑', 0, '1', 0),
(2, '手机', 0, '2', 0),
(3, '平板电脑', 1, '1-3', 1),
(4, '宽屏电脑', 1, '1-4', 1),
(5, '逼格手机', 2, '2-5', 1),
(6, '无边框手机', 2, '2-6', 1),
(7, '苹果', 3, '1-3-7', 2);

-- --------------------------------------------------------

--
-- 表的结构 `chnshop_goods`
--

CREATE TABLE `chnshop_goods` (
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '主键',
  `goods_name` varchar(256) NOT NULL COMMENT '商品名称',
  `goods_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价格',
  `goods_shop_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '本店价格',
  `goods_number` smallint(6) NOT NULL DEFAULT '1' COMMENT '商品数量',
  `goods_weight` smallint(6) NOT NULL DEFAULT '0' COMMENT '商品重量',
  `cat_id` mediumint(9) NOT NULL DEFAULT '0' COMMENT '商品分类',
  `brand_id` mediumint(9) NOT NULL DEFAULT '0' COMMENT '商品品牌',
  `type_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT '类型id',
  `goods_big_logo` char(100) NOT NULL DEFAULT '' COMMENT '商品大图片',
  `goods_small_logo` char(100) NOT NULL DEFAULT '' COMMENT '商品缩略图',
  `goods_introduce` text COMMENT '商品介绍',
  `is_sale` enum('上架','下架') NOT NULL DEFAULT '上架' COMMENT '上架，下架',
  `is_rec` enum('推荐','不推荐') NOT NULL DEFAULT '不推荐' COMMENT '推荐与否',
  `is_hot` enum('热销','不热销') NOT NULL DEFAULT '不热销' COMMENT '热销与否',
  `is_new` enum('新品','不新品') NOT NULL DEFAULT '不新品' COMMENT '新品与否',
  `add_time` int(11) NOT NULL COMMENT '添加信息时间',
  `upd_time` int(11) NOT NULL COMMENT '修改信息时间',
  `is_del` enum('删除','不删除') NOT NULL DEFAULT '不删除' COMMENT '删除与否'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `chnshop_goods`
--

INSERT INTO `chnshop_goods` (`goods_id`, `goods_name`, `goods_price`, `goods_shop_price`, `goods_number`, `goods_weight`, `cat_id`, `brand_id`, `type_id`, `goods_big_logo`, `goods_small_logo`, `goods_introduce`, `is_sale`, `is_rec`, `is_hot`, `is_new`, `add_time`, `upd_time`, `is_del`) VALUES
(1, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', '&lt;p&gt;&lt;span style=&quot;color: rgb(112, 48, 160); font-size: 20px;&quot;&gt;大蒜&lt;/span&gt;很贵啊&lt;br/&gt;&lt;/p&gt;', '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(2, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', '过年什么菜都这么贵啊&lt;script&gt;alert(1110)&lt;/script&gt;<br />', '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(3, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', '<p>韭菜的功效你<span style="font-size: 16px; color: rgb(227, 108, 9);">们懂得</span>&lt;script&gt;alert(123);&lt;/script&gt;<br/></p>', '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(4, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', '过年猪<span style="color:rgb(147,137,83);font-size:10px;">肉并不贵</span>&lt;script&gt;alert(111);&lt;/script&gt;', '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(18, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', '', '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(19, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', '', '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(20, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', '', '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(21, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', '', '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(22, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(23, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(24, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(25, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(26, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(27, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(28, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(29, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(37, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(38, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(39, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(40, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(41, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(42, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(43, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(44, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(45, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(46, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(47, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(48, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(49, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(50, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(51, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(52, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(68, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(69, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(70, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(71, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(72, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(73, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(74, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(75, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(76, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(77, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(78, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(79, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(80, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(81, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(82, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(83, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(84, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(85, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(86, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(87, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(88, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(89, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(90, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(91, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(92, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(93, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(94, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(95, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(96, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(97, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(98, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(99, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(131, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(132, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(133, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(134, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(135, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(136, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(137, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(138, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(139, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(140, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(141, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(142, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(143, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(144, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(145, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(146, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(147, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(148, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(149, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(150, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(151, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(152, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(153, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(154, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(155, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(156, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(157, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(158, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(159, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(160, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(161, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(162, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(163, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(164, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(165, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(166, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(167, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(168, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(169, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(170, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(171, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(172, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(173, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(174, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(175, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(176, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(177, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(178, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(179, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(180, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(181, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(182, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(183, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(184, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(185, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a01773e4a.jpg', './Common/Uploads/2017-01-23/small_5885a01773e4a.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(186, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/5885a04a7e0c0.jpg', './Common/Uploads/2017-01-23/small_5885a04a7e0c0.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(187, '大蒜', '10000.00', '0.00', 1, 2, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(188, '洋葱', '20.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '删除'),
(189, '韭菜', '10.00', '0.00', 1, 1, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '删除'),
(190, '猪肉', '10.00', '0.00', 1, 200, 0, 0, 0, '', '', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '删除'),
(191, '桌子', '1000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-22/5884c0b5aa620.png', './Common/Uploads/2017-01-22/small_5884c0b5aa620.png', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '不删除'),
(192, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-23/58859ffb8dea3.jpg', './Common/Uploads/2017-01-23/small_58859ffb8dea3.jpg', NULL, '上架', '不推荐', '不热销', '不新品', 0, 0, '删除'),
(193, '股票', '20000.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-24/5886bf49b183d.jpg', './Common/Uploads/2017-01-24/small_5886bf49b183d.jpg', '', '上架', '不推荐', '不热销', '不新品', 0, 0, '删除'),
(194, '股票12', '20001.00', '0.00', 1, 0, 0, 0, 0, './Common/Uploads/2017-01-24/5886bf7a8bd99.jpg', './Common/Uploads/2017-01-24/small_5886bf7a8bd99.jpg', '', '上架', '不推荐', '不热销', '不新品', 0, 1485228527, '删除'),
(195, '', '0.00', '0.00', 1, 0, 0, 0, 1, '', '', '', '上架', '不推荐', '不热销', '不新品', 1485588891, 1485588891, '删除'),
(196, '', '0.00', '0.00', 1, 0, 0, 0, 1, '', '', '', '上架', '不推荐', '不热销', '不新品', 1485588990, 1485588990, '删除'),
(197, 'Dell14 电脑', '11111.00', '0.00', 1, 0, 0, 0, 1, '', '', '', '上架', '不推荐', '不热销', '不新品', 1485593125, 1485605120, '删除'),
(198, '还能得电脑', '112122.00', '0.00', 1, 0, 1, 0, 1, './Common/Uploads/2017-01-28/588c88a0c47c4.jpg', './Common/Uploads/2017-01-28/small_588c88a0c47c4.jpg', '', '上架', '不推荐', '不热销', '不新品', 1485605024, 1485605024, '删除'),
(199, '等多个地方', '1233.00', '0.00', 1, 0, 1, 0, 1, '', '', '', '上架', '不推荐', '不热销', '不新品', 1485605181, 1485605181, '删除'),
(200, '用户', '123123.00', '0.00', 1, 0, 1, 0, 1, '', '', '', '上架', '不推荐', '不热销', '不新品', 1485605223, 1485605258, '删除'),
(201, '山丘之王', '123123.00', '0.00', 1, 0, 1, 0, 1, '', '', '', '上架', '不推荐', '不热销', '不新品', 1485605289, 1485605515, '删除'),
(202, '', '0.00', '0.00', 1, 0, 0, 0, 1, '', '', '', '上架', '不推荐', '不热销', '不新品', 1485605537, 1485605537, '删除'),
(203, '', '0.00', '0.00', 1, 0, 0, 0, 1, '', '', '', '上架', '不推荐', '不热销', '不新品', 1485606097, 1485606097, '删除'),
(204, '', '0.00', '0.00', 1, 0, 0, 0, 1, '', '', '', '上架', '不推荐', '不热销', '不新品', 1485607150, 1485607150, '删除'),
(205, '', '0.00', '0.00', 1, 0, 0, 0, 1, '', '', '', '上架', '不推荐', '不热销', '不新品', 1485607173, 1485607173, '删除'),
(206, '', '0.00', '0.00', 1, 0, 0, 0, 1, '', '', '', '上架', '不推荐', '不热销', '不新品', 1485607255, 1485607255, '删除'),
(207, '', '0.00', '0.00', 1, 0, 0, 0, 1, '', '', '', '上架', '不推荐', '不热销', '不新品', 1485607505, 1485607505, '删除'),
(208, '', '0.00', '0.00', 1, 0, 1, 0, 1, '', '', '', '上架', '不推荐', '不热销', '不新品', 1485607730, 1485608236, '不删除'),
(209, 'Iphone7', '7000.00', '0.00', 1, 868, 1, 0, 1, './Common/Uploads/2017-01-29/588dc38e00b73.png', './Common/Uploads/2017-01-29/small_588dc38e00b73.png', '爱的就开始打哈看似简单<br />', '上架', '不推荐', '不热销', '不新品', 1485685645, 1485685645, '不删除');

-- --------------------------------------------------------

--
-- 表的结构 `chnshop_goods_attr`
--

CREATE TABLE `chnshop_goods_attr` (
  `id` mediumint(8) UNSIGNED NOT NULL COMMENT '主键id',
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品id',
  `attr_id` mediumint(8) UNSIGNED NOT NULL COMMENT '属性id',
  `attr_value` varchar(64) NOT NULL DEFAULT '' COMMENT '属性对应的值'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='商品-属性关联表';

--
-- 转存表中的数据 `chnshop_goods_attr`
--

INSERT INTO `chnshop_goods_attr` (`id`, `goods_id`, `attr_id`, `attr_value`) VALUES
(1, 196, 1, '14'),
(2, 196, 1, '15.6'),
(3, 196, 2, 'Dell'),
(4, 196, 2, 'Lenovo'),
(5, 196, 3, '黑色'),
(6, 196, 4, '中国'),
(32, 199, 1, '14'),
(31, 197, 4, '中国'),
(30, 197, 3, '红色'),
(29, 197, 2, 'Dell'),
(28, 197, 2, 'HP'),
(27, 197, 1, '15.6'),
(17, 198, 1, '14'),
(18, 198, 1, '15.6'),
(19, 198, 2, 'HP'),
(20, 198, 3, 'red'),
(21, 198, 4, 'China'),
(22, 198, 1, '14'),
(23, 198, 1, '15.6'),
(24, 198, 2, 'HP'),
(25, 198, 3, 'red'),
(26, 198, 4, 'China'),
(33, 199, 2, 'HP'),
(34, 199, 3, ''),
(35, 199, 4, ''),
(36, 199, 1, '14'),
(37, 199, 2, 'HP'),
(38, 199, 3, ''),
(39, 199, 4, ''),
(73, 202, 1, '15.6'),
(72, 202, 1, '14'),
(71, 201, 4, ''),
(70, 201, 3, ''),
(57, 200, 4, ''),
(56, 200, 3, ''),
(55, 200, 2, 'HP'),
(54, 200, 1, '15.6'),
(69, 201, 2, 'Dell'),
(68, 201, 2, 'HP'),
(67, 201, 1, '15.6'),
(66, 201, 1, '14'),
(74, 202, 2, 'Dell'),
(75, 202, 2, 'HP'),
(76, 202, 3, ''),
(77, 202, 4, ''),
(78, 202, 1, '14'),
(79, 202, 1, '15.6'),
(80, 202, 2, 'Dell'),
(81, 202, 2, 'HP'),
(82, 202, 3, ''),
(83, 202, 4, ''),
(84, 203, 1, '14'),
(85, 203, 2, 'HP'),
(86, 203, 3, ''),
(87, 203, 4, ''),
(95, 204, 4, ''),
(94, 204, 3, ''),
(93, 204, 2, 'HP'),
(92, 204, 1, '14'),
(96, 205, 1, '14'),
(97, 205, 2, 'HP'),
(98, 205, 3, ''),
(99, 205, 4, ''),
(100, 206, 1, '14'),
(101, 206, 2, 'HP'),
(102, 206, 3, ''),
(103, 206, 4, ''),
(104, 206, 1, '14'),
(105, 206, 2, 'HP'),
(106, 206, 3, ''),
(107, 206, 4, ''),
(108, 207, 1, '14'),
(109, 207, 2, 'Dell'),
(110, 207, 3, '123'),
(111, 207, 4, '456'),
(131, 208, 4, ''),
(130, 208, 3, ''),
(129, 208, 2, 'Dell'),
(128, 208, 1, '14'),
(132, 209, 1, '14'),
(133, 209, 2, 'Dell'),
(134, 209, 3, 'blue'),
(135, 209, 4, '上海');

-- --------------------------------------------------------

--
-- 表的结构 `chnshop_goods_cat`
--

CREATE TABLE `chnshop_goods_cat` (
  `id` mediumint(8) UNSIGNED NOT NULL COMMENT '主键id',
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品id',
  `cat_id` mediumint(8) UNSIGNED NOT NULL COMMENT '分类id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='商品-分类，关联表';

--
-- 转存表中的数据 `chnshop_goods_cat`
--

INSERT INTO `chnshop_goods_cat` (`id`, `goods_id`, `cat_id`) VALUES
(1, 198, 3),
(2, 198, 7),
(3, 199, 3),
(4, 199, 7),
(16, 208, 7),
(15, 208, 3),
(17, 209, 7),
(18, 209, 3);

-- --------------------------------------------------------

--
-- 表的结构 `chnshop_goods_pics`
--

CREATE TABLE `chnshop_goods_pics` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '主键',
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品id',
  `pics_big` char(100) NOT NULL COMMENT '相册原图',
  `pics_small` char(100) NOT NULL COMMENT '相册缩略图'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='商品相册表';

--
-- 转存表中的数据 `chnshop_goods_pics`
--

INSERT INTO `chnshop_goods_pics` (`id`, `goods_id`, `pics_big`, `pics_small`) VALUES
(1, 18, './Common/Pics/2017-01-22/5884c0b5b8039.png', './Common/Pics/2017-01-22/small_5884c0b5b8039.png'),
(2, 18, './Common/Pics/2017-01-22/5884c0b5c8a13.jpg', './Common/Pics/2017-01-22/small_5884c0b5c8a13.jpg'),
(3, 194, './Common/Pics/2017-01-24/5886c06c8989c.png', './Common/Pics/2017-01-24/small_5886c06c8989c.png'),
(4, 194, './Common/Pics/2017-01-24/5886c06c8a7e7.jpg', './Common/Pics/2017-01-24/small_5886c06c8a7e7.jpg'),
(8, 194, './Common/Pics/2017-01-24/5886c764657f4.jpg', './Common/Pics/2017-01-24/small_5886c764657f4.jpg'),
(9, 198, './Common/Pics/2017-01-28/588c88a136286.jpg', './Common/Pics/2017-01-28/small_588c88a136286.jpg'),
(10, 198, './Common/Pics/2017-01-28/588c88a136b15.png', './Common/Pics/2017-01-28/small_588c88a136b15.png'),
(11, 198, './Common/Pics/2017-01-28/588c88a145056.jpg', './Common/Pics/2017-01-28/small_588c88a145056.jpg'),
(12, 209, './Common/Pics/2017-01-29/588dc38e4edbe.png', './Common/Pics/2017-01-29/small_588dc38e4edbe.png'),
(13, 209, './Common/Pics/2017-01-29/588dc38e51c4f.jpg', './Common/Pics/2017-01-29/small_588dc38e51c4f.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `chnshop_manager`
--

CREATE TABLE `chnshop_manager` (
  `mg_id` int(11) NOT NULL,
  `mg_name` varchar(32) NOT NULL,
  `mg_pwd` varchar(32) NOT NULL,
  `mg_time` int(10) UNSIGNED NOT NULL COMMENT '时间',
  `mg_role_id` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '角色id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `chnshop_manager`
--

INSERT INTO `chnshop_manager` (`mg_id`, `mg_name`, `mg_pwd`, `mg_time`, `mg_role_id`) VALUES
(1, 'tom', '123456', 1323212345, 50),
(2, 'xiaoming', '123456', 1312345324, 51),
(3, 'admin', '123456', 1323456543, 0);

-- --------------------------------------------------------

--
-- 表的结构 `chnshop_role`
--

CREATE TABLE `chnshop_role` (
  `role_id` smallint(6) UNSIGNED NOT NULL,
  `role_name` varchar(20) NOT NULL COMMENT '角色名称',
  `role_auth_ids` varchar(128) NOT NULL DEFAULT '' COMMENT '权限ids,1,2,5',
  `role_auth_ac` text COMMENT '模块-操作'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `chnshop_role`
--

INSERT INTO `chnshop_role` (`role_id`, `role_name`, `role_auth_ids`, `role_auth_ac`) VALUES
(50, '主管', '101,104,118', 'Goods-show,Goods-showpage'),
(51, '经理', '101,104,105,106,118,102,107,108', 'Goods-show,Goods-add,Category-showlist,Order-showlist,Order-look,Goods-showpage');

-- --------------------------------------------------------

--
-- 表的结构 `chnshop_type`
--

CREATE TABLE `chnshop_type` (
  `type_id` smallint(5) UNSIGNED NOT NULL COMMENT '主键id',
  `type_name` varchar(32) NOT NULL COMMENT '类型名称'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='商品类型表';

--
-- 转存表中的数据 `chnshop_type`
--

INSERT INTO `chnshop_type` (`type_id`, `type_name`) VALUES
(1, '电脑'),
(2, '手机'),
(3, '干果'),
(4, '蔬果');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chnshop_attribute`
--
ALTER TABLE `chnshop_attribute`
  ADD PRIMARY KEY (`attr_id`),
  ADD KEY `type_id` (`type_id`);

--
-- Indexes for table `chnshop_auth`
--
ALTER TABLE `chnshop_auth`
  ADD PRIMARY KEY (`auth_id`);

--
-- Indexes for table `chnshop_category`
--
ALTER TABLE `chnshop_category`
  ADD PRIMARY KEY (`cat_id`),
  ADD KEY `cat_pid` (`cat_pid`);

--
-- Indexes for table `chnshop_goods`
--
ALTER TABLE `chnshop_goods`
  ADD PRIMARY KEY (`goods_id`),
  ADD KEY `goods_shop_price` (`goods_shop_price`),
  ADD KEY `goods_price` (`goods_price`),
  ADD KEY `cat_id` (`cat_id`),
  ADD KEY `brand_id` (`brand_id`),
  ADD KEY `add_time` (`add_time`);

--
-- Indexes for table `chnshop_goods_attr`
--
ALTER TABLE `chnshop_goods_attr`
  ADD PRIMARY KEY (`id`),
  ADD KEY `goods_id` (`goods_id`),
  ADD KEY `attr_id` (`attr_id`);

--
-- Indexes for table `chnshop_goods_cat`
--
ALTER TABLE `chnshop_goods_cat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `goods_id` (`goods_id`),
  ADD KEY `cat_id` (`cat_id`);

--
-- Indexes for table `chnshop_goods_pics`
--
ALTER TABLE `chnshop_goods_pics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chnshop_manager`
--
ALTER TABLE `chnshop_manager`
  ADD PRIMARY KEY (`mg_id`);

--
-- Indexes for table `chnshop_role`
--
ALTER TABLE `chnshop_role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `chnshop_type`
--
ALTER TABLE `chnshop_type`
  ADD PRIMARY KEY (`type_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `chnshop_attribute`
--
ALTER TABLE `chnshop_attribute`
  MODIFY `attr_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id', AUTO_INCREMENT=7;
--
-- 使用表AUTO_INCREMENT `chnshop_auth`
--
ALTER TABLE `chnshop_auth`
  MODIFY `auth_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;
--
-- 使用表AUTO_INCREMENT `chnshop_category`
--
ALTER TABLE `chnshop_category`
  MODIFY `cat_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id', AUTO_INCREMENT=8;
--
-- 使用表AUTO_INCREMENT `chnshop_goods`
--
ALTER TABLE `chnshop_goods`
  MODIFY `goods_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=210;
--
-- 使用表AUTO_INCREMENT `chnshop_goods_attr`
--
ALTER TABLE `chnshop_goods_attr`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id', AUTO_INCREMENT=136;
--
-- 使用表AUTO_INCREMENT `chnshop_goods_cat`
--
ALTER TABLE `chnshop_goods_cat`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id', AUTO_INCREMENT=19;
--
-- 使用表AUTO_INCREMENT `chnshop_goods_pics`
--
ALTER TABLE `chnshop_goods_pics`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=14;
--
-- 使用表AUTO_INCREMENT `chnshop_manager`
--
ALTER TABLE `chnshop_manager`
  MODIFY `mg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `chnshop_role`
--
ALTER TABLE `chnshop_role`
  MODIFY `role_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;
--
-- 使用表AUTO_INCREMENT `chnshop_type`
--
ALTER TABLE `chnshop_type`
  MODIFY `type_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id', AUTO_INCREMENT=5;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
