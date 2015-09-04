package xu.love.qq.mvc.view.listWin
{
	import org.aswing.JList;
	import org.aswing.event.SelectionEvent;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import xu.love.qq.component.board.PlayListWindow;
	import xu.love.qq.geom.Song;
	import xu.love.qq.geom.SongList;
	import xu.love.qq.mvc.AppConst;
	import xu.love.qq.mvc.view.BasicMediator;
	
	public class SongListMediator extends BasicMediator
	{
		public static const NAME:String = "SongListMediator";
		
		private var playerWin:PlayListWindow;
		private var listOfList:JList;
		
		public function SongListMediator(win:PlayListWindow)
		{
			playerWin = win;
			super(NAME);
		}
		
		override public function onRegister():void{
			listOfList = playerWin.getListOfList();
			listOfList.setListData(getListProxy().getAllLists());
			listOfList.addSelectionListener(onSelectSongList);
			listOfList.setSelectedIndex(0);
		}
		
		override public function listNotificationInterests() : Array {
			return [AppConst.SYS_SKIN_LOAD_COMPLETE];
		}
		
		override public function handleNotification(note:INotification) : void {
			switch(note.getName()){
				case AppConst.SYS_SKIN_LOAD_COMPLETE:
					updateListScrollPaneUI();
					break;
			}
		}
		
		/**
		 * 手动更新这些UI 
		 * 
		 */		
		private function updateListScrollPaneUI():void{
			for each(var s:SongList in getListProxy().getAllLists()){
				s.getHolder().getVerticalScrollBar().updateUI();
			}
		}
		
		//当前播放列表
		private var songList:SongList;
		/**
		 * 切换列表 
		 * @param e
		 * 
		 */		
		private function onSelectSongList(e:SelectionEvent):void{
			if(songList){
				songList.removeSelectionListener(onSelectMP3);
			}
			songList = listOfList.getSelectedValue();
			if(songList){
				getListProxy().setCurrentList(songList);
				songList.addSelectionListener(onSelectMP3);
				playerWin.switchList(songList);
			}
		}
		
		private function onSelectMP3(e:SelectionEvent):void{
			if(e.isProgrammatic())
				return;
			var s:Song = songList.getSelectedValue();
			this.sendNotification(AppConst.SYS_PLAY, s);
		}
	}
}