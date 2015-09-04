package xu.love.qq.mvc.controller 
{
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import xu.love.qq.mvc.model.*;
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class BasicCommand extends SimpleCommand
	{
		
		public function BasicCommand() 
		{
			
		}
		
		public function getSkinProxy():SkinLoaderProxy {
			return facade.retrieveProxy(SkinLoaderProxy.NAME) as SkinLoaderProxy;
		}
		
		
		public function getConfigProxy():ConfigProxy {
			return facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
		}
		
		
		public function getListProxy():MP3ListProxy {
			return facade.retrieveProxy(MP3ListProxy.NAME) as MP3ListProxy;
		}
		
		
		public function getMp3CoreProxy():MP3PlayCoreProxy {
			return facade.retrieveProxy(MP3PlayCoreProxy.NAME) as MP3PlayCoreProxy;
		}
		
	}

}