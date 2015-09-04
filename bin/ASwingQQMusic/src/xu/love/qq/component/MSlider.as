package xu.love.qq.component
{
	import org.aswing.JSlider;
	
	public class MSlider extends JSlider
	{
		public function MSlider(orient:int = 0, min:int = 0, max:int = 100, value:int = 0) {
			super(orient, min, max, value);
		}
		
		public function setXmlField(field:String):void{
			this.putClientProperty("xmlField", field);
		}
		
		override public function getUIClassID():String {
			return "MSliderUI";
		}
	}
}