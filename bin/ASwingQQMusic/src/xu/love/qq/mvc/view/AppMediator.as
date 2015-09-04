package xu.love.qq.mvc.view
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import org.aswing.AsWingUtils;
	import org.aswing.UIManager;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import xu.love.qq.component.board.MiniWindow;
	import xu.love.qq.component.board.QQMusicWindow;
	import xu.love.qq.component.lookAndFeel.MusicLookAndFeel;
	import xu.love.qq.mvc.AppConst;
	import xu.love.qq.mvc.view.listWin.ListWindowMediator;
	import xu.love.qq.mvc.view.lyricWin.LyricWindowMediator;
	import xu.love.qq.mvc.view.miniWin.MiniWindowMediator;
	import xu.love.qq.mvc.view.playerWin.PlayerWindowMediator;

	public class AppMediator extends BasicMediator
	{
		public static var NAME:String = "AppMediator";
		
		private var app:Main;
		private var qqMusic:QQMusicWindow;
		private var mini:MiniWindow;
		
		public function AppMediator(app:Main)
		{
			super(NAME, app);
			this.app = app;
		}
		
		override public function onRegister():void{
			//创建如键换肤菜单
			var menu:ContextMenu = new ContextMenu();
			menu.hideBuiltInItems();
			menu.customItems.push(new ContextMenuItem("----皮肤选择----", true, false));
			
			var xl:XMLList = this.getCfgProxy().xml.skins.skin;
			for each(var x:XML in xl){
				var item:ContextMenuItem = new ContextMenuItem(x.@name);
				item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onSelectSkin);
				
				menu.customItems.push(item);
			}
			app.contextMenu = menu;
		}
		
		private function onSelectSkin(e:ContextMenuEvent):void{
			var item:ContextMenuItem = e.target as ContextMenuItem;
			this.sendNotification(AppConst.SYS_RESETSKIN, item.caption);
		}
		
		override public function listNotificationInterests() : Array {
			return [AppConst.SYS_SKIN_LOAD_COMPLETE,
					AppConst.SYS_SWITCH_MINIMODE];
		}
		
		override public function handleNotification(note:INotification) : void {
			switch(note.getName()){
				case AppConst.SYS_SKIN_LOAD_COMPLETE:
					updateAllUI();
					break;
				case AppConst.SYS_SWITCH_MINIMODE:
					switchMinimode(note.getBody());
					break;
			}
		}
		
		/**
		 * 更新所有的UI外观 
		 * 
		 */		
		private function updateAllUI():void{
			if (qqMusic == null) {
				this.createQQMusic();
			}
			UIManager.setLookAndFeel(new MusicLookAndFeel(getSkinProxy()));
			AsWingUtils.updateChildrenUI(app);
			this.doFadeEffect();
			this.switchMinimode(false);
		}
		
		/**
		 * 初始化芊芊静听 
		 * 
		 */		
		private function createQQMusic():void{
			qqMusic = new QQMusicWindow;
			app.addChildAt(qqMusic, 0);
			
			//mediator
			facade.registerMediator(new PlayerWindowMediator(qqMusic.getPlayerWindow()));
			facade.registerMediator(new ListWindowMediator(qqMusic.getPlaylistWindow()));
			facade.registerMediator(new LyricWindowMediator(qqMusic.getLyricWindow(), qqMusic.getPlayerWindow()));
			
			mini = new MiniWindow;
			mini.setVisible(false);
			app.addChild(mini);
			
			facade.registerMediator(new MiniWindowMediator(mini));
		}
		
		/**
		 * 在正常与迷你模式之间切换 
		 * @param isMini 是迷你模式还是正常模式
		 * 
		 */		
		private function switchMinimode(isMini:Boolean):void{
			mini.setVisible(isMini);
			qqMusic.setVisible(!isMini);
			if(isMini){
				mini.pack();
				mini.revalidate();
			} else {
				qqMusic.pack();
				qqMusic.layoutWindows();
				qqMusic.revalidate();
			}
		}
		
		/**
		 * 切换时的淡出效果 
		 * 
		 */		
		private function doFadeEffect():void{
			var bmd:BitmapData = new BitmapData(app.stage.stageWidth, app.stage.stageHeight);
			bmd.draw(app.stage);
			var bitmap:Bitmap = new Bitmap(bmd);
			app.stage.addChild(bitmap);
			TweenLite.to(bitmap, 1, { alpha:0, onComplete:function():void{
				app.stage.removeChild(bitmap);
				bmd.dispose();
			} });
		}
	}
}