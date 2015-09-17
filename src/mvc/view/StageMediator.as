package mvc.view 
{
	import com.core.AppManager;
	import flash.display.Stage;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.events.MouseEvent;
	import mvc.PublicNotification;
	import mvc.view.ui.AlertTest;
	import mvc.view.ui.DrawsTest;
	import mvc.view.ui.ModuleContain;
	import mvc.view.ui.ParamTest;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class StageMediator extends Mediator
	{
		//private var paramMdeiator:ParamMediator = new ParamMediator();
		private var _starling:Starling;
		public function StageMediator(mediatorName:String=null, viewComponent:Object=null) 
		{
			
		}
		
		private function onClick(e:MouseEvent):void {
			trace("onClick");
		}
		
		
		
		override public function listNotificationInterests():Array 
		{
			return [PublicNotification.LOADING_SHOW,
					PublicNotification.LOGIN_RESULT,
					PublicNotification.REG_RESULT];
		}
		
		override public function handleNotification(notification:INotification) : void
		{
			var name:String = notification.getName();
			var body:* = notification.getBody();
			switch(name) {
				case PublicNotification.REG_RESULT:
					ModuleContain.instance.changeSceen("login");
					break;
				case PublicNotification.LOGIN_RESULT:
					trace("handleNotification:", body);
					//ModuleContain.instance.changeSceen("mainui");
					
					
					
					//AppManager.facade.removeMediator("");
					AppManager.facade.registerMediator(new ParamMediator());
					break;
			}
		}
	}

}