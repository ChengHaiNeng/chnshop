<?php
namespace Admin\Controller;
use Think\Controller;
use Common\Tools\BackController;
class IndexController extends BackController {

    public function  __construct(){
        parent::__construct();
        layout(false);
    }
    public function head(){
        $this->display();
    }

    public function left(){
        //通过“管理员”获得对应的“角色”，通过角色获得相应“权限”并显示
        $admin_id = session('admin_id');
        $admin_name = session('admin_name');
        if($admin_name !== 'admin'){//普通用户获得权限
            $auth_ids = D('Manager') -> alias('m')->join('__ROLE__ r on m.mg_role_id=r.role_id')->field('r.role_auth_ids')->where(array('m.mg_id'=>$admin_id))->find();
            $auth_ids = $auth_ids['role_auth_ids'];

            $auth_infoA = D('Auth')->where("auth_id in ($auth_ids) and auth_level = 0")->select();//顶级权限
            $auth_infoB = D('Auth')->where("auth_id in ($auth_ids) and auth_level = 1")->select();//次顶级权限
        }else{//admin用户获取权限[获取全部权限]
            $auth_infoA = D('Auth')->where('auth_level=0')->select();//顶级权限
            $auth_infoB = D('Auth')->where('auth_level=1')->select();//次顶级权限
        }
        $this->assign('auth_infoA',$auth_infoA);
        $this->assign('auth_infoB',$auth_infoB);
        $this->display();
    }

    public function right(){
        $this->display();
    }

    public function index(){
        $this->display();
    }
}