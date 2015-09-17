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
	public class LoginSceen extends PanelScreen 
	{
		public var userNameLabel:Label;
		public var passwordLabel:Label;
		public var userNameInput:AutoComplete;
		public var passwordInput:TextInput;
		public var submit:Button;
		
		private var cookieObj:Object;
		public function LoginSceen() 
		{
			super();
			
			
		}
		override protected function initialize():void
        {
			this.title = "login";
			var layout:FlowLayout = new FlowLayout();
			layout.gap = 10;
			layout.padding = 10;
			layout.horizontalAlign = FlowLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = FlowLayout.VERTICAL_ALIGN_MIDDLE;
			this.layout = layout;
			
			userNameLabel = new Label();
			userNameLabel.text = "用户名：";
			this.addChild(userNameLabel);
			
			userNameInput = new AutoComplete();
			this.addChild( userNameInput );
			
			passwordLabel = new Label();
			passwordLabel.text = "密码：";
			this.addChild(passwordLabel);
			
			passwordInput = new TextInput();
			passwordInput.displayAsPassword = true;
			this.addChild( passwordInput );
			
			submit = new Button();
			submit.label = "登录";
			this.addChild(submit);
			submit.addEventListener(Event.TRIGGERED, buttonClick);
			
			cookieObj = AppManager.cookie.get("login");
			if (cookieObj) {
				userNameInput.text = cookieObj.userName;
				passwordInput.text = cookieObj.password;
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