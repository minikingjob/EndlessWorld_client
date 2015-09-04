package xu.love.qq.component.lookAndFeel
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	
	import org.aswing.AbstractButton;
	import org.aswing.ButtonModel;
	import org.aswing.Component;
	import org.aswing.GroundDecorator;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.plaf.UIResource;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class SimpleButtonBackground implements GroundDecorator, UIResource
	{	
		private static var disabledFilters:Array;
		private static var eabledFilters:Array = [];
		
		protected var mc:Sprite;
		private var button:SimpleButton;
		public function SimpleButtonBackground(button:SimpleButton) 
		{
			mc = new Sprite;
			this.button = button;
			if(disabledFilters == null){
				var cmatrix:Array = [0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
				disabledFilters = [new ColorMatrixFilter(cmatrix)];			
			}
		}
		
		/* INTERFACE org.aswing.GroundDecorator */
		
		public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):void
		{
			var b:AbstractButton = c as AbstractButton;
			bounds = bounds.clone();
			if (b == null) return;
			var model:ButtonModel = b.getModel();
	    	var isPressing:Boolean = model.isArmed() || model.isSelected() || !b.isEnabled();
			
			clearMc();
			setEnabledState(c.isEnabled(), bounds);
			if(c.isEnabled()){
				if (isPressing) {
					setDownState(bounds);
				}else if (model.isRollOver()) {
					setOverState(bounds);
				}else {
					setUpState(bounds);
				}
			}
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return mc;
		}
		
		private function clearMc():void {
			while (mc.numChildren) mc.removeChildAt(0);
		}
		
		protected function setEnabledState(enabled:Boolean, b:IntRectangle):void
		{
			if(!enabled){
				setUpState(b);
			}
			mc.filters = enabled ? eabledFilters : disabledFilters;
		}
		
		protected function setDownState(b:IntRectangle):DisplayObject {
			return mc.addChild(button.downState);
		}
		
		protected function setOverState(b:IntRectangle):DisplayObject {
			return mc.addChild(button.overState);
		}
		
		protected function setUpState(b:IntRectangle):DisplayObject {
			return mc.addChild(button.upState);
		}
		
	}

}