package xu.love.qq.mvc.model 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import xu.love.qq.mvc.AppConst;
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class ConfigProxy extends BasicProxy
	{
		public static const NAME:String = "ConfigProxy";
		
		
		public var xml:XML;
		
		
		public function ConfigProxy() 
		{
			super(NAME);
		}
		
		/**
		 * 获得此名字皮肤的URL地址
		 * @param	ssnToFind
		 * @return
		 */
		public function getUrl(ssnToFind:String):String {
			return xml.skins[0].skin.(@name == ssnToFind).@src
		}
		
		/*public function getUrlByName(s:String):String{
			return xml.skins.skin
		}*/
		
		public function getUrlByIndex(ind:int):String {
			return xml.skins[0].skin[ind].@src;
		}
		
		
		/**
		 * 黙认皮肤的名字
		 * @return
		 */
		public function getDefaultSkinID():String {
			return xml.skins.@default;
		}
		
	}

}