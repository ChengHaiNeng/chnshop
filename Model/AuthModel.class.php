<?php
namespace Model;
use Think\Model;

class AuthModel extends Model{


	protected function _after_insert($data,$options){
		//维护两个字段：auth_path/auth_level
		//维护auth_path
		if($data['auth_pid'] == 0){
			//①顶级权限
			$path = $data['auth_id'];
		}else{
			//②非顶级权限
			$pinfo = $this->field('auth_path')->find($data['auth_pid']);
			$ppath = $pinfo['auth_path'];
			$path = $ppath."-".$data['auth_id'];
		}
		//维护auth_level
		//等于全路径“-”横杠的个数
		$level = substr_count($path,"-");//计算$path内部“-”的个数
		$this->save(array('auth_id'=>$data['auth_id'],'auth_path'=>$path,'auth_level'=>$level));
	}
	
}
