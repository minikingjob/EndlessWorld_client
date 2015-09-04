package xu.love.qq.component.lookAndFeel.playerWindow
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	import org.aswing.Component;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.BitmapBrush;
	import org.aswing.graphics.Graphics2D;
	
	import xu.love.qq.component.board.playerWindow.Led;
	import xu.love.qq.component.lookAndFeel.MusicComponentUI;
	
	public class LedUI extends MusicComponentUI
	{
		private static var indexMap:Object = { "0":0, "1":1, "2":2, "3":3, "4":4, "5":5 , "6":6, "7":7, "8":8, "9":9, ":":10, "-":11 };
		private var led:Led;
		private var numberAsset:BitmapData;
		private var pW:int;
		private var curSec:Number = NaN;
		
		public function LedUI()
		{
			super();
		}
		
		override public function installUI(c:Component):void {
			led = Led(c);
			led.addStateListener(onDataChange);
			
			var pp:String = this.getPrefix();
			numberAsset = this.getBitmapData(pp + "numberImage") || new BitmapData(12, 1, true, 0x00FFFFFF);
			pW = numberAsset.width / 12;
			//fixed bug
			var posRect:IntRectangle = getRectang(getPrefix() + "position");
			if(getString(getPrefix() + "align") == "right"){
				posRect.x = (posRect.x + posRect.width) - pW * 6;
			}
			
			onDataChange();
		}
		
		override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void {
			curSec = NaN;
			onDataChange();
		}
		
		override public function uninstallUI(c:Component):void {
			
		}
		
		override public function getPrefix():String {
			return "Led." + led.getClientProperty("xmlField") + ".";
		}
		
		override public function getPreferredSize(c:Component):IntDimension {
			return this.getRectang(getPrefix() + "position").getSize();
		}
		
		private function onDataChange(e:Event = null):void{
			var nowSec:int;
			if(led.getInverted())
				nowSec = Math.floor((led.getMaximum() - led.getValue()) / 1000);
			else
				nowSec = Math.floor(led.getValue() / 1000);
			
			if(nowSec != curSec){
				var g:Graphics2D = new Graphics2D(led.graphics);
				g.clear();
				curSec = nowSec;
				
				var mm:int = Math.floor(nowSec / 60);
				var ss:int = Math.floor(nowSec % 60);
				var smm:String = "0" + mm;
				var sss:String = "0" + ss;
				var text:String = smm.substr(smm.length - 2) + ":" + sss.substr(sss.length - 2);
				
				if(led.getInverted())
					text = "-" + text;
				else
					text = " " + text;
				
				//draw:
				for(var i:int = 0; i < text.length; i++){
					var index:Number = indexMap[text.charAt(i)];
					var matrix:Matrix = new Matrix;
					if(isNaN(index))
						continue;
					matrix.createBox(1,1,0,-(index - i) * pW);
					var brush:BitmapBrush = new BitmapBrush(numberAsset, matrix, false);
					g.fillRectangle(brush,
						i * pW,
						0,
						pW,
						numberAsset.height);
				}
			}
		}
	}
}