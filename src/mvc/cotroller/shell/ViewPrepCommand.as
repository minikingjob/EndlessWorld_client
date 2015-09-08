package mvc.cotroller.shell 
{
	import flash.display.Stage;
	import mvc.PublicNotification;
	import mvc.view.ParamMediator;
	import mvc.view.StageMediator;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class ViewPrepCommand extends SimpleCommand implements ICommand 
	{
		override public function execute(e:INotification):void {
			trace("ViewPrepCommand -execute");
            facade.registerMediator(new ParamMediator());

		}
	}

}