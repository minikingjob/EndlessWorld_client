package mvc.view 
{
	import app.ConstInfo;
	import com.core.AppManager;
	import com.core.handlers.Handler;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import mvc.view.ui.ParamTest;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class ParamMediator extends Mediator 
	{
		private var paramCookie:Object;
		private var paramTest:ParamTest;
		public function ParamMediator(mediatorName:String=null, viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			var stage:Stage = AppManager.stage;
			
			paramTest = new ParamTest();
			stage.addChild(paramTest);
			
			paramTest.submitButton.addEventListener(MouseEvent.CLICK, onClick);
			paramTest.decodeButton.addEventListener(MouseEvent.CLICK, onClick);
			
			paramTest.webView.stage = stage;
			
			paramCookie = AppManager.cookie.get("paramCookie");
			if (paramCookie) {
				paramTest.typeTextArea.text = paramCookie.lastType;
				var obj:Object = paramCookie[paramCookie.lastType];
				paramTest.uidTextArea.text = obj.uid;
				paramTest.paramTextArea.text = obj.jsonStr;
			}
		}
		
		private function onClick(e:MouseEvent):void {
			trace(e.target.name);
			var name:String = e.target.name;
			
			var type:int = int(paramTest.typeTextArea.text);
			var jsonStr:String = paramTest.paramTextArea.text;
			var uid:String = paramTest.uidTextArea.text;
			var obj:Object = JSON.parse(jsonStr);
			
			switch(name)
			{
				case paramTest.submitButton.name:
					obj.type = type;
					obj.uid = uid;
					var url:String = ConstInfo.nowServer + ConstInfo.cbPhp;
					AppManager.phpLoader.phpCall("POST", url, JSON.stringify(obj),
												new Handler(completeHandler, [type]),
												new Handler(errorHandler, [type]));
					paramCookie = AppManager.cookie.get("paramCookie");
					if (!paramCookie) {
						paramCookie = { };
					}
					paramCookie.lastType = type;
					paramCookie[type] = { };
					paramCookie[type].uid = uid;
					paramCookie[type].jsonStr = jsonStr;
					AppManager.cookie.put("paramCookie", paramCookie);
					
					break;
				case paramTest.decodeButton.name:
					//trace(PhpParse(resultBytes));
					break;
			}			
		}
		private var resultBytes:ByteArray;
		private function completeHandler(...param):void {	
			var str:String = param[1];
			resultBytes = new ByteArray();
			resultBytes.writeUTF(str);
   
			paramTest.webView.loadString(param[1]);
			
			
		}
		
		private function errorHandler(...param):void {	
			paramTest.webView.loadString("connect error:"+param.join("&&"));
		}
			
		
		
	}

}