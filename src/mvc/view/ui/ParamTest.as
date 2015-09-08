package mvc.view.ui 
{
	import fl.controls.Button;
	import fl.controls.ComboBox;
	import fl.controls.TextArea;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
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
		public var decodeButton:Button = new Button();
		public var resultTextArea:TextArea = new TextArea();
		
		public var webView:StageWebView = new StageWebView();
		
		private function init():void {
			var typeLabel:TextField = getLabel("cbType =  ");
			addChild(typeLabel);
			typeLabel.x = typeLabel.y = 10;
			
			addChild(typeTextArea);
			typeTextArea.x = typeLabel.x + typeLabel.textWidth;
			typeTextArea.y = 10;
			typeTextArea.width = 150;
			typeTextArea.height = 25;
			
			var uidLabel:TextField = getLabel("uid = ");
			addChild(uidLabel);
			uidLabel.x = typeTextArea.x + typeTextArea.width + 10;;
			uidLabel.y = 10;
			
			addChild(uidTextArea);
			uidTextArea.x = uidLabel.x + uidLabel.textWidth + 10;
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
			
			addChild(decodeButton);
			decodeButton.x = submitButton.x + submitButton.width + 100;
			decodeButton.y = paramTextArea.y + paramTextArea.height + 10;
			decodeButton.label = "解码";
			decodeButton.name = "decode";
			
			
			webView.viewPort = new Rectangle(10, submitButton.y + submitButton.height + 10, 800, 300);
		}
		
		private var format:TextFormat = new TextFormat();			
		private function getLabel(text:String = ""):TextField
		{
			var label:TextField = new TextField();
			label.text = text;
			format.align = "right";
			label.defaultTextFormat = format;
			return label;
		}
		
	}

}