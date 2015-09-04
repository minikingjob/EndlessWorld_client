package mvc.view.ui 
{
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.data.ListCollection;
	import feathers.themes.MetalWorksDesktopTheme;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class AlertTest extends Sprite 
	{
		
		private var _button:Button;
		public function AlertTest() 
		{
			super();
			
			initUI();
		}
		
		private function initUI():void {
			new MetalWorksDesktopTheme();
			
			_button = new Button();
			addChild(_button);
			_button.label = "alertTest";
			_button.addEventListener(Event.TRIGGERED, _buttonTriggered);
		}
		
		private function _buttonTriggered(e:Event):void {
			Alert.alertFactory = function customAlertFactory():Alert
			{
				var alert:Alert = new Alert();
				alert.styleNameList.add( "custom-alert" );
				return alert;
			};
			
			var message:String = "this is a message.";
			var title:String = "message";
			var buttons:ListCollection = new ListCollection(
			[
				{ label: "OK", triggered: alertButton_triggeredHandler },
				{ label: "CANCEL", triggered: alertButton_triggeredHandler }
			]);
			//var icon:DisplayObject = new DisplayObject();
			var isModal:Boolean = true;
			var isCentered:Boolean = true;
			var alert:Alert = Alert.show(message, title, buttons, null, isModal, isCentered);
			
			alert.addEventListener( Event.CLOSE, alert_closeHandler );
		}
		
		private function alertButton_triggeredHandler(e:Event):void {
			var but:Button = e.currentTarget as Button;
			trace(but.label, "click");
		}
		
		private function alert_closeHandler(e:Event, data:Object):void {
			trace("alert_closeHandler:", data.label);
			switch(data.label) {
				case "OK":
					break;
				case "CANCEL":
					break;
			}
		}
	}

}