package xu.love.qq.component.lookAndFeel 
{
	import org.aswing.AssetBackground;
	import org.aswing.Component;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	
	import xu.love.qq.component.ScaleBitmap;
	import xu.love.qq.component.board.LyricWindow;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class MLyricWindowUI extends MusicComponentUI
	{
		private var background:ScaleBitmap;
		private var lyricWindow:LyricWindow;
		private var miniSize:IntDimension;
		
		public function MLyricWindowUI() 
		{
			
		}
		
		override public function installUI(c:Component):void {
			lyricWindow = c as LyricWindow;
			
			var pp:String = getPrefix();
			var rsr:IntRectangle = this.getRectang(pp + "resizeRect");
			background = new ScaleBitmap(getBitmapData(pp + "background"));
			background.scale9Grid = rsr.toRectangle();
			//最小尺寸即图片原始尺寸
			miniSize = new IntDimension(background.width, background.height);
			c.setBackgroundDecorator(new AssetBackground(background));
			lyricWindow.setOriginalSize(miniSize);
		}
		
		override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void {
			background.width = b.width;
			background.height = b.height;
		}
		
		override public function uninstallUI(c:Component):void {
			c.setBackgroundDecorator(null);
		}
		
		override public function getPrefix():String {
			return "LyricWindow.";
		}
		
		override public function getMaximumSize(c:Component):IntDimension {
			return IntDimension.createBigDimension();
		}
		
		override public function getMinimumSize(c:Component):IntDimension { return miniSize; }
		
	}

}