package com.core 
{
	import com.core.managers.CookieManager;
	import com.core.managers.LogManager;
	import com.core.managers.TimerManager;
	import com.core.managers.LoaderManager;
	import com.core.managers.PhpLoaderManager;
	import flash.display.Stage;
	import mvc.MyApplicationFacade;
	/**
	 * ...
	 * @author minichen
	 */
	public class AppManager 
	{
		public static var facade:MyApplicationFacade = new MyApplicationFacade();
		
		public static var loader:LoaderManager = new LoaderManager();	
		public static var phpLoader:PhpLoaderManager = new PhpLoaderManager();
		public static var timer:TimerManager = new TimerManager();
		public static var log:LogManager = new LogManager();
		public static var cookie:CookieManager = new CookieManager();
		
		public static var stage:Stage;
		
		public function AppManager() 
		{
			
		}
		
		public static function getResPath(url:String):String {
			return url;
		}
		
	}

}