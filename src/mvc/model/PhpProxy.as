package mvc.model 
{
	import app.ConstInfo;
	import com.core.AppManager;
	import com.core.handlers.Handler;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import mvc.model.vo.PhpProxyName;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class PhpProxy extends Proxy implements IProxy 
	{
		//加载php数据		
		public function PhpProxy(proxyName:String=null, data:Object=null) 
		{
			super(proxyName, data);
			
			trace("PhpProxy");
			switch(proxyName) {
				case PhpProxyName.serverlist:
					var url:String = ConstInfo.serverAddress + ConstInfo.php_serverlist;
					AppManager.phpLoader.phpCall("GET", url, null, 
												new Handler(completeHandler, [PhpProxyName.serverlist]),
												new Handler(errorHandler, [PhpProxyName.serverlist]));
					break;
			}
			
		}
		
		/********************************************************
		 * 自定义接口
		 * ******************************************************
		 */
		private function completeHandler(...param):void {
			trace("completeHandler:", param);
			var name:String = param[0];
			switch(name) {
				case PhpProxyName.serverlist:
					
					break;
			}
		}
		
		private function errorHandler(...param):void {
			trace("errorHandler:", param);
			var name:String = param[0];
			switch(name) {
				case PhpProxyName.serverlist:
					
					break;
			}
		}
		
		
		
		
		
		
	}

}