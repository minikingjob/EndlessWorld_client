package xu.love.qq.component.layout
{
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.EmptyLayout;
	import org.aswing.geom.IntRectangle;
	
	import xu.love.qq.component.lookAndFeel.IMusicComponentUI;
	
	public class MiniWindowLayout extends EmptyLayout
	{
		public function MiniWindowLayout()
		{
			super();
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
	}
}