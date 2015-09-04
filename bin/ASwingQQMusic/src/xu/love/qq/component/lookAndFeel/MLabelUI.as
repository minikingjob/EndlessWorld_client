package xu.love.qq.component.lookAndFeel
{
	import flash.display.BitmapData;
	
	import org.aswing.Component;
	import org.aswing.JLabel;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.plaf.basic.BasicLabelUI;
	
	public class MLabelUI extends BasicLabelUI implements IMusicComponentUI
	{
		public function MLabelUI()
		{
			super();
		}
		
		override protected function installDefaults(b:JLabel):void{
			super.installDefaults(b);
			b.setForeground(getColor(getPrefix() + "color"));
			b.setHorizontalAlignment(getUint(getPrefix() + "align"));
		}
		
		override public function paint(c:Component, g:Graphics2D, r:IntRectangle):void{
			super.paint(c, g, r);
			//offset -4
			textField.y -= 4;
		}
		
		public function getBitmapData(key:String):BitmapData{
			return this.getInstance(key) as BitmapData;
		}
		
		public function getRectang(key:String):IntRectangle{
			return getInstance(key) as IntRectangle;
		}
		
		public function getPrefix():String {
			return "MLabel." + this.label.getClientProperty("xmlField") + ".";
		}
		
		override public function getPreferredSize(c:Component):IntDimension {
			return getRectang(getPrefix() + "position").getSize();
		}
	}
}