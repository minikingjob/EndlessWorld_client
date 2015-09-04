package xu.love.qq.component.lookAndFeel
{
	import flash.display.BitmapData;
	
	import org.aswing.Component;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.plaf.BaseComponentUI;
	
	public class MusicComponentUI extends BaseComponentUI implements IMusicComponentUI
	{
		public function MusicComponentUI()
		{
			super();
		}
		
		override public function installUI(c:Component):void {
			
		}
		
		override public function uninstallUI(c:Component):void {
			
		}
		
		public function getBitmapData(key:String):BitmapData{
			return this.getInstance(key) as BitmapData;
		}
		
		public function getRectang(key:String):IntRectangle{
			return getInstance(key) as IntRectangle;
		}
		
		override public function getPreferredSize(c:Component):IntDimension {
			var r:IntRectangle = this.getRectang(getPrefix() + "position");
			if(r)
				return r.getSize();
			return null;
		}
		
		override public function getMaximumSize(c:Component) : IntDimension {
			return this.getPreferredSize(c);
		}
		
		override public function getMinimumSize(c:Component) : IntDimension {
			return this.getPreferredSize(c);
		}
		
		public function getPrefix():String {
			return "";
		}
	}
}