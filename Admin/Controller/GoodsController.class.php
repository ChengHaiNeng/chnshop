<?php
namespace Admin\Controller;
use Think\Controller;
use \Common\Tools\BackController;
class GoodsController extends BackController {
	//展示商品
    public function show(){
        $bread = array(
            'first'=>'商品管理',
            'second'=>'商品列表',
            'linkTo'=>array(
                    '【添加商品】',U('Goods/add')
                ),
            );
        $this->assign('bread',$bread);
        $this->display();
    }

    //showpage,分页代码,当Ajax异步请求时候访问此方法，根据GET参数返回showpage，相应的页面
    public function showpage(){
    	//获取page页码数
    	$p = isset($_GET['page'])?$_GET['page']:1;
    	//实例化商品对象
    	$goods = new \Model\GoodsModel();
    	$cnt = $goods->count();//获取商品总数
    	$per = 7;//每页显示7条
    	//实例化Page分页对象
    	$page_obj = new \Common\Tools\Page($cnt,$per);
    	//分页获取表中商品
    	$info = $goods->where(array('is_del'=>'不删除'))->order('goods_id desc')->limit(($p-1)*$per,$per)->select();
    	//获取页码列表
    	$pagelist = $page_obj -> fpage(array(3,4,5,6,7,8));//没有array则显示更多信息
    	$this->assign('info',$info);//传入分页商品信息
    	$this->assign('pagelist',$pagelist);//传入分页bar
    	$this->display();
    }

    public function add(){
    	$goods = new \Model\GoodsModel();//實例化GoodsModel對象
    	//兩個邏輯：展示、收集
    	if(IS_POST){
    		//提交表單

    		$data = $goods->create();
    		//htmlpurifier
    		$data['goods_introduce'] = \fanXSS($_POST['goods_introduce']);
    		if($goods->add($data)){
    			$this->success("添加商品成功",U("show"),2);
    		}else{
    			$this->error("添加商品失敗",U("add"),2);
    		}
    	}else{


             /****获得"商品类型"信息****/
            $typeinfo = D('Type')->select();
            $this -> assign('typeinfo',$typeinfo);
            /****获得"商品类型"信息****/
            $catinfo = D('Category')->order('cat_path')->select();
            $this->assign('catinfo',$catinfo);

    		//展示表單
            $bread = array(
            'first'=>'商品管理',
            'second'=>'商品添加',
            'linkTo'=>array(
                    '【返回商品列表】',U('Goods/show')
                ),
            );
            $this->assign('bread',$bread);
    		$this->display();
    	} 
    }

    public function update(){
        //两个逻辑：展示、收集
        $goods = new \Model\GoodsModel();
        if(IS_POST){
            $data = $goods -> create();
            //GoodsModel中的$_auto自动赋值 给upd_time字段赋值，即使没有更新，也会更新upd_time字段，不至于返回错误
            //
            //
            



            if($goods -> save($data)){
                $this -> success('修改商品成功', U('show'), 2);
            }
            else
                $this -> error('修改商品失败', U('update',array('goods_id'=>$data['goods_id'])), 2);
        }else{
            $goods_id = I('get.goods_id'); //接收被修改商品的goods_id
            $info = $goods->find($goods_id);//查询被修改商品的信息
                
            /****获得"商品类型"信息****/
            $typeinfo = D('Type')->select();
            $this -> assign('typeinfo',$typeinfo);
            /****获得"商品类型"信息****/

            /****获取主分类并传递显示****/
            $catinfo = D('Category')->order('cat_path')->select();
            $this -> assign('catinfo',$catinfo);
            /****获取主分类并传递显示****/

             /********获得商品的扩展分类信息(php41_goods_cat)********/
            $catextinfo = D('GoodsCat')->where(array('goods_id'=>$goods_id))->select();
            $this -> assign('catextinfo',$catextinfo);
            /********获得商品的扩展分类信息(php41_goods_cat)********/

            /*************获得相册信息*************/
            $picsinfo = D('GoodsPics')->where(array('goods_id'=>$goods_id))->select();
            if(!empty($picsinfo))
                $this -> assign('picsinfo',$picsinfo);
            /*************获得相册信息*************/


            $this -> assign('info',$info);
            $this -> display();
        }
    }

    //ajax删除相册里的单张图片
     function delPics(){
        $pics_id = I('get.pics_id');
        //查询图片并
        $info = D('GoodsPics')->find($pics_id);
        //①删除相册图片[物理删除]
        unlink($info['pics_big']);
        unlink($info['pics_small']);

        //②删除数据记录信息
        $z = D('GoodsPics')->delete($pics_id); //返回删除记录条数,1条
        if($z){
            echo "删除成功！";
        }
    }

    //ajax删除条目
    function delGoods(){
        $goods_id = I('get.goods_id');  //获得被删除商品的id信息
        $goods = D('Goods');
        $z = $goods -> setField(array('goods_id'=>$goods_id,'is_del'=>'删除'));
        //setField()内部有调用save()方法，
        if($z){
            echo json_encode(array('status'=>1)); //ok  99%
        }else{
            echo json_encode(array('status'=>2)); //fail 1% 
        }
    }


    //根据type_id获得对应的属性信息
    function getAttributeByType(){
        $type_id = I('get.type_id');
        $attrinfo = D('Attribute')->where(array('type_id'=>$type_id))->select();
        echo json_encode($attrinfo);
    } 


    //Ajax修改商品，根据"type_id/goods_id"获得类型对应的属性信息
    function getAttributeByTypeUpd(){
        $type_id = I('get.type_id');
        $goods_id = I('get.goods_id');
        //判断当前选取的type_id和本身商品的是否一致
        $goodsinfo = D('Goods')->find($goods_id);
        if($type_id!== $goodsinfo['type_id']){
            
            $attrinfo = D('Attribute')->where(array('type_id'=>$type_id))->select();
            $info['mark'] = 1; ////其他类型对应的属性信息
            $info[1] = $attrinfo;
            //$info是三维数组
            echo json_encode($info);
        }else{
            //数据表：goods_attr  attribute
            $attrinfo = D('GoodsAttr')
            ->alias('g')
            ->join('__ATTRIBUTE__ a on g.attr_id=a.attr_id')
            ->where(array('goods_id'=>$goods_id))
            ->field('g.attr_id,g.attr_value,a.attr_name,a.attr_is_sel,a.attr_sel_opt')
            ->select();
            //dump($attrinfo);//普通的二维数组信息

            $tmp = array();
            foreach($attrinfo as $k => $v){
                if(!empty($tmp[$v['attr_id']]) || $v['attr_is_sel']==1){
                    //多选属性整合
                    $tmp[$v['attr_id']]['attr_id'] = $v['attr_id'];
                    $tmp[$v['attr_id']]['attr_name'] = $v['attr_name'];
                    $tmp[$v['attr_id']]['attr_is_sel'] = $v['attr_is_sel'];
                    $tmp[$v['attr_id']]['attr_sel_opt'] = $v['attr_sel_opt'];
                    $tmp[$v['attr_id']]['attr_value'][] = $v['attr_value'];
                }else{
                    //单选属性整合
                    $tmp[$v['attr_id']] = $v; 
                }
            }
            //dump($tmp);//整合后的三维数组信息
            $info['mark'] = 2; //商品本身拥有的的属性信息
            $info[1] = $tmp;
            //$info变为一个四维数组
            echo json_encode($info);
        }
    }
}  