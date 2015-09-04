package xu.love.qq.events
{
	import flash.events.Event;
	
	import xu.love.qq.geom.Song;
	
	public class SongEvent extends Event
	{
		public static const INVALID:String = "invalid";
		
		public var song:Song;
		
		public function SongEvent(type:String, s:Song)
		{
			song = s;
			super(type);
		}
	}
}