package
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Sprite;
	
	import org.aswing.AsWingManager;
	
	import xu.love.qq.mvc.MFacade;
	
	[SWF(width = "800", height = "600", frameRate = "30")]
	public class Main extends Sprite
	{
		private var facade:MFacade;
		
		public function Main()
		{
			AsWingManager.initAsStandard(this);
			TweenLite.defaultEase = Linear.easeNone;
			TweenPlugin.activate([TintPlugin]);
			//T.initStage(this);
			facade = new MFacade("music");
			facade.startup(this);
		}
	}
}