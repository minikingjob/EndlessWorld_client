package
{
	import com.core.AppManager;
	import flash.display.Sprite;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import mvc.MyApplicationFacade;
	import mvc.view.ui.AlertTest;
	import mvc.view.ui.AutoCompleteTest;
	import mvc.view.ui.DrawsTest;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class MainEntry extends Sprite 
	{
		private var _starling:Starling;
		private var facade:MyApplicationFacade = new MyApplicationFacade();
		public function MainEntry() 
		{
			AppManager.stage = stage;
			facade.startup(this);
			
			//Starling.multitouchEnabled = true;
			//_starling = new Starling(DrawsTest, AppManager.stage, null, null, Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
			//this._starling.supportHighResolutions = true;
			//_starling.start();
		}
		
	}
	
}