package xu.love.qq.mvc.controller.mp3 
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import xu.love.qq.geom.Song;
	import xu.love.qq.mvc.controller.BasicCommand;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class PlayCommand extends BasicCommand
	{
		
		public function PlayCommand() 
		{
			
		}
		
		
		override public function execute(note:INotification):void 
		{
			var s:Song = note.getBody() as Song;
			
			if (s != null) {
				getMp3CoreProxy().playSong(s);
			}else {
				if (getMp3CoreProxy().isPause()) {
					getMp3CoreProxy().play();
				}else {
					getListProxy().selectDefaultSong();
					getMp3CoreProxy().playSong(getListProxy().getCurrentSong());
				}
			}
		}
		
	}

}