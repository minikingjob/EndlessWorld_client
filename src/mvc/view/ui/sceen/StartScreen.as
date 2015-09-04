package mvc.view.ui.sceen 
{
	import feathers.controls.Button;
	import feathers.controls.Header;
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
        }
		
		private function menuButton_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith( "showMenu" );
		}
	}

}