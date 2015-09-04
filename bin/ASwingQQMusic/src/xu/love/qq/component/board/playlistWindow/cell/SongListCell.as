package xu.love.qq.component.board.playlistWindow.cell
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	import org.aswing.*;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.*;
	import org.aswing.plaf.ComponentUI;
	
	public class SongListCell extends DefaultListCell implements GroundDecorator
	{
		protected var isSelect:Boolean;
		private var decoratorShape:Shape;
		
		public function SongListCell()
		{
			super();
			decoratorShape = new Shape;
			getCellComponent().setBackgroundDecorator(this);
		}
		
		override protected function getStringValue(value:*):String {
			return value.getName();
		}
		
		override public function setListCellStatus(list:JList, isSelected:Boolean, index:int):void {
			this.isSelect = isSelected;
			
			var ui:ComponentUI = list.getUI();
			var c:Component = this.getCellComponent();
			if(isSelected){
				c.setForeground(ASColor.WHITE);
			} else {
				c.setForeground(ui.getColor("PlayListWindow.list.colorText"));
			}
			
			//隔行的背景色不一样
			if(index % 2){
				c.setBackground(ui.getColor("PlayListWindow.list.colorBkgnd"));
			} else {
				c.setBackground(ui.getColor("PlayListWindow.list.colorBkgnd2"));
			}
		}
		
		/**
		 * 装饰背景（使用图片填充或渐变色） 
		 * @param c
		 * @param g
		 * @param b
		 * 
		 */		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void {
			g = new Graphics2D(decoratorShape.graphics);
			g.clear();
			if(!isSelect) return;
			
			var brush:IBrush;
			var bitmapData:BitmapData = c.getUI().getInstance("PlayListWindow.list.selectedImage");
			var matrix:Matrix = new Matrix;
			if(bitmapData != null){
				//将图片高度拉伸
				matrix.createBox(1, b.height / bitmapData.height);
				brush = new BitmapBrush(bitmapData, matrix);
			} else {
				var bgnd1:ASColor = c.getUI().getColor("PlayListWindow.list.colorText");
				//使用渐变色填充
				matrix.createGradientBox(b.width, b.height, Math.PI / 2);
				brush = new GradientBrush(GradientBrush.LINEAR,
					[bgnd1.getRGB(),bgnd1.getRGB()],
					[1, 0],
					[0, 255],
					matrix);
			}
			var pen:IPen = new Pen(ASColor.WHITE);
			g.beginFill(brush);
			g.drawRectangle(pen, b.x, b.y, b.width - 1, b.height - 1);
			g.endFill();
		}
		
		public function getDisplay(c:Component):DisplayObject {
			return decoratorShape;
		}
	}
}