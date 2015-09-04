package xu.love.qq.mvc 
{
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	import xu.love.qq.mvc.controller.*;
	import xu.love.qq.mvc.controller.mp3.*;
	import xu.love.qq.mvc.controller.startup.*;
	import xu.love.qq.mvc.model.*;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class MFacade extends Facade
	{
		
		public function MFacade(key:String) 
		{
			super(key);
		}
		
		
		override protected function initializeController():void 
		{
			super.initializeController();
			//换肤命令
			this.registerCommand(AppConst.SYS_RESETSKIN,	ReskinCommand);
			this.registerCommand(AppConst.SYS_STARTUP, 		StartupCommand);
			//播放器命令
			this.registerCommand(AppConst.SYS_PLAY,			PlayCommand);
			this.registerCommand(AppConst.SYS_PREV,			PrevCommand);
			this.registerCommand(AppConst.SYS_NEXT,			NextCommand);
		}
		
		
		override protected function initializeModel():void 
		{
			super.initializeModel();
			this.registerProxy(new MP3ListProxy);
			this.registerProxy(new ConfigProxy);
			this.registerProxy(new MP3PlayCoreProxy);
			this.registerProxy(new SkinLoaderProxy);
			this.registerProxy(new ComponentsModelProxy);
		}
		
		
		public function startup(app:Main):void {
			this.sendNotification(AppConst.SYS_STARTUP, { app:app, config:"config.xml", playlist:"list.xml"});
			/*this.sendNotification(AppConst.SYS_STARTUP, { app:app, 
				config:"http://www.you-gogo.com/jsp/game/qqm/config.xml",
				playlist:"http://www.you-gogo.com/jsp/game/qqm/list.xml"});*/
		}
		
		
	}

}