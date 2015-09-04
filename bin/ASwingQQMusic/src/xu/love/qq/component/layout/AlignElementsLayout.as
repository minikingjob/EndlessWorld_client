package xu.love.qq.component.layout
{
	import org.aswing.Component;
	import org.aswing.EmptyLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	
	import xu.love.qq.component.lookAndFeel.IMusicComponentUI;
	
	public class AlignElementsLayout extends EmptyLayout
	{
		public function AlignElementsLayout()
		{
			super();
		}
		
		/**
		 * 布局有对齐方式的元件 
		 * 对齐方式有 left+right+top+bottom
		 * @param c 元件
		 * @param nowSize 当前容器大小
		 * @param oriSize 原始容器大小
		 * 
		 */		
		protected function layoutAlignElement(c:Component, nowSize:IntDimension, oriSize:IntDimension):void{
			if(c.getUI() is IMusicComponentUI){
				var ui:IMusicComponentUI = c.getUI() as IMusicComponentUI;
				
				var ret:IntRectangle = ui.getRectang(ui.getPrefix() + "position");
				var align:String = ui.getInstance(ui.getPrefix() + "align")||"";
				var bouns:IntRectangle = ret.clone();
				//bouns.setSize(c.getPreferredSize());
				//---------------------垂直方向--------------------------
				//底对齐
				if (align.indexOf("bottom") != -1) {
					bouns.move(0, nowSize.height - oriSize.height);
				}
				//上对齐不作处理即可
				
				
				//---------------------水平方向--------------------------
				//居中对齐
				if(align.indexOf("center") != -1){
					bouns.move((nowSize.width - oriSize.width) / 2, 0);
				}
				//右对齐
				else if (align.indexOf("right") != -1) {
					bouns.move(nowSize.width - oriSize.width, 0);
				}
				
				//set bounds
				c.pack();
				c.setLocation(bouns.getLocation());
			}
		}
	}
}