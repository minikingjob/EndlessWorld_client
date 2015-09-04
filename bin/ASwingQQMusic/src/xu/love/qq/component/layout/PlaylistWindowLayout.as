package xu.love.qq.component.layout 
{
	import org.aswing.Container;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	
	import xu.love.qq.component.board.PlayListWindow;
	import xu.love.qq.component.board.playlistWindow.ToolBar;
	import xu.love.qq.component.lookAndFeel.IMusicComponentUI;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class PlaylistWindowLayout extends AlignElementsLayout
	{
		private var tool:ToolBar;
		
		public function PlaylistWindowLayout(tool:ToolBar) 
		{
			this.tool = tool;
		}
		
		override public function layoutContainer(target:Container):void 
		{
			var listWin:PlayListWindow = PlayListWindow(target);
			var ui:IMusicComponentUI = listWin.getUI() as IMusicComponentUI;
			//黙认的list显示区域范围
			var listRect:IntRectangle = ui.getRectang(ui.getPrefix() + "list.position");
			
			var oriSize:IntDimension = listWin.getOriginalSize();
			var nowSize:IntDimension = listWin.getSize();
			
			//计算实际list显示范围
			var splRet:IntRectangle = listRect.clone();
			splRet.width += nowSize.width - oriSize.width;
			splRet.height += nowSize.height - oriSize.height;
			listWin.getSplitPane().setBounds(splRet);
			
			//toolbar:
			layoutAlignElement(tool, nowSize, oriSize);
			//closebutton:
			layoutAlignElement(listWin.getCloseButton(), nowSize, oriSize);
		}
		
	}

}