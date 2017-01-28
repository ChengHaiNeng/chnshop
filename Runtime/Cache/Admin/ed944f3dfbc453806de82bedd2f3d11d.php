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

<div style="font-size: 13px; margin: 10px 5px;">
    <table class="table_a" border="1" width="100%">
        <tbody><tr style="font-weight: bold;">
                <td>序号</td><td>名称</td>
                <td>权限ids</td>
                <td align="center" colspan='3'>操作</td>
            </tr>
            <?php if(is_array($info)): foreach($info as $key=>$v): ?><tr >
                <td><?php echo ($v["role_id"]); ?></td>
                <td><a href="#"><?php echo ($v["role_name"]); ?></a></td>
                <td><?php echo ($v["role_auth_ids"]); ?></td>

                <td><a href="<?php echo U('distribute',array('role_id'=>$v['role_id']));?>" >分配权限</a></td>

                <td><a href="" >修改</a></td>
                <td><a href="javascript:;" >删除</a></td>
            </tr><?php endforeach; endif; ?>
        </tbody>
    </table>
</div>


    </body>
</html>