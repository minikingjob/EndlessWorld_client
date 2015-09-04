package xu.love.qq.geom 
{
	import flash.geom.Rectangle;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntRectangle;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class MRectangle extends IntRectangle
	{
		
		public static function create(str:String, delim:String = ","):MRectangle {
			var arr:Array = str.split(delim);
			return new MRectangle(arr[0], arr[1], arr[2], arr[3]);
		}
		
		
		public function MRectangle(left:int = 0, top:int = 0, right:int = 0, bottom:int = 0) 
		{
			super(left, top, right - left, bottom - top);
		}
		
	}

}