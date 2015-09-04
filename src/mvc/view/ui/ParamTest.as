package mvc.view.ui 
{
	import fl.controls.Button;
	import fl.controls.ComboBox;
	import fl.controls.TextArea;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class ParamTest extends Sprite 
	{
		
		public function ParamTest() 
		{
			super();
			init();
		}
		
		
		public var typeTextArea:TextArea = new TextArea();
		public var uidTextArea:TextArea = new TextArea();
		public var typeCombox:ComboBox = new ComboBox();
		public var paramTextArea:TextArea = new TextArea();
		public var submitButton:Button = new Button();
		public var resultTextArea:TextArea = new TextArea();
		
		public var webView:StageWebView = new StageWebView();
		
		private function init():void {
			addChild(typeTextArea);
			typeTextArea.x = 10;
			typeTextArea.y = 10;
			typeTextArea.width = 150;
			typeTextArea.height = 25;
			
			addChild(uidTextArea);
			uidTextArea.x = typeTextArea.x + typeTextArea.width + 10;
			uidTextArea.y = 10;
			uidTextArea.width = 150;
			uidTextArea.height = 25;
			
			addChild(typeCombox);
			typeCombox.x = uidTextArea.x + uidTextArea.width + 20;
			typeCombox.y = uidTextArea.y;
			
			addChild(paramTextArea);
			paramTextArea.x = 10;
			paramTextArea.y = typeTextArea.y + typeTextArea.height + 10;
			paramTextArea.width = 600;
			paramTextArea.height = 200;
			paramTextArea.text = "{}";
			
			addChild(submitButton);
			submitButton.x = paramTextArea.x;
			submitButton.y = paramTextArea.y + paramTextArea.height + 10;
			submitButton.label = "提交";
			submitButton.name = "submit";
			
			webView.viewPort = new Rectangle(10, submitButton.y + submitButton.height + 10, 800, 300);
		}
		
		
		
	}

}