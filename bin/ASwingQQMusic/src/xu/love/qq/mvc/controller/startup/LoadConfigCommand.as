package xu.love.qq.mvc.controller.startup
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.AsyncCommand;
	import xu.love.qq.mvc.model.ConfigProxy;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class LoadConfigCommand extends AsyncCommand
	{
		private var _loader:URLLoader;
		//private var _loading:TLoading = new TLoading;
		public function LoadConfigCommand() 
		{
			_loader = new URLLoader;
			_loader.addEventListener(Event.COMPLETE, _onLoadComplete);
		}
		
		
		private function _onLoadComplete(e:Event):void 
		{
			//_loading.hide();
			var configProxy:ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
			configProxy.xml = new XML(_loader.data);
			this.commandComplete();
		}
		
		
		
		override public function execute(notification:INotification):void 
		{
			/*_loading.setText("正在加载配置文件...");
			_loading.show();
			_loading.centerScreen();*/
			
			_loader.load(new URLRequest(notification.getBody().config));
		}
		
	}

}