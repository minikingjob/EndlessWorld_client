package xu.love.qq.component.lookAndFeel
{
	import org.aswing.plaf.basic.BasicSplitPaneUI;
	import org.aswing.plaf.basic.splitpane.Divider;
	
	public class SplitPaneUI extends BasicSplitPaneUI
	{
		public function SplitPaneUI()
		{
			super();
		}
		
		override protected function createDivider():Divider{
			return new SimpleDivider(sp);
		}
	}
}
import flash.events.Event;
import flash.geom.Matrix;

import org.aswing.ASColor;
import org.aswing.AbstractButton;
import org.aswing.JSplitPane;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.GradientBrush;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.Pen;
import org.aswing.plaf.basic.icon.SolidArrowIcon;
import org.aswing.plaf.basic.splitpane.Divider;

class SimpleDivider extends Divider{
	
	public function SimpleDivider(sp:JSplitPane):void{
		super(sp);
		
		leftButton.addActionListener(onSelectLeft);
		rightButton.addActionListener(onSelectRight);
		rightButton.setVisible(false);
	}
	
	private function onSelectLeft(e:Event):void{
		leftButton.setVisible(false);
		rightButton.setVisible(true);
	}
	
	private function onSelectRight(e:Event):void{
		leftButton.setVisible(true);
		rightButton.setVisible(false);
	}
	
	override protected function layoutButtons():void{
		leftIcon.setArrow(Math.PI);
		rightIcon.setArrow(0);
		leftButton.setLocationXY(-1, (getHeight() - leftButton.getHeight()) / 2);
		rightButton.setLocationXY(-1, (getHeight() - rightButton.getHeight()) / 2);
	}
	
	override protected function paint(b:IntRectangle):void{
		var color:ASColor = this.getOwner().getUI().getColor("PlayListWindow.list.colorText");
		var g:Graphics2D = new Graphics2D(this.graphics);
		g.clear();
		var matrix:Matrix = new Matrix;
		matrix.createGradientBox(b.width - 1, b.height - 1, 0);
		var bursh:GradientBrush = new GradientBrush(GradientBrush.LINEAR, 
			[color.getRGB(), color.getRGB()],
			[1, 0],
			[0, 255],
			matrix);
		g.beginFill(bursh);
		g.drawRectangle(new Pen(color), b.x, b.y, b.width - 1, b.height - 1);
		g.endFill();
		
		leftIcon.paintIconWithColor(color);
		rightIcon.paintIconWithColor(color);
		layoutButtons();
	}
}