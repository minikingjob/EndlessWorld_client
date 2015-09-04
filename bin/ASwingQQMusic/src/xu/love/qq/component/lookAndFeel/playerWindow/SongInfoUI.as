package xu.love.qq.component.lookAndFeel.playerWindow
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.aswing.ASFont;
	import org.aswing.Component;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	
	import xu.love.qq.component.board.playerWindow.SongInfo;
	import xu.love.qq.component.lookAndFeel.MusicComponentUI;
	
	public class SongInfoUI extends MusicComponentUI
	{
		private var textFieldAry:Array;
		private var info:SongInfo;
		private var container:Sprite;
		private var tw:TimelineMax;
		
		public function SongInfoUI()
		{
			super();
		}
		
		override public function installUI(c:Component):void{
			info = SongInfo(c);
			container = new Sprite;
			info.addChild(container);
		}
		
		override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void{
			super.paint(c, g, b);
			
			while(container.numChildren)
				container.removeChildAt(0);
			
			textFieldAry = [];
			var arr:Array = info.getMessages();
			for(var i:int = 0; i < arr.length; i++){
				textFieldAry.push(createTextField(arr[i]));
			}
			
			scrollText();
		}
		
		private function scrollText():void{
			if(tw != null) tw.kill();
			
			var fT:TextField = textFieldAry[0];
			fT.y = 0;
			container.y = -2;
			container.x = 0;
			container.addChild(fT);
			var s:IntDimension = this.getPreferredSize(null);
			
			tw = new TimelineMax({ delay:1 });
			
			if(fT.width > s.width){
				var dx:int = fT.width - s.width;
				var dur:Number = cDurtion(dx);
				tw.append(TweenMax.to(container, dur, { x:-dx, yoyo:true, repeat:1, repeatDelay:2 }));
			}
			
			if(textFieldAry.length > 1){
				var sT:TextField = textFieldAry[1];
				sT.y = fT.height;
				container.addChild(sT);
				tw.append(TweenMax.to(container, cDurtion(fT.height), { y:-fT.height, onComplete:scrollNext, ease:Linear.easeNone }), 2);
			}
		}
		
		
		private function scrollNext():void{
			var fT:TextField = textFieldAry.shift();
			container.removeChild(fT);
			textFieldAry.push(fT);
			scrollText();
		}
		
		
		/**
		 * 计算时间速度 
		 * @param dis
		 * @return 
		 * 
		 */		
		protected function cDurtion(dis:Number):Number{
			return dis / 40;
		}
		
		private function createTextField(s:String = null):TextField{
			var f:ASFont = this.getFont(this.getPrefix() + "font");
			var t:TextField = new TextField;
			t.autoSize = "left";
			var tf:TextFormat = f.getTextFormat();
			tf.color = this.getColor(getPrefix() + "color").getRGB();
			t.defaultTextFormat = tf;
			
			if(s)
				t.text = s;
			return t;
		}
		
		override public function getPrefix():String{
			return "Info." + this.info.getClientProperty("xmlField") + ".";
		}
		
		override public function uninstallUI(c:Component):void {
			info.removeChild(container);
		}
	}
}