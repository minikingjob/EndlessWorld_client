package xu.love.qq.mvc.view.lyricWin
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import xu.love.qq.component.board.LyricWindow;
	import xu.love.qq.component.board.PlayerWindow;
	import xu.love.qq.geom.Song;
	import xu.love.qq.mvc.AppConst;
	import xu.love.qq.mvc.view.BasicMediator;
	
	public class LyricWindowMediator extends BasicMediator
	{
		public static const NAME:String = "LyricWindowMediator";
		
		private var lyricWin:LyricWindow;
		private var playerWin:PlayerWindow;
		
		public function LyricWindowMediator(win:LyricWindow, playWin:PlayerWindow) {
			super(NAME);
			
			lyricWin = win;
			playerWin = playWin;
			
			init();
		}
		
		private function init():void{
			lyricWin.getLyric().setModel(playerWin.getProgress().getModel());
		}
		
		override public function listNotificationInterests():Array {
			return [AppConst.SYS_ON_PLAY];
		}
		
		override public function handleNotification(note:INotification):void{
			switch(note.getName()){
				case AppConst.SYS_ON_PLAY:
					var s:Song = note.getBody() as Song;
					lyricWin.getLyric().loadLrc(s);
					break;
			}
		}
		
		
	}
}