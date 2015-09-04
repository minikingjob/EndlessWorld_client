package xu.love.qq.component.lookAndFeel
{
	import flash.display.BitmapData;
	
	import org.aswing.Component;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.plaf.basic.BasicButtonUI;
	import org.aswing.skinbuilder.SkinButtonBackground;
	
	import xu.love.qq.component.MButton;
	import xu.love.qq.utils.MusicUtils;

	public class MButtonUI extends BasicButtonUI implements IMusicComponentUI
	{
		private var pSize:IntDimension;
		
		override public function installUI(c:Component) : void {
			this.button = MButton(c);
			var pp:String = getPrefix();
			
			//fix bug:
			//容错模式, 如果XML配置里没设定按钮皮肤图片，则创建一个空的透明的位图显示，（防出错）
			var bitmapData:BitmapData = getBitmapData(pp + "image") || new BitmapData(4, 1, true, 0x00FFFFFF);
			pSize = new IntDimension(bitmapData.width / 4, bitmapData.height);
			
			//fix bug:
			//在右对齐情况下，按钮向XML配置文件里设定的区域右靠
			var align:String = getString(pp + "align");
			if(align == "right"){
				var bounds:IntRectangle = getRectang(pp + "position");
				bounds.move(bounds.width - pSize.width, 0);
			}
			
			
			this.putDefault(pp + "bg", 				new SkinButtonBackground(pp));
			this.putDefault(pp + "defaultImage", 		MusicUtils.copyAndCreateBitmap(bitmapData, 0));
			this.putDefault(pp + "rolloverImage", 	MusicUtils.copyAndCreateBitmap(bitmapData, 1));
			this.putDefault(pp + "pressedImage", 		MusicUtils.copyAndCreateBitmap(bitmapData, 2));
			this.putDefault(pp + "disabledImage", 	MusicUtils.copyAndCreateBitmap(bitmapData, 3));
			
			super.installUI(c);
		}
		
		override public function getPreferredSize(c:Component):IntDimension {
			return pSize;
		}
		
		public function getBitmapData(key:String):BitmapData{
			return this.getInstance(key);
		}
		
		public function getRectang(key:String):IntRectangle{
			return this.getInstance(key);
		}
		
		public function getPrefix():String{
			return "MButton." + button.getClientProperty("xmlField") + ".";
		}
		
		override protected function getPropertyPrefix():String {
			return getPrefix();
		}
	}
}