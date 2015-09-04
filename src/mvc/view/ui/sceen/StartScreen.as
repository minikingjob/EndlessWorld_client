package mvc.view.ui.sceen 
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.PanelScreen;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class StartScreen extends PanelScreen 
	{
		
		public function StartScreen() 
		{
			super();
			
		}
		override protected function initialize():void
        {
            super.initialize();
            this.title = "Start";
			
			this.headerFactory = function():Header
			{
				var header:Header = new Header();

				var menuButton:Button = new Button();
				menuButton.label = "Menu";
				menuButton.addEventListener( Event.TRIGGERED, menuButton_triggeredHandler );
				header.leftItems = new <DisplayObject>
				[
					menuButton
				];

				return header;
			};
			
			var loader:ImageLoader = new ImageLoader();
			loader.source = "http://d.pcs.baidu.com/thumbnail/863ec616e0cd5c56d3cd50313e54b0f8?fid=1443670122-250528-828338450625190&time=1441350000&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-%2BR0q%2F3ihiNsfnQJETTM1rcgL1Sk%3D&rt=sh&expires=2h&r=494530802&sharesign=unknown&size=c710_u500&quality=100";
			this.addChild( loader );
			
        }
		
		private function menuButton_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith( "showMenu" );
		}
	}

}