<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
    <head>
        <title>添加商品</title>
        <meta http-equiv="content-type" content="text/html;charset=utf-8">
            <link href="<?php echo (C("ADMIN_CSS_URL")); ?>mine.css" type="text/css" rel="stylesheet" />
            <script type="text/javascript" charset="utf-8" src="<?php echo (C("PLUGIN_URL")); ?>ueditor/ueditor.config.js"></script>
            <script type="text/javascript" src="<?php echo (C("COMMON_URL")); ?>Js/uploadPreview.js"></script>
            <script type='text/javascript'>
            UEDITOR_CONFIG.toolbars = [[
            'fullscreen', 'source', '|', 'undo', 'redo', '|',
            'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
            'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
            'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
            'directionalityltr', 'directionalityrtl', 'indent', '|',
            'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
            'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
            'simpleupload', 'insertimage', 'emotion', 'scrawl', 'insertvideo', 'music', 'attachment', 'map', 'gmap', 'insertframe', 'insertcode', 'webapp', 'pagebreak', 'template', 'background', '|',
            'horizontal', 'date', 'time', 'spechars', 'snapscreen', 'wordimage', '|',
            'inserttable', 'deletetable', 'insertparagraphbeforetable', '|',
            ]];    
            
            </script>
            
            <script type="text/javascript" charset="utf-8" src="<?php echo (C("PLUGIN_URL")); ?>ueditor/ueditor.all.min.js"></script>
            <script type="text/javascript" charset="utf-8" src="<?php echo (C("PLUGIN_URL")); ?>ueditor/lang/zh-cn/zh-cn.js"></script>

            <script type="text/javascript" src="<?php echo (C("COMMON_URL")); ?>Js/jquery-1.11.3.min.js"></script>
    </head>
    <body>
        <div class="div_head">
            <span>
                <span style="float:left">当前位置是：<?php echo ($bread["first"]); ?>-》<?php echo ($bread["second"]); ?></span>
                <span style="float:right;margin-right: 8px;font-weight: bold">
                    <a style="text-decoration: none" href="<?php echo ($bread["linkTo"]["1"]); ?>"><?php echo ($bread["linkTo"]["0"]); ?></a>
                </span>
            </span>
        </div>
        <div></div>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta content="MSHTML 6.00.6000.16674" name="GENERATOR" />

        <title>用户登录</title>

        <link href="<?php echo (C("ADMIN_CSS_URL")); ?>User_Login.css" type="text/css" rel="stylesheet" />
        <script type="text/javascript" src="<?php echo (C("COMMON_URL")); ?>Js/jquery-1.11.3.min.js"></script> 
    </head><body id="userlogin_body">
        <div></div>
        <div id="user_login">
            <dl>
                <dd id="user_top">
                    <ul>
                        <li class="user_top_l"></li>
                        <li class="user_top_c"></li>
                        <li class="user_top_r"></li></ul>
                </dd><dd id="user_main">

                    <form action="/index.php/Admin/Admin/login" method="post">
                        <ul>
                            <li class="user_main_l"></li>
                            <li class="user_main_c">
                                <div class="user_main_box">
                                    <ul>
                                        <li class="user_main_text">用户名： </li>
                                        <li class="user_main_input">
                                            <input class="TxtUserNameCssClass" id="admin_user" maxlength="20" name="admin_user"> </li></ul>
                                    <ul>
                                        <li class="user_main_text">密&nbsp;&nbsp;&nbsp;&nbsp;码： </li>
                                        <li class="user_main_input">
                                            <input class="TxtPasswordCssClass" id="admin_psd" name="admin_psd" type="password">
                                        </li>
                                    </ul>
                                    <ul>
                                        <li class="user_main_text">验证码： </li>
    <script type="text/javascript">
    var code_flag = false; //验证码是否通过验证
    function check_code(){
        //获得输入的验证码
        var code = $('#captcha').val();
        if(code.length==4){
            //触发ajax
            $.ajax({
                url:"<?php echo U('checkCode');?>",
                data:{'code':code},
                dataType:'json',
                type:'get',
                success:function(msg){
                    if(msg.status==1){
                        $('#code_check_result').html('<span style="color:green">验证码正确</span>');
                        code_flag = true;
                    }else{
                        $('#code_check_result').html('<span style="color:red">验证码错误</span>');
                        code_flag = false;
                    }
                }
            });
        }
    }


    </script>
    <li class="user_main_input">
        <input class="TxtValidateCodeCssClass" id="captcha" name="captcha" type="text" maxlength='4' onkeyup='check_code()'/>
        <img src="<?php echo U('verifyImg');?>"  alt="验证码" onclick="this.src='/index.php/Admin/Admin/verifyImg/'+Math.random()" />
        <!--this.src='<?php echo U('Home/Login/verifyImg');?>/' + Math.random()-->
    </li>
                                    </ul>
                                    <ul>
                                        <li class="user_main_input" id="code_check_result">
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="user_main_r">

                                <input style="border: medium none; background: url('<?php echo (C("ADMIN_IMG_URL")); ?>user_botton.gif') repeat-x scroll left top transparent; height: 122px; width: 111px; display: block; cursor: pointer;" value="" type="submit">
                            </li>
                        </ul>
                    </form>
                    <script type="text/javascript">
                        $(function(){
                             //给form表单设置提交事件
                            $('form').submit(function(evt){
                                //判断验证码是否正确，再进行提交(否则阻止form表单提交)
                                if(code_flag===false){
                                    evt.preventDefault(); //阻止form表单提交
                                }
                            });
                        });
                    </script>
                </dd><dd id="user_bottom">
                    <ul>
                        <li class="user_bottom_l"></li>
                        <li class="user_bottom_c"><span style="margin-top: 40px;"></span> </li>
                        <li class="user_bottom_r"></li></ul></dd></dl></div><span id="ValrUserName" style="display: none; color: red;"></span><span id="ValrPassword" style="display: none; color: red;"></span><span id="ValrValidateCode" style="display: none; color: red;"></span>
        <div id="ValidationSummary1" style="display: none; color: red;"></div>
    </body>
</html>

    </body>
</html>