package xu.love.qq.mvc.controller.startup
{
	import org.puremvc.as3.multicore.patterns.command.AsyncMacroCommand;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class StartupCommand extends AsyncMacroCommand
	{
		public function StartupCommand():void {
			this.addSubCommand(LoadConfigCommand);
			this.addSubCommand(LoadPlaylistCommand);
			this.addSubCommand(InitializeAppCommand);
		}
	}

}