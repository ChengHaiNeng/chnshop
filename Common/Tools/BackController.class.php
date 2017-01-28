<?php
namespace Common\Tools;
use Think\Controller;
class BackController extends Controller {
	function __construct(){
		parent::__construct();
		$admin_id = session('admin_id');
		$admin_name = session('admin_name');
		//权限控制过滤功能实现
		$nowAC = CONTROLLER_NAME."-".ACTION_NAME;
		if(!empty($admin_name)){
			//系统有一些权限无需分配，直接可以访问
			$allowAC = "Admin-logout,Admin-login,Admin-verifyImg,Admin-checkCode,Index-index,Index-head,Index-left,Index-right";
			//获得当前管理员对应角色的"role_auth_ac"信息
			$roleinfo = D('Manager')->alias('m')->join('__ROLE__ r on m.mg_role_id=r.role_id')->field('r.role_auth_ac')->where(array('mg_id'=>$admin_id))->find();
			$role_ac = $roleinfo['role_auth_ac'];
			//判断当前访问的“权限”是否角色允许的“权限”
			//①访问的权限在角色权限列表没有出现
			//②访问的权限在默认允许的列表也没有出现
			//③当前用户还不是admin的超级管理员
			//以上①②③都满足，就是“没有访问权限”
			//strpos(s1,s2),判断s2在s1中首次出现位置(0,1,2,3),没有出现就返回false
			if(strpos($role_ac,$nowAC)===false && strpos($allowAC,$nowAC)===false && $admin_name!="admin"){
				dump($role_ac."<br>".$nowAC);
				exit;
			}
		}else{
			//退出系统状态
			//跳转到登录页去
			//退出状态也要有可以访问的权限定义
			$allowAC = "Admin-login,Admin-verifyImg,Admin-checkCode";
			if(strpos($allowAC,$nowAC)===false){
				//通过js，可以是所有的frameset都跳转
				$js = <<<eof
					<script type="text/javascript">
					window.top.location.href="/index.php/Admin/Admin/login";
					</script>
eof;
				echo $js;	
			}	
			
		}		
	}
}
