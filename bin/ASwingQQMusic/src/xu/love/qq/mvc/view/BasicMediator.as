package xu.love.qq.mvc.view
{
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import xu.love.qq.mvc.model.ComponentsModelProxy;
	import xu.love.qq.mvc.model.ConfigProxy;
	import xu.love.qq.mvc.model.MP3ListProxy;
	import xu.love.qq.mvc.model.MP3PlayCoreProxy;
	import xu.love.qq.mvc.model.SkinLoaderProxy;
	
	public class BasicMediator extends Mediator
	{
		public function BasicMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		protected function getCfgProxy():ConfigProxy{
			return facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
		}
		
		protected function getSkinProxy():SkinLoaderProxy{
			return facade.retrieveProxy(SkinLoaderProxy.NAME) as SkinLoaderProxy;
		}
		
		protected function getListProxy():MP3ListProxy{
			return facade.retrieveProxy(MP3ListProxy.NAME) as MP3ListProxy;
		}
		
		protected function getPlayCoreProxy():MP3PlayCoreProxy{
			return facade.retrieveProxy(MP3PlayCoreProxy.NAME) as MP3PlayCoreProxy;
		}
		
		protected function getModelProxy():ComponentsModelProxy{
			return facade.retrieveProxy(ComponentsModelProxy.NAME) as ComponentsModelProxy;
		}
	}
}