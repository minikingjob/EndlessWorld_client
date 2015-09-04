package mvc.cotroller 
{
	import mvc.cotroller.shell.ModelPrepCommand;
	import mvc.cotroller.shell.ViewPrepCommand;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.MacroCommand;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class AppCommand extends MacroCommand  implements ICommand 
	{
		
		public function AppCommand() 
		{
			super();
			
		}
		
		
		override protected function initializeMacroCommand():void {
			trace("initializeMacroCommand");
			addSubCommand(ModelPrepCommand);
			addSubCommand(ViewPrepCommand);
		}
		
	}

}