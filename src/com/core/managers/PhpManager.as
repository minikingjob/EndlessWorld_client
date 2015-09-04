package com.core.managers 
{
	import app.ConstInfo;
	import com.core.AppManager;
	import com.core.handlers.Handler;
	/**
	 * ...
	 * @author minichen
	 */
	public class PhpManager 
	{
		
		private static var _instance:PhpManager;
		public static function get instance():PhpManager {
			if (!_instance)_instance = new PhpManager();
			return _instance
		}
		public function PhpManager() {}
		
		public function getServerList():void {
			var url:String = ConstInfo.serverAddress + ConstInfo.php_serverlist;
			
			var completeHandler:Handler = new Handler(getServerListComplete, ["success",url]);
			var errorHandler:Handler = new Handler(getServerListComplete, ["failed", url]);
			AppManager.loader.loadTXT(url, completeHandler, null, errorHandler, false);
		}
		
		private function getServerListComplete(...param):void {
			trace("param.length:", param.length);
			trace("param", param);
		}
		
	}

}