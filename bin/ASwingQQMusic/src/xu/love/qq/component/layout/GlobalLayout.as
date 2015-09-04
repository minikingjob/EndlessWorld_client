package xu.love.qq.component.layout 
{
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.EmptyLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	
	import xu.love.qq.component.board.PlayerWindow;
	import xu.love.qq.component.board.QQMusicWindow;
	import xu.love.qq.component.lookAndFeel.IMusicComponentUI;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class GlobalLayout extends EmptyLayout
	{
		private var qqwin:QQMusicWindow;
		
		public function GlobalLayout(qqwin:QQMusicWindow) 
		{
			this.qqwin = qqwin;
		}
		
		override public function layoutContainer(target:Container):void 
		{
			var playerWin:PlayerWindow = qqwin.getPlayerWindow();
			playerWin.pack();
			
			var count:int = qqwin.getComponentCount();
			for(var i:int = 0; i < count; i++){
				var c:Component = qqwin.getComponent(i);
				var ui:IMusicComponentUI = c.getUI() as IMusicComponentUI;
				if(ui != null){
					var rect:IntRectangle = ui.getRectang(ui.getPrefix() + "position");
					if(rect != null)
						c.setBounds(rect);
				}
			}
		}
		
		override public function preferredLayoutSize(target:Container):IntDimension 
		{
			return new IntDimension(1280,768);
		}
		
	}

}