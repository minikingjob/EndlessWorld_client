package xu.love.qq.component.lookAndFeel
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.aswing.AsWingManager;
	import org.aswing.AssetBackground;
	import org.aswing.Component;
	import org.aswing.GroundDecorator;
	import org.aswing.JButton;
	import org.aswing.JScrollBar;
	import org.aswing.event.AWEvent;
	import org.aswing.event.ReleaseEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.plaf.BaseComponentUI;
	
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class DefaultTScrollBarUI extends BaseComponentUI
	{
		protected var incr_Asset:SimpleButton;
		protected var decr_Asset:SimpleButton;
		protected var thumb_Asset:SimpleButton;
		protected var background_Asset:DisplayObject;
		
		protected var incrButton:JButton;
		protected var decrButton:JButton;
		protected var thumbButton:JButton;
		protected var thumbMC:Sprite;
		protected var trackMC:Sprite;
		protected var background:GroundDecorator;
		
		protected var isDragging:Boolean;
		protected var minimumThumbLength:int = 20;
		protected var scrollBar:JScrollBar;
		protected var scrollBarWidth:int = 14;
		protected var scrollBarHeight:int;
		protected var isScaleThumb:Boolean;
		protected var offset:int;
		
		public function DefaultTScrollBarUI(incr:SimpleButton, decr:SimpleButton, thumb:SimpleButton, bg:DisplayObject, scale:Boolean = true, offset:int = 1)
		{
			incr_Asset = incr;
			decr_Asset = decr;
			thumb_Asset = thumb;
			background_Asset = bg;
			isScaleThumb = scale;
			this.offset = offset;
		}
		
		override public function installUI(c:Component):void 
		{
			scrollBar = JScrollBar(c);
			installComponents();
			installListeners();
			__adjustChanged(null);
		}
		
		protected function installComponents():void
		{
			if (background_Asset) {
				scrollBarWidth = background_Asset.width;
				scrollBarHeight = background_Asset.height;
				background = new AssetBackground(background_Asset);
				scrollBar.setBackgroundDecorator(background);
			}
			
			trackMC = new Sprite;
			/*trackMC.graphics.beginFill(0);
			trackMC.graphics.drawRect(0, 0, 20, 20);
			trackMC.graphics.endFill();*/
			scrollBar.addChild(trackMC);
			
			//buttons
			createArrowButtons();
			
			thumbMC = new Sprite;
			//thumb buttons
			createThumbButton();
			
			scrollBar.addChild(thumbMC);
		}
		
		protected function installListeners():void
		{
			scrollBar.addStateListener(__adjustChanged);
			scrollBar.addEventListener(MouseEvent.MOUSE_WHEEL,	__onMouseWheel);
			
			trackMC.addEventListener(MouseEvent.MOUSE_DOWN,	__onTrackMouseDown);
			
			thumbMC.addEventListener(MouseEvent.MOUSE_DOWN,	__onThumbPress);
			thumbMC.addEventListener(ReleaseEvent.RELEASE,	__onThumbRelease);
			
			decrButton.addActionListener(__decrAction);
			incrButton.addActionListener(__incrAction);
		}
		
		override public function uninstallUI(c:Component):void 
		{
			uninstalListenrs();
			uninstallComponents();
			scrollBar = null;
		}
		
		protected function uninstallComponents():void
		{
			if (background) {
				scrollBar.setBackgroundDecorator(null);
			}
			
			scrollBar.removeChild(trackMC);
			scrollBar.removeChild(thumbMC);
			scrollBar.removeChild(incrButton);
			scrollBar.removeChild(decrButton);
		}
		
		protected function uninstalListenrs():void
		{
			scrollBar.removeStateListener(__adjustChanged);
			scrollBar.removeEventListener(MouseEvent.MOUSE_WHEEL,	__onMouseWheel);
		}
		
		override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void 
		{
			layoutScrollBar(b);
			trackMC.width = b.width;
			trackMC.height = b.height;
			__adjustChanged(null);
		}
		
		/**
		 * 是否是垂直的滚动条
		 * @return
		 */
		protected function isVertical():Boolean{
			return scrollBar.getOrientation() == JScrollBar.VERTICAL;
		}
		
		override public function getPreferredSize(c:Component):IntDimension 
		{
			var w:int;
			var h:int;
			if (isVertical()) {
				w = scrollBarWidth;
				h = scrollBarWidth * 2;
			} else {
				h = scrollBarHeight;
				w = scrollBarHeight * 2;
			}
			return scrollBar.getInsets().getOutsideSize(new IntDimension(w, h));
		}
		
		override public function getMaximumSize(c:Component):IntDimension 
		{
			return IntDimension.createBigDimension();
		}
		
		override public function getMinimumSize(c:Component):IntDimension 
		{
			return getPreferredSize(c);
		}
		
		
		protected function createArrowButtons():void {
			incrButton = wrapSimleButton(incr_Asset);
			scrollBar.addChild(incrButton);
			decrButton = wrapSimleButton(decr_Asset);
			scrollBar.addChild(decrButton);
		}
		
		
		protected function createThumbButton():void {
			thumbButton = new JButton;
			thumbButton.setBackgroundDecorator(new SimpleButtonBackground(thumb_Asset));
			thumbButton.setSizeWH(thumb_Asset.width, thumb_Asset.height);
			thumbMC.addChild(thumbButton);
		}
		
		private function wrapSimleButton(button:SimpleButton):JButton {
			button = button || new SimpleButton;
			var j:JButton = new JButton;
			j.setBackgroundDecorator(new SimpleButtonBackground(button));
			j.setSizeWH(button.width, button.height);
			j.setUIElement(true);
			return j;
		}
		
		
		/**
		 * layout 布局
		 */
		public function layoutScrollBar(b:IntRectangle):void {
			if (isVertical())
				layoutVScrollBar(b);
			else
				layoutHScrollBar(b);
		}
		
		
		protected function layoutHScrollBar(b:IntRectangle):void {
			incrButton.setX(b.x + b.width - decrButton.getWidth());
		}
		
		protected function layoutVScrollBar(b:IntRectangle):void {
			incrButton.setY(b.y + b.height - decrButton.getHeight());
		}
		
		
		protected function getTrackRect():IntRectangle {
			var b:IntRectangle = new IntRectangle;
			if (isVertical()) {
				b.y = decrButton.getY() + decrButton.getHeight() + offset;
				b.height = incrButton.getY() - b.y - offset;
			} else {
				b.x = decrButton.getX() + decrButton.getWidth() + offset;
				b.width = incrButton.getX() - b.x - offset;
			}
			return b;
		}
		
		
		/**
		 * 获取滑动范围
		 * @return
		 */
		protected function getDragRect():IntRectangle {
			var b:IntRectangle = getTrackRect();
			if (isVertical()) {
				b.height -= thumbButton.getHeight();
			} else {
				b.width -= thumbButton.getWidth();
			}
			return b;
		}
		
		/**
		 * 获取滑块范围
		 * @return
		 */
		protected function getThumbRect():IntRectangle {
			return new IntRectangle(thumbMC.x, thumbMC.y, thumbMC.width, thumbMC.height);
		}
		
		/**
		 * 设置滑块范围
		 * @param	rect
		 */
		protected function paintThumb():void {
			if (!scrollBar.isEnabled()) {
				thumbMC.visible = false;
				return;
			}
			thumbMC.visible = true;
			if(isScaleThumb)
			{
				resizeThumb();
			}
			var v:int = scrollBar.getMaximum() - scrollBar.getVisibleAmount();
			var p:Number = scrollBar.getValue() / v;
			var dB:IntRectangle = getDragRect();
			var tB:IntRectangle = getThumbRect();
			if (isVertical()) {
				thumbMC.y = p * dB.height + dB.y >> 0;
			} else {
				thumbMC.x = p * dB.width + dB.x >> 0;
			}
			
		}
		
		protected function resizeThumb():void {
			//set size.
			var p:Number = scrollBar.getVisibleAmount() / scrollBar.getMaximum();
			var len:int = isVertical() ? getTrackRect().height : getTrackRect().width;
			
			thumbMC.visible = p < 1 && len > minimumThumbLength;
			var h:int = Math.max(minimumThumbLength, len * p);
			
			if (isVertical()) {
				thumbButton.setHeight(h);
			} else {
				thumbButton.setWidth(h);
			}
			
		}
		
		protected function calculateValue():int {
			var dB:IntRectangle = getDragRect();
			var tB:IntRectangle = getThumbRect();
			var p:Number;
			if (isVertical()) {
				p = (tB.y - dB.y) / (dB.height);
			} else {
				p = (tB.x - dB.x) / dB.width;
			}
			var v:int = scrollBar.getMaximum() - scrollBar.getVisibleAmount();
			return p * v;
		}
		
		private function __adjustChanged(e:Event):void {
			if(!isDragging)
				paintThumb();
		}
		
		private function __onMouseWheel(e:MouseEvent):void 
		{	
			if (!scrollBar.isEnabled()) {
				return;
			}
			scrollBar.setValue(scrollBar.getValue() - e.delta * scrollBar.getUnitIncrement(), false);
		}
		
		/**
		 * 点击滑道
		 * @param	e
		 */
		private function __onTrackMouseDown(e:MouseEvent):void {
			var clickedTrackLen:int = 0;
			var trackRect:IntRectangle = getTrackRect();
			if (isVertical()) {
				//trace(scrollBar.mouseY , trackRect);
				clickedTrackLen = scrollBar.mouseY - trackRect.y;
			} else {
				clickedTrackLen = trackMC.x - trackRect.x;
			}
			trace(scrollBar.getMaximum() * (clickedTrackLen / trackRect.height));
			scrollBar.setValue(scrollBar.getMaximum() * (clickedTrackLen / trackRect.height));
		}
		
		private function __onThumbPress(e:MouseEvent):void 
		{
			isDragging = true;
			thumbMC.startDrag(false, getDragRect().toRectangle());
			thumbMC.stage.addEventListener(MouseEvent.MOUSE_UP,	__onThumbRelease);
			thumbMC.stage.addEventListener(MouseEvent.MOUSE_MOVE,	__onThumbMove);
		}
		
		private function __onThumbMove(e:MouseEvent):void 
		{
			scrollBar.setValue(calculateValue());
			e.updateAfterEvent();
		}
		
		private function __onThumbRelease(e:MouseEvent):void 
		{
			thumbMC.stopDrag();
			AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_UP,	__onThumbRelease);
			AsWingManager.getStage().removeEventListener(MouseEvent.MOUSE_MOVE,	__onThumbMove);
			isDragging = false;
		}
		
		private function __incrAction(e:AWEvent):void
		{
			scrollBar.setValue(scrollBar.getValue() + scrollBar.getUnitIncrement(), false);
		}
		
		private function __decrAction(e:AWEvent):void
		{
			scrollBar.setValue(scrollBar.getValue() - scrollBar.getUnitIncrement(), false);
		}
	}

}