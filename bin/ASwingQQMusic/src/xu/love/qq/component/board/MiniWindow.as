package xu.love.qq.component.board
{
	import org.aswing.JPanel;
	import org.aswing.LayoutManager;
	
	import xu.love.qq.component.MButton;
	import xu.love.qq.component.MSlider;
	import xu.love.qq.component.MToggleButton;
	import xu.love.qq.component.board.playerWindow.Led;
	import xu.love.qq.component.board.playerWindow.SongInfo;
	import xu.love.qq.component.layout.MiniWindowLayout;
	
	public class MiniWindow extends AbstractBoard
	{
		private var playButton:MButton;
		private var pauseButton:MButton;
		private var stopButton:MButton;
		private var nextButton:MButton;
		private var prevButton:MButton;
		private var lrcButton:MButton;
		private var exitButton:MButton;
		private var minimodeButton:MButton;
		private var minimizeButton:MButton;
		
		private var muteButton:MToggleButton;
		
		private var info:SongInfo;
		private var volume:MSlider;
		private var progress:MSlider;
		private var led:Led;
		
		public function MiniWindow()
		{
			super(new MiniWindowLayout);
			
			pauseButton = new MButton;
			pauseButton.setXmlField("mini.pause");
			append(pauseButton);
			
			playButton = new MButton;
			playButton.setXmlField("mini.play");
			append(playButton);
			
			stopButton = new MButton;
			stopButton.setXmlField("mini.stop");
			append(stopButton);
			
			nextButton = new MButton;
			nextButton.setXmlField("mini.next");
			append(nextButton);
			
			prevButton = new MButton;
			prevButton.setXmlField("mini.prev");
			append(prevButton);
			
			muteButton = new MToggleButton;
			muteButton.setXmlField("mini.mute");
			append(muteButton);
			
			exitButton = new MButton;
			exitButton.setXmlField("mini.exit");
			append(exitButton);
			
			minimodeButton = new MButton;
			minimodeButton.setXmlField("mini.minimode");
			append(minimodeButton);
			
			minimizeButton = new MButton;
			minimizeButton.setXmlField("mini.minimize");
			append(minimizeButton);
			
			lrcButton = new MButton;
			lrcButton.setXmlField("mini.lyric");
			append(lrcButton);
			
			info = new SongInfo;
			info.setXmlField("mini");
			append(info);
			
			led = new Led;
			led.setXmlField("mini");
			append(led);
			
			progress = new MSlider;
			progress.setXmlField("mini.progress");
			append(progress);
		}
		
		public function getPlayButton():MButton{
			return playButton;
		}
		public function getPauseButton():MButton{
			return pauseButton;
		}
		public function getStopButton():MButton{
			return stopButton;
		}
		public function getNextButton():MButton{
			return nextButton;
		}
		public function getPrevButton():MButton{
			return prevButton;
		}
		public function getMuteButton():MToggleButton {
			return muteButton;
		}
		public function getMiniButton():MButton{
			return this.minimodeButton;
		}
		
		public function getProgress():MSlider{
			return this.progress;
		}
		
		public function getLed():Led{
			return led;
		}
		
		public function getInfo():SongInfo{
			return info;
		}
		
		public function setPlayStatus(isPlay:Boolean):void{
			playButton.setVisible(!isPlay);
			pauseButton.setVisible(isPlay);
		}
		
		override public function getUIClassID():String {
			return "MiniWindowUI";
		}
	}
}