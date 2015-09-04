package xu.love.qq.component.board.playlistWindow.cell
{
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.GroundDecorator;
	import org.aswing.JList;
	import org.aswing.plaf.ComponentUI;
	
	import xu.love.qq.events.SongEvent;
	import xu.love.qq.geom.Song;
	
	public class SongCell extends SongListCell implements GroundDecorator
	{
		//private var isSelect:Boolean;
		private var song:Song;
		
		public function SongCell()
		{
			super();
			//getCellComponent().setBackgroundDecorator(this);
		}
		
		override protected function getStringValue(value:*):String{
			return value.getMp3Name();
		}
		
		/*override public function setCellValue(value:*):void {
			if(song){
				song.removeEventListener(SongEvent.INVALID, onSongInvalidChange);
			}
			
			song = value;
			super.setCellValue(value);
			
			if(song){
				song.addEventListener(SongEvent.INVALID, onSongInvalidChange);
			}
			onSongInvalidChange(null);
		}
		
		private function onSongInvalidChange(e:SongEvent):void{
			
		}
		
		override public function setListCellStatus(list:JList, isSelected:Boolean, index:int):void {
			this.isSelect = isSelected;
			//设置文字格式: 序号 . 歌曲名
			getJLabel().setText(String(index + 1) + "." + song.getMp3Name());
			
			var ui:ComponentUI = list.getUI();
			var c:Component = this.getCellComponent();
			if(isSelected){
				c.setForeground(ASColor.WHITE);
			} else if(song.isInvalidURL()){
				c.setForeground(ASColor.RED);
			} else {
				c.setForeground(ui.getColor("PlayListWindow.list.colorText"));
			}
			
			//隔行的背景色不一样
			if(index % 2){
				c.setBackground(ui.getColor("PlayListWindow.list.colorBkgnd"));
			} else {
				c.setBackground(ui.getColor("PlayListWindow.list.colorBkgnd2"));
			}
		}*/
	}
}