package xu.love.qq.component.board.playerWindow
{
	import flash.events.MouseEvent;
	
	import org.aswing.BoundedRangeModel;
	import org.aswing.JSlider;
	
	public final class Led extends JSlider
	{
		private var model:BoundedRangeModel;
		
		public function Led(model:BoundedRangeModel = null)
		{
			super();
			setClipMasked(false);
			setName("Led");
			if(model)
				setModel(model);
			addEventListener(MouseEvent.CLICK, switchInvertModel);
		}
		
		/**
		 * 切换计时模式 
		 * @param e
		 * 
		 */		
		private function switchInvertModel(e:MouseEvent):void{
			this.setInverted(!this.getInverted());
		}
		
		public function setXmlField(s:String):void{
			this.putClientProperty("xmlField", s);
		}
		
		override public function getUIClassID():String {
			return "LedUI";
		}
	}
}