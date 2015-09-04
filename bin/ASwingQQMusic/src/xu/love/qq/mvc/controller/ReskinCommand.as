package xu.love.qq.mvc.controller 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import org.aswing.JOptionPane;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import xu.love.qq.mvc.model.ConfigProxy;
	import xu.love.qq.mvc.model.SkinLoaderProxy;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class ReskinCommand extends BasicCommand
	{
		private var progressFrame:LoadProgressFrame;
		private var loader:URLLoader;
		
		public function ReskinCommand() 
		{
			progressFrame = new LoadProgressFrame(null, "加载皮肤", true);
			loader = new URLLoader;
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
		}
		
		override public function execute(notification:INotification):void 
		{
			progressFrame.pack();
			progressFrame.show();
			progressFrame.getBar().setString("开始加载");
			progressFrame.centerScreen();
			var configProxy:ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
			loader.load(new URLRequest(configProxy.getUrl(String(notification.getBody()))));
		}
		
		private function onLoadComplete(e:Event):void{
			var ba:ByteArray = loader.data;
			var configProxy:ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
			var skinProxy:SkinLoaderProxy = facade.retrieveProxy(SkinLoaderProxy.NAME) as SkinLoaderProxy;
			skinProxy.loadSkin(ba);
			progressFrame.dispose();
		}
		
		private function onLoadError(e:Event):void{
			progressFrame.dispose();
			JOptionPane.showMessageDialog("错误", "无效的皮肤，加载失败.");
		}
		
		private function onProgress(e:ProgressEvent):void{
			var p:Number = (e.bytesLoaded / e.bytesTotal) * 100;
			progressFrame.getBar().setValue(p);
			progressFrame.getBar().setString("正在加载:" + p.toFixed() + "%");
			
		}
	}

}

import org.aswing.ASFont;
import org.aswing.AsWingUtils;
import org.aswing.Insets;
import org.aswing.JFrame;
import org.aswing.JProgressBar;
import org.aswing.border.EmptyBorder;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntPoint;

/**
 * 加载进度 
 * @author tangzx
 * 
 */	
class LoadProgressFrame extends JFrame
{
	private var bar:JProgressBar;
	
	public function LoadProgressFrame(owner:*=null, title:String="", modal:Boolean=false)
	{
		super(owner, title, modal);
		
		this.setClosable(false);
		this.setResizable(false);
		
		initBar();
	}
	
	private function initBar():void{
		bar = new JProgressBar;
		bar.setFont(new ASFont("宋体", 12));
		bar.setBorder(new EmptyBorder(null, new Insets(5)));
		bar.setPreferredSize(new IntDimension(200, 30));
		this.getContentPane().append(bar);
	}
	
	public function getBar():JProgressBar{
		return bar;
	}
	
	/**
	 * 到屏幕中心 
	 * 
	 */		
	public function centerScreen():void{
		var size:IntDimension = this.getSize();
		var cp:IntPoint = AsWingUtils.getScreenCenterPosition();
		this.setLocationXY(cp.x - size.width / 2, cp.y - size.height / 2);
	}
}