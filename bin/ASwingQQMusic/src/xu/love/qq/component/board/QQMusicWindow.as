package xu.love.qq.component.board 
{
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import org.aswing.AssetBackground;
	import org.aswing.Container;
	import org.aswing.JPanel;
	
	import xu.love.qq.component.layout.GlobalLayout;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class QQMusicWindow extends JPanel
	{
		private var playerWindow:PlayerWindow;
		private var playlistWindow:PlayListWindow;
		private var lyricWindow:LyricWindow;
		
		private var img:Bitmap;
		
		public function QQMusicWindow() 
		{
			super();
			var pane:Container = this;
			pane.setLayout(new GlobalLayout(this));
			
			playerWindow = new PlayerWindow;
			pane.append(playerWindow);
			
			playlistWindow = new PlayListWindow;
			pane.append(playlistWindow);
			
			lyricWindow = new LyricWindow;
			pane.append(lyricWindow);
		}
		
		public function getPlayerWindow():PlayerWindow {
			return playerWindow;
		}
		
		
		public function getPlaylistWindow():PlayListWindow {
			return playlistWindow;
		}
		
		public function getLyricWindow():LyricWindow{
			return lyricWindow;
		}
		
		//do nothing.
		override public function doLayout():void { }
		
		public function layoutWindows():void {
			super.doLayout();
		}
		
		/*override public function updateUI():void {
			var bmp:BitmapData = new BitmapData(getPreferredWidth(), getPreferredHeight());
				bmp.draw(this);
				img = new Bitmap(bmp);
				setForegroundDecorator(new AssetBackground(img));
				
			super.updateUI();
			//fade out
			TweenMax.to(img, 1, { alpha:0, onComplete:onUpdateComplete } );
		}*/
		
		private function onUpdateComplete():void
		{
			setForegroundDecorator(null);
			img.bitmapData.dispose();
		}
		
	}

}