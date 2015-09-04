package xu.love.qq.mvc.view.playerWin
{
	import flash.events.Event;
	
	import org.aswing.event.InteractiveEvent;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import xu.love.qq.component.MSlider;
	import xu.love.qq.component.MToggleButton;
	import xu.love.qq.component.board.PlayerWindow;
	import xu.love.qq.geom.Song;
	import xu.love.qq.mvc.AppConst;
	import xu.love.qq.mvc.view.BasicMediator;
	
	public class PlayerWindowMediator extends BasicMediator
	{
		public static const NAME:String = 'PlayerWindowMediator';
		
		private var playerWin:PlayerWindow;
		
		public function PlayerWindowMediator(win:PlayerWindow)
		{
			playerWin = win;
			super(NAME);
			
		}
		
		override public function onRegister():void{
			
			playerWin.getVolumeBar().addStateListener(onChangeVolume);
			playerWin.getProgress().addStateListener(onSeek);
			
			playerWin.getButtonPause().setModel(getModelProxy().getPauseModel());
			playerWin.getButtonPause().addActionListener(pauseMP3);
			
			playerWin.getButtonPlay().setModel(getModelProxy().getPlayModel());
			playerWin.getButtonPlay().addActionListener(playMP3);
			
			playerWin.getButtonNext().setModel(getModelProxy().getNextModel());
			playerWin.getButtonNext().addActionListener(nextMP3);
			
			playerWin.getButtonPrev().setModel(getModelProxy().getPrevModel());
			playerWin.getButtonPrev().addActionListener(prevMP3);
			
			playerWin.getButtonStop().setModel(getModelProxy().getStopModel());
			playerWin.getButtonStop().addActionListener(stopMP3);
			
			playerWin.getButtonMute().setModel(getModelProxy().getMuteModel());
			playerWin.getButtonMute().addSelectionListener(switchMute);
			
			playerWin.getInfo().setModel(getModelProxy().getSongInfoModel());
			
			playerWin.getButtonMini().addActionListener(switchToMini);
			//初始化音量大小
			playerWin.getVolumeBar().setValue(getPlayCoreProxy().getVolume() * 100);
			playerWin.getProgress().setModel(getPlayCoreProxy().getTimeModel());
			playerWin.getLed().setModel(getPlayCoreProxy().getTimeModel());
			updateUI();
		}
		
		override public function listNotificationInterests():Array {
			return [AppConst.SYS_ON_PLAY, AppConst.SD_PLAY_PROGRESS, AppConst.SD_STATUS_CHANGE];
		}
		
		override public function handleNotification(note:INotification):void{
			switch(note.getName()){
				case AppConst.SD_PLAY_PROGRESS:
					onPlayProgress();
					break;
				case AppConst.SYS_ON_PLAY:
					//歌曲信息滚动栏
					var s:Song = note.getBody() as Song;
					playerWin.getInfo().setMessages([s.getMp3Name(), s.getMp3Url()]);
					break;
				case AppConst.SD_STATUS_CHANGE:
					updateUI();
					break;
			}
		}
		
		private function onPlayProgress():void{
			if(playerWin.getProgress().getValueIsAdjusting())
				return;
			playerWin.getProgress().setValue(this.getPlayCoreProxy().getCurrentTime());
			playerWin.getProgress().setMaximum(this.getPlayCoreProxy().getTotalTime());
		}
		
		private function updateUI():void{
			playerWin.getProgress().setEnabled(!getPlayCoreProxy().isStop());
			playerWin.getButtonStop().setEnabled(!getPlayCoreProxy().isStop());
			playerWin.setPlayStatus(getPlayCoreProxy().isPlay());
			playerWin.getButtonNext().setEnabled(getListProxy().hasNext());
			playerWin.getButtonPrev().setEnabled(getListProxy().hasPrev());
			
			updateStereo();
			updateStatus();
		}
		
		//play
		private function playMP3(e:Event):void{
			this.sendNotification(AppConst.SYS_PLAY);
		}
		
		//播放下一首
		private function nextMP3(e:Event):void{
			this.sendNotification(AppConst.SYS_NEXT);
		}
		
		//播放上一首
		private function prevMP3(e:Event):void{
			this.sendNotification(AppConst.SYS_PREV);
		}
		
		//暂停
		private function pauseMP3(e:Event):void{
			getPlayCoreProxy().pause();
		}
		
		//stop
		private function stopMP3(e:Event):void{
			getPlayCoreProxy().stop();
		}
		
		
		private function switchMute(e:InteractiveEvent):void {
			var b:MToggleButton = playerWin.getButtonMute();
			var v:Number;
			if(b.isSelected()){
				b.putClientProperty("volume", playerWin.getVolumeBar().getValue());
				v = 0;
			} else {
				v = Number(b.getClientProperty("volume"));
			}
			playerWin.getVolumeBar().setValue(v);
			playerWin.getVolumeBar().setEnabled(v != 0);
			updateStereo();
		}
		
		/**
		 * 切换到迷你模式 
		 * @param e
		 * @see 
		 */		
		private function switchToMini(e:Event):void{
			this.sendNotification(AppConst.SYS_SWITCH_MINIMODE, true);
		}
		
		//跳播
		private function onSeek(e:InteractiveEvent):void{
			var s:MSlider = playerWin.getProgress();
			if(s.getValueIsAdjusting()){
			} else if(!e.isProgrammatic()) {
				getPlayCoreProxy().seek(s.getValue() / s.getMaximum(), false);
			}
		}
		
		private function onChangeVolume(e:InteractiveEvent):void{
			var p:Number = playerWin.getVolumeBar().getValue() / 100;
			getPlayCoreProxy().setVolume(p);
			if(playerWin.getVolumeBar().getValueIsAdjusting()){
				playerWin.getStatus().setText("音量:" + playerWin.getVolumeBar().getValue() + "%");
			} else {
				updateStatus();
			}
		}
		
		private function updateStereo():void{
			playerWin.getStereo().setText(playerWin.getVolumeBar().getValue() != 0 ? "立体声":"静音");
		}
		
		private function updateStatus():void{
			playerWin.getStatus().setText(getPlayCoreProxy().getStatus());
		}
	}
}