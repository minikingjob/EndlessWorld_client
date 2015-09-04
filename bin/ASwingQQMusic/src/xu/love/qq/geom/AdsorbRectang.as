package xu.love.qq.geom
{
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	
	public class AdsorbRectang extends IntRectangle
	{
		public function AdsorbRectang(inter:IntRectangle = null)
		{
			super();
			this.setRect(inter);
		}
		
		public function isAdsorb(inter:IntRectangle):Boolean{
			var rb:IntPoint = inter.rightBottom();
			var thisRb:IntPoint = rightBottom();
			var ax:Boolean = x == inter.x || x == rb.x || inter.x == thisRb.x || rb.x == thisRb.x;
			if(ax) return true;
			
			var ay:Boolean = y == inter.y || y == rb.y || inter.y == thisRb.y || rb.y == thisRb.y;
			return ay;
		}
		
		public function adsorb(inter:IntRectangle, vx:int, vy:int):IntPoint{
			var rb:IntPoint = inter.rightBottom();
			var thisRb:IntPoint = rightBottom();
			var result:IntPoint = this.getLocation();
			
			//XXX:
			if(Math.abs(x - inter.x) <= vx){
				result.x = inter.x;
			} else if(Math.abs(x - rb.x) <= vx){
				result.x = rb.x;
			} else if(Math.abs(thisRb.x - inter.x) <= vx){
				result.x = inter.x - width;
			} else if(Math.abs(thisRb.x - rb.x) <= vx){
				result.x = rb.x - width;
			}
			
			//YYYY"
			if(Math.abs(y - inter.y) <= vy){
				result.y = inter.y;
			} else if(Math.abs(y - rb.y) <= vy){
				result.y = rb.y
			} else if(Math.abs(thisRb.y - inter.y) <= vy){
				result.y = inter.y - height;
			} else if(Math.abs(thisRb.y - rb.y) <= vy){
				result.y = rb.y - height;
			}
			
			if(!result.equals(this.getLocation())){
				return result;
			}
			
			return null;
		}
	}
}