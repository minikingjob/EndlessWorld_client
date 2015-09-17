package mvc.view.ui.sceen 
{
	import app.ConstInfo;
	import com.core.AppManager;
	import com.core.handlers.Handler;
	import com.core.managers.CookieManager;
	import feathers.controls.AutoComplete;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import feathers.controls.TextInput;
	import feathers.layout.AnchorLayout;
	import feathers.layout.FlowLayout;
	import feathers.layout.TiledColumnsLayout;
	import mvc.PublicNotification;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class MainUiSceen extends PanelScreen 
	{
		
		private var nickNameLable:Label;
		private var userMoneyLabel:Label;
		private var gameMoneyLabel:Label;
		
		private var 
		
		private var cookieObj:Object;
		public function MainUiSceen() 
		{
			super();
			
			
		}
		override protected function initialize():void
        {
			this.title = "mainui";
			var layout:FlowLayout = new FlowLayout();
			layout.gap = 10;
			layout.padding = 10;
			layout.horizontalAlign = FlowLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = FlowLayout.VERTICAL_ALIGN_MIDDLE;
			this.layout = layout;
			
			cookieObj = AppManager.cookie.get("mainui");
			if (cookieObj) {
			}

		}
		
		private function buttonClick(e:Event):void
		{
			var but:Button = e.target as Button;
			switch(but.label)
			{
				case submit.label:
					if (!cookieObj) cookieObj = { };
					cookieObj.userName = userNameInput.text;
					cookieObj.password = passwordInput.text;
					AppManager.cookie.put("login", cookieObj);
					
					var obj:Object = { };
					obj.username = userNameInput.text;
					obj.pwd = passwordInput.text;
					var url:String = ConstInfo.php_login;
					AppManager.phpLoader.phpCall("POST", url, JSON.stringify(obj),
												new Handler(completeHandler, [url]),
												new Handler(errorHandler, [url]));
					break;
			}
		}
		
		private function completeHandler(...param):void {	
			trace(param);
			
			var str:String = param[1];
			
			AppManager.facade.sendNotification(PublicNotification.LOGIN_RESULT, str);
			
		}
		
		private function errorHandler(...param):void {	
			trace("connect error:"+param.join("&&"));
		}
			
		
	}

}