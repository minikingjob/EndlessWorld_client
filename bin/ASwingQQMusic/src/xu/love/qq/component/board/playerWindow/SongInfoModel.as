package xu.love.qq.component.board.playerWindow
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.aswing.event.InteractiveEvent;
	
	public class SongInfoModel extends EventDispatcher
	{
		private var msg:Array = ["===千千静听===", "===Powered By Tangzx===", "===2010.8.22==="];

		public function SongInfoModel()
		{
		}
		
		public function setMessages(msg:Array, programmatic:Boolean = false):void{
			this.msg = msg;
			this.dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, programmatic));
		}
		
		public function getMessages():Array{
			return msg;
		}
		
		public function addStateListener(listener:Function):void{
			this.addEventListener(InteractiveEvent.STATE_CHANGED, listener);
		}
		
		public function removeStateListener(listener:Function):void{
			this.removeEventListener(InteractiveEvent.STATE_CHANGED, listener);
		}
	}
}