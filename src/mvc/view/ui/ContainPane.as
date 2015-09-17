package mvc.view.ui 
{
	import com.core.AppManager;
	import mvc.view.ParamMediator;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class ContainPane extends Sprite 
	{
		
		public function ContainPane() 
		{
			super();
			
			init();
		}
		
		private function init():void {
			//addChild(ModuleContain.instance);
			AppManager.facade.registerMediator(new ParamMediator());
		}
		
	}

}