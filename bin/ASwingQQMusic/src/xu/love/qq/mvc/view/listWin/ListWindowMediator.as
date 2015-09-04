package xu.love.qq.mvc.view.listWin
{
	import xu.love.qq.component.board.PlayListWindow;
	import xu.love.qq.mvc.view.BasicMediator;
	
	public class ListWindowMediator extends BasicMediator
	{
		public static const NAME:String = "ListWindowMediator";
		
		private var listWin:PlayListWindow;
		
		public function ListWindowMediator(win:PlayListWindow)
		{
			super(NAME);
			listWin = win;
		}
		
		override public function onRegister():void{
			facade.registerMediator(new SongListMediator(listWin));
		}
	}
}