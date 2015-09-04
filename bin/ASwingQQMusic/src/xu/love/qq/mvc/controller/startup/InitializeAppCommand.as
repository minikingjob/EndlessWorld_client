package xu.love.qq.mvc.controller.startup
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.AsyncCommand;
	
	import xu.love.qq.mvc.AppConst;
	import xu.love.qq.mvc.model.ConfigProxy;
	import xu.love.qq.mvc.view.AppMediator;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class InitializeAppCommand extends AsyncCommand
	{
		
		public function InitializeAppCommand() 
		{
			
		}
		
		
		override public function execute(notification:INotification):void 
		{
			var app:Main = notification.getBody().app as Main;
			facade.registerMediator(new AppMediator(app));
			
			//app ready
			this.sendNotification(AppConst.SYS_APP_READY);
			//换上黙认皮肤
			var configProxy:ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
			this.sendNotification(AppConst.SYS_RESETSKIN, configProxy.getDefaultSkinID());
		}
		
	}

}