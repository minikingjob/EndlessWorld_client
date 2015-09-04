package xu.love.qq.component.lookAndFeel
{
	import org.aswing.plaf.UIResource;
	import org.aswing.skinbuilder.SkinEmptyBorder;
	
	public class MPopupMenuBorder extends SkinEmptyBorder implements UIResource
	{
		public function MPopupMenuBorder(top:int=3, left:int=6, bottom:int=3, right:int=3)
		{
			super(top, left, bottom, right);
		}
	}
}