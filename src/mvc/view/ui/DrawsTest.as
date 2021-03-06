package mvc.view.ui 
{
	import feathers.controls.AutoComplete;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Drawers;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.data.ListCollection;
	import feathers.data.LocalAutoCompleteSource;
	import feathers.data.URLAutoCompleteSource;
	import feathers.themes.MetalWorksDesktopTheme;
	import flash.display.BitmapData;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import mvc.view.ui.sceen.GroupListTest;
	import mvc.view.ui.sceen.OptionsScreen;
	import mvc.view.ui.sceen.StartScreen;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class DrawsTest extends Sprite 
	{
		private var navigator:ScreenNavigator;
		private var list:List;
		private var drawers:Drawers;
		public function DrawsTest() 
		{
			super();
			
			initUI();
		}
		
		private function initUI():void {
			new MetalWorksDesktopTheme();
			
			drawers = new Drawers();
			this.addChild( drawers );
			
			navigator = new ScreenNavigator();
			drawers.content = navigator;
			
			navigator.addScreen( "start", new ScreenNavigatorItem( StartScreen ) );
			navigator.addScreen( "options", new ScreenNavigatorItem( OptionsScreen ) );
			navigator.addScreen( "GroupList", new ScreenNavigatorItem( GroupListTest ) );
			navigator.showScreen( "start" );
			
			list = new List();
			list.dataProvider = new ListCollection(
			[
				{ screen: "start", label: "Start" },
				{ screen: "options", label: "Options" },
				{ screen: "GroupList", label: "GroupList" },
			]);
			list.selectedIndex = 0;
			list.addEventListener( Event.CHANGE, list_changeHandler );
			
			drawers.leftDrawer = list;
			
			drawers.leftDrawerToggleEventType = "showMenu";
			
			drawers.leftDrawerDockMode = Drawers.DOCK_MODE_BOTH;
		}
		
		
		private function list_changeHandler(e:Event):void {
			var screen:String = list.selectedItem.screen;
			navigator.showScreen( screen );
			drawers.toggleLeftDrawer();
		}
		
		private function button_triggeredHandler( event:Event ):void
		{
			
			var bmd:BitmapData = new BitmapData(100, 50, true, 0xAAFFAA00);
			var myTexture:Texture = Texture.fromBitmapData(bmd);
			
			var button:Button = Button( event.currentTarget );
			var content:Image = new Image( myTexture );
			var callout:Callout = Callout.show( content, button );
		}
		
		
		
	}

}