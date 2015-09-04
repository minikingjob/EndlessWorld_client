package xu.love.qq.component
{
	import org.aswing.ASColor;
	import org.aswing.Icon;
	import org.aswing.JLabel;
	
	public class MLabel extends JLabel
	{
		public function MLabel(text:String="", icon:Icon=null, horizontalAlignment:int=0)
		{
			super(text, icon, horizontalAlignment);
			setClipMasked(false);
		}
		
		public function setXmlField(field:String):void{
			this.putClientProperty("xmlField", field);
		}
		
		override public function getUIClassID():String {
			return "MLabelUI";
		}
	}
}