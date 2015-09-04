package xu.love.qq.mvc.controller.mp3 
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import xu.love.qq.mvc.controller.BasicCommand;
	/**
	 * ...
	 * 播放上一首歌命令
	 * @author tangzx <xu love qq>
	 */
	public class PrevCommand extends BasicCommand
	{
		
		public function PrevCommand() 
		{
			
		}
		
		override public function execute(notification:INotification):void 
		{
			this.getListProxy().selectPrevSong();
			this.getMp3CoreProxy().playSong(getListProxy().getCurrentSong());
		}
		
	}

}