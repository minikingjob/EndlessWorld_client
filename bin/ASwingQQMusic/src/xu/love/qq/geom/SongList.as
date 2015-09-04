package xu.love.qq.geom 
{
	import org.aswing.GeneralListCellFactory;
	import org.aswing.JList;
	import org.aswing.JScrollPane;
	import org.aswing.VectorListModel;
	import org.aswing.geom.IntRectangle;
	
	import xu.love.qq.component.board.playlistWindow.cell.SongCell;

	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class SongList extends JList
	{
		private var list:Array = [];
		private var scrollPane:JScrollPane;
		public var rect:IntRectangle;
		
		public function SongList(n:String = "黙认") 
		{
			super();
			setName(n);
			setCellFactory(new GeneralListCellFactory(SongCell));
		}
		
		public function addSong(mp3:Song):void{
			list.push(mp3);
			var model:VectorListModel = this.getModel() as VectorListModel;
			model.append(mp3);
		}
		
		public function getHolder():JScrollPane {
			if(!scrollPane){
				scrollPane = new JScrollPane(this, 0, 1);
			}
			return scrollPane;
		}
		
		public function getAll():Array{
			return list;
		}
		
	}

}