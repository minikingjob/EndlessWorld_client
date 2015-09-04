package xu.love.qq.mvc.controller.startup
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.AsyncCommand;
	
	import xu.love.qq.mvc.model.MP3ListProxy;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class LoadPlaylistCommand extends AsyncCommand
	{
		private var _loader:URLLoader;
		
		public function LoadPlaylistCommand() 
		{
			_loader = new URLLoader;
			_loader.addEventListener(Event.COMPLETE, _onLoadComplete);
		}
		
		private function _onLoadComplete(e:Event):void 
		{
			var xml:XML = new XML(_loader.data);
			var listProxy:MP3ListProxy = facade.retrieveProxy(MP3ListProxy.NAME) as MP3ListProxy;
			listProxy.setXML(xml);
			this.commandComplete();
		}
		
		override public function execute(notification:INotification):void 
		{
			_loader.load(new URLRequest(notification.getBody().playlist));
		}
		
	}

}