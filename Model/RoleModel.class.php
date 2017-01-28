<?php
namespace Model;
use Think\Model;

class RoleModel extends Model{

	//更新数据前的回调方法
	protected function _before_update(&$data,$options){
		if($_POST['now_act']=="分配权限"){
			//维护两个数据role_auth_ids/role_auth_ac
			//①制作role_auth_ids
			$data['role_auth_ids']=implode(',',$data['role_auth_ids']);
			//②制作role_auth_ac
			$authinfo = D('Auth')->where("auth_id in ({$data['role_auth_ids']})")->select();
			//从$authinfo中获得auth_c 和auth_a 拼装
			$s = "";
			foreach($authinfo as $k=>$v){
				if(!empty($v['auth_c']) && !empty($v['auth_a'])){
					$s .= $v['auth_c']."-".$v['auth_a'].",";
				}
			}
			$s = rtrim($s,',');
			$data['role_auth_ac'] = $s;
		}		
	}
}