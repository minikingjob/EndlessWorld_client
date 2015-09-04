package xu.love.qq.component.lookAndFeel
{
	import org.aswing.Component;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.skinbuilder.SinglePicBackground;
	
	public class MPopupMenuBackground extends SinglePicBackground
	{
		public function MPopupMenuBackground()
		{
			super();
		}
		[Embed(source="assets/Menu_bg.png", scaleGridTop="7", scaleGridBottom="150", 
		scaleGridLeft="30", scaleGridRight="40")]
		private var PopupMenu_bgImage:Class;
		
		override protected function checkLoad(c:Component):void {
			c.setClipMasked(false);
			image = new PopupMenu_bgImage();
			loaded = true;
		}
		
		override public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):void{
			//bounds.setSize(c.getInsets().getOutsideSize());
			
			image.x = bounds.x - 6;
			image.y = bounds.y - 3;
			image.width = bounds.width + 9;
			image.height = bounds.height + 6;
		}
		
		override protected function getDefaltsKey():String{
			return "PopupMenu.bgImage";
		}
	}
}