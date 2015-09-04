package xu.love.qq.geom 
{
	import flash.events.EventDispatcher;
	
	import xu.love.qq.events.SongEvent;

	[Event(name = "invalid", type = "xu.love.qq.events.SongEvent")]
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class Song extends EventDispatcher
	{
		private var name:String;
		private var url:String;
		private var lrcUrl:String;
		private var invalidURL:Boolean;
		
		public function Song(name:String, url:String, lrcUrl:String) 
		{
			this.name = name;
			this.url = url;
			this.lrcUrl = lrcUrl;
		}
		
		public function setInvalidURL(b:Boolean):void{
			invalidURL = b;
			dispatchEvent(new SongEvent(SongEvent.INVALID, this));
		}
		
		public function isInvalidURL():Boolean{
			return invalidURL;
		}
		
		public function getMp3Name():String
		{
			return name;
		}

		public function setMp3Name(value:String):void
		{
			name = value;
		}

		public function getMp3Url():String
		{
			return url;
		}

		public function setMp3Url(value:String):void
		{
			url = value;
		}

		public function getLrcUrl():String
		{
			return lrcUrl;
		}

		public function setLrcUrl(value:String):void
		{
			lrcUrl = value;
		}


	}

}