package xu.love.qq.component
{
	import org.aswing.Icon;
	import org.aswing.JToggleButton;
	
	public class MToggleButton extends JToggleButton
	{
		public function MToggleButton(text:String="", icon:Icon=null)
		{
			super(text, icon);
		}
		
		public function setXmlField(field:String):void{
			this.putClientProperty("xmlField", field);
		}
		
		override public function getUIClassID():String {
			return "MToggleButtonUI";
		}
	}
}