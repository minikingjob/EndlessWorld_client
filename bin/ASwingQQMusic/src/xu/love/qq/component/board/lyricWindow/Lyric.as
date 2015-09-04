package xu.love.qq.component.board.lyricWindow
{
	import flash.events.Event;
	
	import org.aswing.JSlider;
	
	import xu.love.qq.geom.Song;
	
	public class Lyric extends JSlider
	{
		private var model:LyricModel;
		
		public function Lyric()
		{
			this.setLrcModel(new LyricModel);
		}
		
		
		public function loadLrc(s:Song):void{
			model.loadLrc(s);
		}
		
		public function getAllLrc():Array{
			return model.getLrc();
		}
		
		public function setLrcModel(m:LyricModel):void{
			if(model){
				model.removeStateListener(onLrcChange);
			}
			model = m;
			if(model){
				model.addStateListener(onLrcChange);
			}
		}
		
		private function onLrcChange(e:Event):void{
			this.dispatchEvent(e);
		}
		
		public function addLrcListener(listener:Function):void{
			model.addStateListener(listener);
		}
		
		public function removeLrcListener(listener:Function):void{
			model.removeStateListener(listener);
		}
		
		override public function getUIClassID():String{
			return "LyricUI";
		}
	}
}