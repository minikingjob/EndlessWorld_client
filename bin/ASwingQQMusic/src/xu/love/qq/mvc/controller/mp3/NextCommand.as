package xu.love.qq.mvc.controller.mp3 
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import xu.love.qq.mvc.controller.BasicCommand;
	
	/**
	 * ...
	 * 下一曲命令
	 * @author tangzx <xu love qq>
	 */
	public class NextCommand extends BasicCommand
	{
		
		public function NextCommand() 
		{
			
		}
		
		override public function execute(notification:INotification):void {
			this.getListProxy().selectNextSong();
			this.getMp3CoreProxy().playSong(getListProxy().getCurrentSong());
		}
		
	}

}