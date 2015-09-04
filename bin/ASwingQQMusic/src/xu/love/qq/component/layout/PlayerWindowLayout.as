package xu.love.qq.component.layout
{
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.EmptyLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	
	import xu.love.qq.component.board.PlayerWindow;
	import xu.love.qq.component.lookAndFeel.IMusicComponentUI;
	import xu.love.qq.component.lookAndFeel.MusicComponentUI;
	
	public class PlayerWindowLayout extends EmptyLayout
	{
		private var pw:PlayerWindow;
		
		public function PlayerWindowLayout(pw:PlayerWindow)
		{
			super();
			this.pw = pw;
		}
		
		override public function layoutContainer(target:Container) : void {
			var count:int = target.getComponentCount();
			for(var i:int = 0; i < count; i++){
				var c:Component = target.getComponent(i);
				var ui:IMusicComponentUI = c.getUI() as IMusicComponentUI;
				if(ui != null){
					var bounds:IntRectangle = ui.getRectang(ui.getPrefix() + "position");
					c.pack();
					c.setLocation(bounds.getLocation());
				}
			}
		}
		
		override public function preferredLayoutSize(target:Container) : IntDimension {
			return new IntDimension(1, 1);
		}
		
		override public function minimumLayoutSize(target:Container) : IntDimension {
			return target.getInsets().getOutsideSize();
		}
		
		override public function maximumLayoutSize(target:Container) : IntDimension {
			return IntDimension.createBigDimension();
		}
	}
}