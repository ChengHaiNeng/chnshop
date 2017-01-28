<?php
return array(
	//'配置项'=>'配置值'
	//给项目做静态文件访问路由路径的配置
	//前台
	"CSS_URL"=>"/Home/Public/style/",
	'JS_URL'=>"/Home/Public/js/",
	"IMG_URL"=>"/Home/Public/images/",
	//后台
	"ADMIN_CSS_URL"=>'/ADMIN/Public/css/',
	'ADMIN_JS_URL'=>"/ADMIN/Public/js/",
	"ADMIN_IMG_URL"=>"/ADMIN/Public/img/",

	'DB_TYPE'               =>  'mysql',     // 数据库类型
    'DB_HOST'               =>  'localhost', // 服务器地址
    'DB_NAME'               =>  'chnshop',          // 数据库名
    'DB_USER'               =>  'root',      // 用户名
    'DB_PWD'                =>  'primary',          // 密码
    'DB_PORT'               =>  '',        // 端口
    'DB_PREFIX'             =>  'chnshop_',    // 数据库表前缀
    'DB_PARAMS'          	=>  array(), // 数据库连接参数    
    'DB_DEBUG'  			=>  TRUE, // 数据库调试模式 开启后可以记录SQL日志
    'DB_FIELDS_CACHE'       =>  true,        // 启用字段缓存
    'DB_CHARSET'            =>  'utf8',      // 数据库编码默认采用utf8

    //配置路径，方便第三方功能包的使用
    "PLUGIN_URL"=>"/Plugin/",

    //配置路径，shop/Common
    'COMMON_URL'=>'/Common/',

    //定义网站的域名路径(可以方便图片的显示)
    'SITE_URL'=>'http://chnshop.com/',

    //打开页面的跟踪新
    'SHOW_PAGE_TRACE'=>true,
    
);