package com.core 
{
	import com.core.managers.LogManager;
	import com.core.managers.TimerManager;
	import com.core.managers.LoaderManager;
	import com.core.managers.PhpLoaderManager;
	import flash.display.Stage;
	/**
	 * ...
	 * @author minichen
	 */
	public class AppManager 
	{
		public static var loader:LoaderManager = new LoaderManager();	
		public static var phpLoader:PhpLoaderManager = new PhpLoaderManager();
		public static var timer:TimerManager = new TimerManager();
		public static var log:LogManager = new LogManager();
		
		public static var stage:Stage;
		
		public function AppManager() 
		{
			
		}
		
		public static function getResPath(url:String):String {
			return url;
		}
		
	}

}