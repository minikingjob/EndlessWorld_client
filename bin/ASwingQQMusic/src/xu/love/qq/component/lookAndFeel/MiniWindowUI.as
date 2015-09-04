package xu.love.qq.component.lookAndFeel
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import org.aswing.AssetBackground;
	import org.aswing.Component;
	import org.aswing.geom.IntDimension;
	
	import xu.love.qq.component.board.MiniWindow;

	public class MiniWindowUI extends MusicComponentUI
	{
		private var mini:MiniWindow;
		private var image:BitmapData;
		
		public function MiniWindowUI()
		{
			super();
		}
		
		override public function installUI(c:Component):void{
			mini = MiniWindow(c);
			
			image = getBitmapData(getPrefix() + "image");
			mini.setBackgroundDecorator(new AssetBackground(new Bitmap(image)));
		}
		
		override public function getPrefix():String{
			return "MiniWindow.";
		}
		
		override public function getPreferredSize(c:Component):IntDimension {
			return new IntDimension(image.width, image.height);
		}
	}
}