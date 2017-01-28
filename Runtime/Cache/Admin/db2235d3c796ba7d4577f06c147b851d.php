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

<div style="font-size: 13px;margin: 10px 5px">
    <style type="text/css">
    .yang{width:200px;float:left;}
    </style>
    <form action="/index.php/Admin/Role/distribute/role_id/51.html" method="post" enctype="multipart/form-data">
        <input type='hidden' name='role_id' value="<?php echo ($roleinfo["role_id"]); ?>" />
        <table border="1" width="100%" class="table_a" id="general-tab-tb">
            <tr>
                <td style='font-size:30px;' colspan='100'>当前分配权限的角色：<?php echo ($roleinfo["role_name"]); ?></td>
            </tr>
            <?php if(is_array($auth_infoA)): foreach($auth_infoA as $key=>$v): ?><tr>
                <td><input type='checkbox' name='role_auth_ids[]' value='<?php echo ($v["auth_id"]); ?>'
                    <?php if(in_array(($v['auth_id']), is_array($roleinfo['role_auth_ids'])?$roleinfo['role_auth_ids']:explode(',',$roleinfo['role_auth_ids']))): ?>checked='checked'<?php endif; ?>
                ><?php echo ($v["auth_name"]); ?></td>
                <td>
                    <?php if(is_array($auth_infoB)): foreach($auth_infoB as $key=>$vv): if($vv['auth_pid'] == $v['auth_id']): ?><div class='yang'><input type='checkbox' name='role_auth_ids[]' value='<?php echo ($vv["auth_id"]); ?>'
                        <?php if(in_array(($vv['auth_id']), is_array($roleinfo['role_auth_ids'])?$roleinfo['role_auth_ids']:explode(',',$roleinfo['role_auth_ids']))): ?>checked='checked'<?php endif; ?>
                    ><?php echo ($vv["auth_name"]); ?></div><?php endif; endforeach; endif; ?>
                </td>
            </tr><?php endforeach; endif; ?>
            <tr>
                <td colspan='100'><input type="submit" name='now_act' value="分配权限" /></td>
            </tr>
        </table>
    </form>
</div>


    </body>
</html>