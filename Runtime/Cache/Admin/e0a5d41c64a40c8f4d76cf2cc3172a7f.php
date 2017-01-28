<?php if (!defined('THINK_PATH')) exit();?>    
             
            <table class="table_a" border="1" width="100%">
                <tbody><tr style="font-weight: bold;">
                        <td>序号</td><td>商品名称</td>
                        <td>价格</td><td>重量</td><td>大图</td><td>小图</td><td>创建时间</td>
                        <td align="center" colspan='2'>操作</td>
                    </tr>
                    <?php if(is_array($info)): foreach($info as $key=>$v): ?><tr id="product_<?php echo ($v["goods_id"]); ?>">
                        <td><?php echo ($v["goods_id"]); ?></td>
                        <td><a href="#"><?php echo ($v["goods_name"]); ?></a></td>
                        <td><?php echo ($v["goods_price"]); ?></td>
                        <td><?php echo ($v["goods_weight"]); ?></td>
                        <td><img src='<?php echo (C("SITE_URL")); echo (substr($v["goods_big_logo"],2)); ?>' alt='暂无图片' width='100' height='100'/></td>
                        <td><img src='<?php echo (C("SITE_URL")); echo (substr($v["goods_small_logo"],2)); ?>' alt='暂无图片' width='60' height='60'/></td>
                        <td><?php echo (date("Y-m-d H:i:s",$v["add_time"])); ?></td>
                        <!--<td><a href="/index.php/Admin/Goods/upd/goods_id/<?php echo ($v["goods_id"]); ?>" >修改</a></td>-->
                        <td><a href="<?php echo U('update',array('goods_id'=>$v['goods_id']));?>" >修改</a></td>
                        <td><a href="javascript:;" onclick="if(confirm('确认要删除该商品么？')){del_goods(<?php echo ($v["goods_id"]); ?>)}">删除</a></td>
                    </tr><?php endforeach; endif; ?>
                    
                    <tr>
                        <td colspan="20" style="text-align: center;">
                            <?php echo ($pagelist); ?>
                        </td>
                    </tr>
                </tbody>
            </table>