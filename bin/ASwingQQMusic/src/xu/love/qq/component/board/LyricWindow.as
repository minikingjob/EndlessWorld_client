package xu.love.qq.component.board 
{
	import org.aswing.JButton;
	import org.aswing.resizer.DefaultResizer;
	import org.aswing.resizer.ResizerController;
	
	import xu.love.qq.component.MButton;
	import xu.love.qq.component.board.lyricWindow.Lyric;
	import xu.love.qq.component.layout.LyricWindowLayout;
	import xu.love.qq.component.lookAndFeel.MLyricWindowUI;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class LyricWindow extends AbstractBoard
	{
		public var closeButton:MButton;
		
		private var lyric:Lyric;
		
		public function LyricWindow() 
		{
			super(new LyricWindowLayout);
			init();
		}
		
		protected function init():void{
			ResizerController.create(this, new DefaultResizer);
			
			closeButton = new MButton;
			closeButton.setXmlField("lyric.close");
			append(closeButton);
			
			lyric = new Lyric;
			append(lyric);
		}
		
		public function getLyric():Lyric{
			return lyric;
		}
		
		override public function getUIClassID():String {
			return "LyricWindowUI";
		}
		
	}

}