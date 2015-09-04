package xu.love.qq.mvc.model
{
	import org.aswing.ButtonModel;
	import org.aswing.DefaultButtonModel;
	import org.aswing.ToggleButtonModel;
	
	import xu.love.qq.component.board.playerWindow.SongInfoModel;
	
	/**
	 * PlayerWindow 和 MiniWindow 共用一套 Model 
	 * @author tangzx
	 * 
	 */	
	public class ComponentsModelProxy extends BasicProxy
	{
		public static const NAME:String = "ComponentsModelProxy";
		
		private var playModel:ButtonModel = new DefaultButtonModel;
		private var pauseModel:ButtonModel = new DefaultButtonModel;
		private var stopModel:ButtonModel = new DefaultButtonModel;
		private var nextModel:ButtonModel = new DefaultButtonModel;
		private var prevModel:ButtonModel = new DefaultButtonModel;
		private var muteModel:ButtonModel = new ToggleButtonModel;
		
		private var infoModel:SongInfoModel = new SongInfoModel;
		
		public function ComponentsModelProxy()
		{
			super(NAME);
		}
		
		public function getPlayModel():ButtonModel{
			return playModel;
		}
		
		public function getPauseModel():ButtonModel{
			return pauseModel;
		}
		
		public function getStopModel():ButtonModel{
			return stopModel;
		}
		
		public function getNextModel():ButtonModel{
			return nextModel;
		}
		
		public function getPrevModel():ButtonModel{
			return prevModel;
		}
		
		public function getMuteModel():ButtonModel{
			return muteModel;
		}
		
		public function getSongInfoModel():SongInfoModel{
			return infoModel;
		}
	}
}