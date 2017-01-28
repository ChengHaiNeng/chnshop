<?php
namespace Admin\Controller;
use Think\Controller;
use \Common\Tools\BackController;
class RoleController extends BackController {
	//列表展示全部角色的信息
	public function showlist(){
		//获得全部角色的信息
		//
		$info = D('Role')->select();
		$bread = array(
            'first'=>'角色管理',
            'second'=>'角色列表',
            'linkTo'=>array(
                    '【添加角色】',U('Role/tianjia')
                ),
            );
		$this->assign('bread',$bread);
		$this->assign('info',$info);
		$this->display();
	}

	//给角色分配权限
	public function distribute(){
		//两个逻辑:展示、收集
		$role = new \Model\RoleModel();
		if(IS_POST){
			//通过“瞻前顾后”机制实现数据制作role_auth_ids/role_auth_ac(权限分配)
			$data = $role->create();
			if($role->save($data)){
				$this->success("分配权限成功",U('showlist'),2);
			}else{
				$this->error("分配权限失败",U('distribute',array('role_id'=>I('get.role_id'))),2);
			}

		}else{
			$role_id = I('get.role_id');
			//获得”被分配权限“的角色信息
			$roleinfo = $role->find($role_id);
			$this->assign('roleinfo',$roleinfo);

			/***获得被分配的权限***/
			$auth_infoA = D('Auth')->where("auth_level=0")->select();//顶级权限
			$auth_infoB = D('Auth')->where("auth_level=1")->select();//二级权限
			$this->assign('auth_infoA',$auth_infoA);
			$this->assign('auth_infoB',$auth_infoB);

			//设置面包屑
			$bread = array(
            'first'=>'角色管理',
            'second'=>'分配权限',
            'linkTo'=>array(
                    '【返回】',U('showlist')
                ),
            );
            $this->assign('bread',$bread);
            $this->display();

		}
	}

}	