package xu.love.qq.component.lookAndFeel.lyricWindow
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.aswing.ASColor;
	import org.aswing.AsWingUtils;
	import org.aswing.Component;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	
	import xu.love.qq.component.board.lyricWindow.Lyric;
	import xu.love.qq.component.lookAndFeel.MusicComponentUI;
	
	public class LyricUI extends MusicComponentUI
	{
		private var lyric:Lyric;
		private var topLevelContainer:Sprite;
		private var sw:Sprite;
		private var tw:TimelineMax;
		
		public function LyricUI()
		{
			super();
		}
		
		override public function installUI(c:Component):void{
			lyric = Lyric(c);
			lyric.addStateListener(onTimeChange);
			lyric.addLrcListener(onLrcChange);
			
			sw = AsWingUtils.createSprite();
			topLevelContainer = AsWingUtils.createSprite();
			topLevelContainer.addChild(sw);
			c.addChild(topLevelContainer);
			
			onLrcChange();
		}
		
		override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void{
			super.paint(c, g, b);
			topLevelContainer.y = b.height / 2 >> 0;
			sw.x = b.width / 2 >> 0;
		}
		
		
		/**
		 * 歌词改变，重构
		 */
		private function onLrcChange(e:Event = null):void{
			clearAll();
			var all:Array = lyric.getAllLrc();
			if(!all) return;
			
			tw = new TimelineMax;
			var hilightColor:ASColor = getColor(getPrefix() + "hilightColor");
			var textColor:ASColor = getColor(getPrefix() + "textColor");
			var tf:TextFormat = new TextFormat(null, null, textColor.getRGB());
			
			for(var i:int = 0; i < all.length; i++){
				var currLrc:Object = all[i];
				var nextLrc:Object = all[i + 1] || { time:int.MAX_VALUE };
				
				var t:TextField = AsWingUtils.createLabel();
				t.defaultTextFormat = tf;
				t.text = currLrc.lrc;
				t.y = sw.height;
				t.x = -t.width / 2 >> 0;
				t.setTextFormat(tf);
				sw.addChild(t);
				
				var nextTime:Number = Number(nextLrc.time) / 1000;
				var currTime:Number = Number(currLrc.time) / 1000;
				var delay:Number = nextTime - currTime;
				var fadetime:Number = 1;
				
				tw.insert(TweenLite.to(t, fadetime, {tint:hilightColor.getRGB()}), 	currTime - fadetime);
				tw.insert(TweenLite.to(sw, delay, { y:-(t.y + t.height) }), 	currTime);
				tw.insert(TweenLite.to(t, fadetime, { removeTint:true }), 			currTime + delay - fadetime);
				
			}

			tw.pause();
			onTimeChange();
		}
		
		private function clearAll():void{
			if(tw){
				tw.kill();
			}
			
			while(sw.numChildren)
				sw.removeChildAt(0);
			sw.y = 0;
		}
		
		private function onTimeChange(e:InteractiveEvent = null):void{
			if(tw)
				tw.currentTime = lyric.getValue() / 1000;
		}
		
		override public function uninstallUI(c:Component):void{
			clearAll();
			c.removeChild(topLevelContainer);
			lyric.removeStateListener(onTimeChange);
			lyric.removeLrcListener(onLrcChange);
			super.uninstallUI(c);
		}
		
		
		override public function getPrefix():String{
			return "Lyric.";
		}
		
		override public function getMaximumSize(c:Component):IntDimension{
			return IntDimension.createBigDimension();
		}
		
		override public function getMinimumSize(c:Component):IntDimension{
			return new IntDimension;
		}
	}
}