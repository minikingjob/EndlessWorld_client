package mvc.view 
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class TestMediator extends Mediator implements IMediator 
	{
		public static const name:String = "TestMediator";
		public function TestMediator(mediatorName:String=null, viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			
			
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		/* INTERFACE org.puremvc.as3.interfaces.IMediator */
		
		public function listNotificationInterests():Array 
		{
			
		}
		
		public function onRegister():void 
		{
			
		}
		
		public function handleNotification(notification:INotification):void 
		{
			
		}
		
		public function getMediatorName():String 
		{
			return name;
		}
		
		public function setViewComponent(viewComponent:Object):void 
		{
			
		}
		
		public function getViewComponent():Object 
		{
			
		}
		
		public function onRemove():void 
		{
			
		}
		
		
		
	}

}