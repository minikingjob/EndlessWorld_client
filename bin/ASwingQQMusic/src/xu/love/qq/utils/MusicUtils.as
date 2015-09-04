package xu.love.qq.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class MusicUtils
	{
		public static function createScrollBarButton(bmp:BitmapData, incr:Boolean = true):SimpleButton {
			var b:SimpleButton = new SimpleButton;
			var hIndex:int = incr ? 0 : 1;
			b.upState = copyAndCreateBitmap(bmp, 0, 3, hIndex, 2);
			b.overState = copyAndCreateBitmap(bmp, 1, 3, hIndex, 2);
			b.downState = copyAndCreateBitmap(bmp, 2, 3, hIndex, 2);
			return b;
		}
		
		public static function copyAndCreateBitmap(source:BitmapData, wIndex:int, wSplitNum:int = 4, hIndex:int = 0, hSplitNum:int = 1):Bitmap{
			return new Bitmap(copyAndCreateBitmapData(source, wIndex, wSplitNum, hIndex, hSplitNum));
		}
		
		public static function copyAndCreateBitmapData(source:BitmapData, wIndex:int, wSplitNum:int = 4, hIndex:int = 0, hSplitNum:int = 1):BitmapData{
			var pw:int = source.width / wSplitNum;
			var ph:int = source.height / hSplitNum;
			
			var targetBitmapData:BitmapData = new BitmapData(pw, ph, true, 0x00ffffff);
			targetBitmapData.copyPixels(source, new Rectangle(wIndex * pw, hIndex * ph, pw, ph), new Point);
			return targetBitmapData;
		}
	}
}