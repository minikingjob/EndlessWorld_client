package com.core.managers 
{
	import mvc.MyApplicationFacade;
	/**
	 * ...
	 * @author minichen
	 */
	public class GameManager 
	{
		private static var _instance:GameManager;
		public static function get instance():GameManager {
			if (!_instance)_instance = new GameManager();
			return _instance
		}
		public function GameManager() {}
		
		public var facade:MyApplicationFacade = MyApplicationFacade.getInstance();
	}

}