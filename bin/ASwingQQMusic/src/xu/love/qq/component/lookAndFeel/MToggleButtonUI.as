package xu.love.qq.component.lookAndFeel
{
	import flash.display.BitmapData;
	
	import org.aswing.Component;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.plaf.basic.BasicToggleButtonUI;
	import org.aswing.skinbuilder.SkinButtonBackground;
	
	import xu.love.qq.component.MToggleButton;
	import xu.love.qq.utils.MusicUtils;
	
	public class MToggleButtonUI extends BasicToggleButtonUI implements IMusicComponentUI
	{
		private var pSize:IntDimension;
		
		public function MToggleButtonUI()
		{
			super();
		}
		
		override public function installUI(c:Component):void{
			button = MToggleButton(c);
			var p:String = getPrefix();
			var image:BitmapData = this.getBitmapData(p + "image") || new BitmapData(4, 1, true, 0x00ffffff);
			pSize = new IntDimension(image.width / 4, image.height);
			
			this.putDefault(p + "bg", 					new SkinButtonBackground(p));
			this.putDefault(p + "defaultImage",		MusicUtils.copyAndCreateBitmap(image, 0));
			this.putDefault(p + "rolloverImage",		MusicUtils.copyAndCreateBitmap(image, 1));
			this.putDefault(p + "pressedImage",		MusicUtils.copyAndCreateBitmap(image, 2));
			this.putDefault(p + "disabledImage",		MusicUtils.copyAndCreateBitmap(image, 3));
			
			this.putDefault(p + "selectedImage",				getDefault(p + "pressedImage"));
			this.putDefault(p + "rolloverSelectedImage",		getDefault(p + "rolloverImage"));
			this.putDefault(p + "disabledSelectedImage",		getDefault(p + "disabledImage"));
			super.installUI(c);
		}
		
		override public function getPreferredSize(c:Component):IntDimension{
			return pSize;
		}
		
		public function getBitmapData(key:String):BitmapData {
			return getInstance(key);
		}
		
		public function getRectang(key:String):IntRectangle {
			return getInstance(key);
		}
		
		public function getPrefix():String {
			return "MToggleButton." + button.getClientProperty("xmlField") + ".";
		}
		
		override protected function getPropertyPrefix():String {
			return getPrefix();
		}
	}
}