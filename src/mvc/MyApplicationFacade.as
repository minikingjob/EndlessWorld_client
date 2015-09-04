package mvc 
{
	import mvc.cotroller.AppCommand;
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class MyApplicationFacade extends Facade implements IFacade 
	{
		public static const CMD_STARTUP:String            = "startup"; 
		
		public function MyApplicationFacade() 
		{
			super();
			
		}
		
		//得到ApplicationFacade单例的工厂方法 
		public static function getInstance():MyApplicationFacade { 
		  if (instance == null) 
			instance = new MyApplicationFacade(); 
		  return instance as MyApplicationFacade; 
		} 

		/*启动PureMVC，在应用程序中调用此方法，并传递应用程序本身的引用 
		有一个可选的“报体”，“报体”可以是任意ActionScript对象。*/ 
		public function startup(app:Object):void { 
		  sendNotification(CMD_STARTUP, app); 
		} 

		//注册Command，建立Command与Notification之间的映射 
		override protected function initializeController():void { 
		  super.initializeController(); 
		  registerCommand(CMD_STARTUP, AppCommand); 
		} 
		
	}

}