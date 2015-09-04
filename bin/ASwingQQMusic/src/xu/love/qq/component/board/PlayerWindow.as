package xu.love.qq.component.board
{
	import flash.events.MouseEvent;
	
	import org.aswing.ASColor;
	import org.aswing.Container;
	import org.aswing.JPanel;
	
	import xu.love.qq.component.MButton;
	import xu.love.qq.component.MLabel;
	import xu.love.qq.component.MSlider;
	import xu.love.qq.component.MToggleButton;
	import xu.love.qq.component.board.playerWindow.*;
	import xu.love.qq.component.layout.PlayerWindowLayout;

	/**
	 * 播放器主控制面板 
	 * @author tangzx
	 * 
	 */	
	public class PlayerWindow extends AbstractBoard
	{
		private var buttonPlay:MButton;
		private var buttonPause:MButton;
		private var buttonStop:MButton;
		private var buttonPrev:MButton;
		private var buttonNext:MButton;
		private var buttonClose:MButton;
		private var buttonMini:MButton;
		private var buttonMiniMode:MButton;
		private var buttonMute:MToggleButton;
		
		private var progressBar:MSlider;
		private var volumeBar:MSlider;
		//LED:
		private var led:Led;
		//info
		private var info:SongInfo;
		//
		private var stereo:MLabel;
		private var status:MLabel;
		
		public function PlayerWindow() {
			super(new PlayerWindowLayout(this));
			var pane:Container = this;
			
			buttonPlay = new MButton;
			buttonPlay.setXmlField("play");
			pane.append(buttonPlay);
			
			buttonPause = new MButton;
			buttonPause.setXmlField("pause");
			pane.append(buttonPause);
			
			buttonStop = new MButton;
			buttonStop.setXmlField("stop");
			buttonStop.setEnabled(false);
			pane.append(buttonStop);
			
			buttonPrev = new MButton;
			buttonPrev.setXmlField("prev");
			pane.append(buttonPrev);
			
			buttonNext = new MButton;
			buttonNext.setXmlField("next");
			pane.append(buttonNext);
			
			buttonClose = new MButton;
			buttonClose.setXmlField("exit");
			buttonClose.setToolTipText("退出");
			pane.append(buttonClose);
			
			buttonMini = new MButton;
			buttonMini.setXmlField("minimize");
			buttonMini.setToolTipText("最小化");
			pane.append(buttonMini);
			
			buttonMiniMode = new MButton;
			buttonMiniMode.setXmlField("minimode");
			buttonMiniMode.setToolTipText("迷你模式");
			pane.append(buttonMiniMode);
			
			//静音
			buttonMute = new MToggleButton;
			buttonMute.setXmlField("normal.mute");
			append(buttonMute);
			
			progressBar = new MSlider;
			progressBar.setEnabled(false);
			progressBar.setXmlField("normal.progress");
			pane.append(progressBar);
			
			volumeBar = new MSlider;
			//volumeBar.setOpaque(true);
			volumeBar.setBackground(ASColor.CYAN);
			volumeBar.setXmlField("normal.volume");
			pane.append(volumeBar);
			
			//LED
			led = new Led(progressBar.getModel());
			led.setXmlField("normal");
			pane.append(led);
			
			//info:
			info = new SongInfo;
			info.setXmlField("normal");
			pane.append(info);
			
			//
			stereo = new MLabel("立体音");
			stereo.setXmlField("stereo");
			pane.append(stereo);
			
			status = new MLabel("停止");
			status.setXmlField("status");
			pane.append(status);
			
			pane.mouseChildren = true;
			mouseChildren = true;
			setPlayStatus(false);
		}
		
		public function getProgress():MSlider{
			return progressBar;
		}
		
		public function getVolumeBar():MSlider{
			return volumeBar;
		}
		
		public function getButtonPlay():MButton {
			return buttonPlay;
		}
		
		public function getButtonPause():MButton{
			return buttonPause;
		}
		
		public function getButtonNext():MButton{
			return buttonNext;
		}
		
		public function getButtonPrev():MButton{
			return buttonPrev;
		}
		
		public function getButtonStop():MButton{
			return buttonStop;
		}
		
		public function getInfo():SongInfo{
			return info;
		}
		
		public function getStereo():MLabel{
			return stereo;
		}
		
		public function getStatus():MLabel{
			return status;
		}
		
		public function getLed():Led{
			return led;
		}
		
		public function setPlayStatus(isPlay:Boolean):void{
			buttonPause.setVisible(isPlay);
			buttonPlay.setVisible(!isPlay);
		}
		
		public function getButtonMini():MButton{
			return buttonMini;
		}
		
		public function getButtonMute():MToggleButton {
			return buttonMute;
		}
		/*override protected function checkMove(e:MouseEvent):void{
			
		}*/
		
		override public function getUIClassID():String {
			return "PlayerWindowUI";
		}
	}
}