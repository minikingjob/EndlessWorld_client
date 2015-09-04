package xu.love.qq.component.lookAndFeel 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	
	import org.aswing.Component;
	import org.aswing.JButton;
	
	import xu.love.qq.utils.MusicUtils;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class ScrollBarUI extends DefaultTScrollBarUI
	{
		public function ScrollBarUI():void{
			super(null, null, null, null, false);
		}
		
		override public function installUI(c:Component):void {
			var pp:String = this.getPropertyPrefix();
			var buttonsImage:BitmapData = this.getBitmap(pp + "buttonsImage");
			this.incr_Asset = MusicUtils.createScrollBarButton(buttonsImage, false);
			this.decr_Asset = MusicUtils.createScrollBarButton(buttonsImage);
			this.background_Asset = new Bitmap(getBitmap(pp + "barImage"));
			
			this.thumb_Asset = new SimpleButton();
			var sour:BitmapData = this.getBitmap(pp + "thumbImage");
			thumb_Asset.upState = new Bitmap(MusicUtils.copyAndCreateBitmapData(sour, 0, 3));
			thumb_Asset.overState = new Bitmap(MusicUtils.copyAndCreateBitmapData(sour, 1, 3));
			thumb_Asset.downState = new Bitmap(MusicUtils.copyAndCreateBitmapData(sour, 2, 3));
			thumb_Asset.hitTestState = thumb_Asset.upState;
			super.installUI(c);
		}
		
		override protected function createThumbButton():void {
			this.thumbButton = new JButton;
			thumbButton.wrapSimpleButton(thumb_Asset);
			thumbButton.setSizeWH(thumb_Asset.width, thumb_Asset.height);
			thumbMC.addChild(thumbButton);
		}
		
		
		protected function getPropertyPrefix():String {
			return "ScrollBarUI.";
		}
		
		
		private function getBitmap(key:String):BitmapData{
			return getInstance(key);
		}
	}
}