package mvc.view.ui 
{
	import feathers.controls.Drawers;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.Fade;
	import feathers.themes.BaseMetalWorksDesktopTheme;
	import feathers.themes.BaseMetalWorksMobileTheme;
	import feathers.themes.MetalWorksDesktopTheme;
	import mvc.view.ui.sceen.GroupListTest;
	import mvc.view.ui.sceen.LoginSceen;
	import mvc.view.ui.sceen.OptionsScreen;
	import mvc.view.ui.sceen.RegSceen;
	import mvc.view.ui.sceen.StartScreen;
	import starling.animation.Transitions;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class ModuleContain extends Drawers 
	{
		private var navigator:ScreenNavigator;
		public function ModuleContain() 
		{
			init();
		}
		
		public static var _instance:ModuleContain;
		public static function get instance():ModuleContain
		{
			if (!_instance)_instance = new ModuleContain();
			return _instance;
		}
		
		
		private function init():void
		{
			//new BaseMetalWorksMobileTheme();
			new MetalWorksDesktopTheme();
			
			navigator = new ScreenNavigator();
			navigator.transition = Fade.createFadeInTransition( 0.75, Transitions.EASE_IN_OUT );
			
			navigator.addScreen( "start", new ScreenNavigatorItem( StartScreen ) );
			navigator.addScreen( "options", new ScreenNavigatorItem( OptionsScreen ) );
			navigator.addScreen( "GroupList", new ScreenNavigatorItem( GroupListTest ) );
			
			navigator.addScreen( "reg", new ScreenNavigatorItem( RegSceen ) );
			navigator.addScreen( "login", new ScreenNavigatorItem( LoginSceen ) );
			
			navigator.showScreen( "reg" );
			
			this.content = navigator;
			//this.layoutData = 
		}
		
		public function changeSceen(name:String):void {
			navigator.showScreen(name);	
		}
		
		
	}

}