package xu.love.qq.component.board 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.aswing.JPanel;
	import org.aswing.LayoutManager;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	
	import xu.love.qq.geom.AdsorbRectang;
	
	/**
	 * ...
	 * @author tangzx
	 */
	public class AbstractBoard extends JPanel
	{
		protected static var panes:Array = [];
		
		protected var originalSize:IntDimension;
		private var backgroundChild:DisplayObject;
		private var backgroundInteract:InteractiveObject;
		
		public function AbstractBoard(layout:LayoutManager = null) 
		{
			super(layout);
			panes.push(this);
			this.mouseChildren = true;
		}
		
		
		protected var startDragLocalPoint:IntPoint;
		protected var startDragParentPoint:IntPoint;
		
		/**
		 * 开始拖 
		 * @param e
		 * 
		 */		
		protected function checkStartDrag(e:MouseEvent):void{
			if(getParent())
				getParent().bringToTop(this);
			
			startDragLocalPoint = getLocation();
			startDragParentPoint = new IntPoint(e.stageX, e.stageY);//getParent().getMousePosition();
			stage.addEventListener(MouseEvent.MOUSE_UP, 	checkStopDrag);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,	checkMove);
		}
		
		/**
		 * 拖动过程中 
		 * @param e
		 * 
		 */		
		protected function checkMove(e:MouseEvent):void{
			var parentNowPoint:IntPoint = new IntPoint(e.stageX, e.stageY);//getParent().getMousePosition();
			var localNowPoint:IntPoint = startDragLocalPoint.clone();
			var localRect:IntRectangle = new IntRectangle;
			
			localNowPoint.move(parentNowPoint.x - startDragParentPoint.x, parentNowPoint.y - startDragParentPoint.y);
			localRect.setLocation(localNowPoint);
			localRect.setSize(getSize());
			
			/*var adso:AdsorbRectang = new AdsorbRectang(localRect);
			for each(var pane:AbstractBoard in panes){
				if(pane != this){
					var r:IntPoint = adso.adsorb(pane.getBoundsRect(), 10, 10);
					if(r){
						if(r.x != 0) localNowPoint.x = r.x;
						if(r.y != 0) localNowPoint.y = r.y;
						break;
					}
				}
			}*/
			
			this.setLocation(localNowPoint);
			e.updateAfterEvent();
		}
		
		/**
		 * 停止拖动 
		 * @param e
		 * 
		 */		
		protected function checkStopDrag(e:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP, checkStopDrag);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,	checkMove);
		}
		
		override protected function setBackgroundChild(child:DisplayObject=null):void{
			if(child != backgroundChild){
				if(backgroundChild){
					removeChild(backgroundInteract);
					backgroundInteract = null;
				}
				
				backgroundChild = child;
				
				if(backgroundChild){
					if(backgroundChild is InteractiveObject){
						backgroundInteract = backgroundChild as InteractiveObject;
					} else {
						var s:Sprite = new Sprite;
						s.addChild(backgroundChild);
						backgroundInteract = s;
					}
					backgroundInteract.addEventListener(MouseEvent.MOUSE_DOWN, checkStartDrag);
					addChildAt(backgroundInteract, 0);
				}
			}
		}
		
		
		override protected function getBackgroundChild():DisplayObject {
			return backgroundChild;
		}
		
		
		/**
		 * 初始大小 
		 * @return 
		 * 
		 */		
		public function getOriginalSize():IntDimension {
			return originalSize;
		}
		
		public function setOriginalSize(size:IntDimension):void {
			originalSize = size;
		}
		
		
		public function getBoundsRect():IntRectangle{
			return new IntRectangle(getX(), getY(), getWidth(), getHeight());
		}
		
	}

}