package application.controller
{
	import application.model.DataProxy;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class ModelPrepCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			facade.registerProxy( new DataProxy() );

		}
	}
}