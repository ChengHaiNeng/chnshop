<?php
namespace Admin\Controller;
use Think\Controller;
use \Common\Tools\BackController;
class AuthController extends BackController {
	//展示权限列表信息
	public function showlist(){
		//获得权限列表信息
		$info = D('Auth')->order('auth_path')->select();
		$bread = array(
            'first'=>'权限管理',
            'second'=>'权限列表',
            'linkTo'=>array(
                    '【添加权限】',U('tianjia')
                ),
            );
		$this->assign('bread',$bread);
		$this->assign('info',$info);
		$this->display();
	}

	function tianjia(){
		if(IS_POST){
			$auth = new \Model\AuthModel();
			$data = $auth->create();
			//通过after_insert方法实现path和level两个字段维护
			if($auth->add($data)){
				$this->success('添加权限成功',U('showlist'),2);
			}else{
				$this->error('添加权限失败',U('tianjia'),2);
			}

		}else{
			/********获得可供选取的上级权限(level=0/1)**********/
			$pinfo = D('Auth')->where(array('auth_level'=>array('in','0,1')))->order('auth_path')->select();
			$this->assign('pinfo',$pinfo);

			$bread = array(
	            'first'=>'权限管理',
	            'second'=>'权限添加',
	            'linkTo'=>array(
	                    '【返回】',U('showlist')
	                ),
	            );
			$this->assign('bread',$bread);
			$this->display();
		}		
	}

}