package xu.love.qq.component
{
	import org.aswing.JButton;
	
	public class MButton extends JButton
	{
		public function MButton()
		{
			super();
		}
		
		public function setXmlField(field:String):void{
			this.putClientProperty("xmlField", field);
		}
		
		override public function getUIClassID():String {
			return "MButtonUI";
		}
	}
}