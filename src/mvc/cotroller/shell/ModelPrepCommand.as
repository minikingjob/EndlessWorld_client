package mvc.cotroller.shell 
{
	import mvc.model.PhpProxy;
	import mvc.model.vo.PhpProxyName;
	import mvc.PublicNotification;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand implements ICommand 
	{		
		override public function execute(notification:INotification):void {			
			var name:String = notification.getName();
			var body:* = notification.getBody();
			trace("ModelPrepCommand - execute", name, body);
			switch(name) {
				case PublicNotification.START_UP:
					facade.registerProxy(new PhpProxy(PhpProxyName.serverlist));
					break;
				case PublicNotification.LOGIN_RESULT:
					
					break;
			}
			
			
		}
		
	}

}