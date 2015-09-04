package xu.love.qq.component.board.playerWindow
{
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.UIManager;
	import org.aswing.event.InteractiveEvent;
	
	public class SongInfo extends Component
	{
		private var model:SongInfoModel;
		
		public function SongInfo()
		{
			super();
			this.setModel(new SongInfoModel);
		}
		
		public function getMessages():Array{
			return model.getMessages();
		}
		
		public function setMessages(ms:Array, programmatic:Boolean = false):void{
			model.setMessages(ms, programmatic);
		}
		
		public function setModel(m:SongInfoModel):void{
			if(model){
				model.removeStateListener(onModelStateChange);
			}
			model = m;
			if(model){
				model.addStateListener(onModelStateChange);
			}
		}
		
		private function onModelStateChange(e:InteractiveEvent):void{
			this.dispatchEvent(e);
			this.repaint();
		}
		
		public function setXmlField(s:String):void{
			this.putClientProperty("xmlField", s);
		}
		
		override public function updateUI():void {
			this.setUI(UIManager.getUI(this));
		}
		
		override public function getUIClassID():String {
			return "InfoUI";
		}
	}
}