package xu.love.qq.component.lookAndFeel
{
	import flash.display.BitmapData;
	
	import org.aswing.JLabel;
	import org.aswing.UIDefaults;
	import org.aswing.geom.IntRectangle;
	import org.aswing.plaf.ASColorUIResource;
	import org.aswing.plaf.ASFontUIResource;
	import org.aswing.plaf.basic.BasicLookAndFeel;
	import org.aswing.skinbuilder.SkinMenuItemBackground;
	
	import xu.love.qq.component.lookAndFeel.lyricWindow.LyricUI;
	import xu.love.qq.component.lookAndFeel.playerWindow.LedUI;
	import xu.love.qq.component.lookAndFeel.playerWindow.PlayerWindowUI;
	import xu.love.qq.component.lookAndFeel.playerWindow.SongInfoUI;
	import xu.love.qq.component.lookAndFeel.playlistWindow.MPlayListWindowUI;
	import xu.love.qq.component.lookAndFeel.playlistWindow.MToolBarUI;
	import xu.love.qq.geom.MRectangle;
	import xu.love.qq.mvc.model.SkinLoaderProxy;
	
	public class MusicLookAndFeel extends BasicLookAndFeel
	{
		private var skinProxy:SkinLoaderProxy;
		
		public function MusicLookAndFeel(skinProxy:SkinLoaderProxy)
		{
			this.skinProxy = skinProxy;
			super();
		}
		
		override protected function initClassDefaults(table:UIDefaults):void {
			super.initClassDefaults(table);
			var classDefaults:Array = [
				"PlayerWindowUI", 	PlayerWindowUI, 
				"PlayListWindowUI", 	MPlayListWindowUI,
				"MiniWindowUI", 		MiniWindowUI,
				"LyricWindowUI",		MLyricWindowUI,
				"MButtonUI", 			MButtonUI,
				//splitPane
				"SplitPaneUI", 		SplitPaneUI,
				//led:
				"LedUI", 	LedUI,
				//info:
				"InfoUI", 	SongInfoUI,
				//MLabel
				"MLabelUI", 	MLabelUI,
				//slider:
				"MSliderUI",	MSliderUI,
				//togglebutton
				"MToggleButtonUI", 	MToggleButtonUI,
				//scrollbar:
				"ScrollBarUI", 		ScrollBarUI,
				//ToolBar:
				"ToolBarUI", 			MToolBarUI,
				//歌词
				"LyricUI", 			LyricUI,
				];
			
			table.putDefaults(classDefaults);
		}
		
		[Embed(source="assets/MenuItem_rolloverImage.png", scaleGridTop="11", scaleGridBottom="12", 
		scaleGridLeft="6", scaleGridRight="51")]
		private var MenuItem_rolloverImage:Class;
		
		[Embed(source="assets/Menu_bg.png", scaleGridTop="7", scaleGridBottom="150", 
		scaleGridLeft="30", scaleGridRight="40")]
		private var PopupMenu_bgImage:Class;
		
		override protected function initComponentDefaults(table:UIDefaults):void {
			super.initComponentDefaults(table);
			
			var skinXml:XML = skinProxy.getSkinXml();
			
			//菜单
			var skinDefaults:Array = [
				"MenuItem.rolloverImage", MenuItem_rolloverImage, 
				"MenuItem.pressedImage", MenuItem_rolloverImage, 
				"MenuItem.bg", SkinMenuItemBackground,
				
				"PopupMenu.bgImage", PopupMenu_bgImage, 
				"PopupMenu.bg", MPopupMenuBackground,
				"PopupMenu.opaque", false,
				"PopupMenu.border", MPopupMenuBorder,
			];
			table.putDefaults(skinDefaults);
			
			var playerWindowXml:XML = skinXml.player_window[0];
			//player window:
			skinDefaults = [
				"PlayerWindow.background", 	skinProxy.getBitmap(playerWindowXml.@image),
				//play
				"MButton.play.image", 		getBitmap(playerWindowXml.play.@image),
				"MButton.play.position", 	parseRect(playerWindowXml.play.@position),
				//pause
				"MButton.pause.image", 		getBitmap(playerWindowXml.pause.@image),
				"MButton.pause.position", 	parseRect(playerWindowXml.pause.@position),
				//next
				"MButton.next.image", 		getBitmap(playerWindowXml.next.@image),
				"MButton.next.position", 	parseRect(playerWindowXml.next.@position),
				//stop
				"MButton.stop.image", 		getBitmap(playerWindowXml.stop.@image),
				"MButton.stop.position", 	parseRect(playerWindowXml.stop.@position),
				//prev
				"MButton.prev.image", 		getBitmap(playerWindowXml.prev.@image),
				"MButton.prev.position", 	parseRect(playerWindowXml.prev.@position),
				//exit
				"MButton.exit.image", 		getBitmap(playerWindowXml.exit.@image),
				"MButton.exit.position", 	parseRect(playerWindowXml.exit.@position),
				//minimize
				"MButton.minimize.image", 		getBitmap(playerWindowXml.minimize.@image),
				"MButton.minimize.position", 	parseRect(playerWindowXml.minimize.@position),
				//minimode
				"MButton.minimode.image", 		getBitmap(playerWindowXml.minimode.@image),
				"MButton.minimode.position", 	parseRect(playerWindowXml.minimode.@position),
				
				
				"Led.normal.position", 		parseRect(playerWindowXml.led.@position),
				"Led.normal.numberImage", 	getBitmap(playerWindowXml.led.@image),
				"Led.normal.align", 			String(playerWindowXml.led.@align),
				
				"Info.normal.position", 	parseRect(playerWindowXml.info.@position),
				"Info.normal.color",		parseColor(playerWindowXml.info.@color),
				"Info.font", 				new ASFontUIResource("宋体", playerWindowXml.info.@font_size),
				
				"MLabel.stereo.position", 	parseRect(playerWindowXml.stereo.@position),
				"MLabel.stereo.align", 		playerWindowXml.stereo.@align == "right" ? JLabel.RIGHT : JLabel.LEFT,
				"MLabel.stereo.color", 		parseColor(playerWindowXml.stereo.@color),
				
				"MLabel.status.position", 	parseRect(playerWindowXml.status.@position),
				"MLabel.status.align", 		playerWindowXml.status.@align == "right" ? JLabel.RIGHT : JLabel.LEFT,
				"MLabel.status.color", 		parseColor(playerWindowXml.status.@color),
				
				"MSlider.normal.progress.position", 	parseRect(playerWindowXml.progress.@position),
				"MSlider.normal.progress.barImage", 	getBitmap(playerWindowXml.progress.@bar_image),
				"MSlider.normal.progress.thumbImage", 	getBitmap(playerWindowXml.progress.@thumb_image),
				"MSlider.normal.progress.fillImage", 	getBitmap(playerWindowXml.progress.@fill_image),
				"MSlider.normal.progress.vertical", 	String(playerWindowXml.progress.@vertical).toLocaleLowerCase() == "true",
				"MSlider.normal.volume.position", 		parseRect(playerWindowXml.volume.@position),
				"MSlider.normal.volume.barImage", 		getBitmap(playerWindowXml.volume.@bar_image),
				"MSlider.normal.volume.thumbImage", 	getBitmap(playerWindowXml.volume.@thumb_image),
				"MSlider.normal.volume.fillImage", 		getBitmap(playerWindowXml.volume.@fill_image),
				"MSlider.normal.volume.vertical", 		String(playerWindowXml.volume.@vertical).toLocaleLowerCase() == "true",
				
				"MToggleButton.normal.mute.image", 		getBitmap(playerWindowXml.mute.@image),
				"MToggleButton.normal.mute.position", 	parseRect(playerWindowXml.mute.@position),
				
			];
			table.putDefaults(skinDefaults);
			
			/*
			 * 歌曲列表窗体部分
			 * 
			 */
			var playlistXML:XML = skinXml.playlist_window[0];
			var listCfgXML:XML = skinProxy.getListXml().playlist[0];
			skinDefaults = [
				"PlayListWindow.background", 			getBitmap(playlistXML.@image),
				"PlayListWindow.position", 				parseRect(playlistXML.@position),
				"PlayListWindow.resizeRect", 			parseRect(playlistXML.@resize_rect),
				"PlayListWindow.list.position", 		parseRect(playlistXML.playlist.@position),
				"PlayListWindow.list.selectedImage", 	getBitmap(playlistXML.playlist.@selected_image),
				"PlayListWindow.list.colorText", 		parseColor(listCfgXML.@color_text),
				"PlayListWindow.list.colorHilight", 	parseColor(listCfgXML.@color_hilight),
				"PlayListWindow.list.colorBkgnd", 		parseColor(listCfgXML.@color_bkgnd),
				"PlayListWindow.list.colorBkgnd2", 		parseColor(listCfgXML.@color_bkgnd2),
				"PlayListWindow.list.colorSelect", 		parseColor(listCfgXML.@color_select),
				//close button:
				"MButton.playListWindow.close.image",		getBitmap(playlistXML.close.@image),
				"MButton.playListWindow.close.position", 	parseRect(playlistXML.close.@position),
				"MButton.playListWindow.close.align", 		String(playlistXML.close.@align),
				
				"ScrollBarUI.buttonsImage", 	getBitmap(playlistXML.scrollbar.@buttons_image),
				"ScrollBarUI.thumbImage", 	getBitmap(playlistXML.scrollbar.@thumb_image),
				"ScrollBarUI.barImage", 		getBitmap(playlistXML.scrollbar.@bar_image),
				
				"ToolBar.position",	parseRect(playlistXML.toolbar.@position),
				"ToolBar.image",		getBitmap(playlistXML.toolbar.@image),
				"ToolBar.hotImage",	getBitmap(playlistXML.toolbar.@hot_image),
				"ToolBar.align", 		playlistXML.toolbar.@align,
				];
			table.putDefaults(skinDefaults);
			
			/* 
			 *	歌词窗体部分
			 */
			var lyricWinXML:XML = skinXml.lyric_window[0];
			var lyricXML:XML = skinProxy.getLyricXML();
			
			skinDefaults = [
				"LyricWindow.background", 	getBitmap(lyricWinXML.@image),
				"LyricWindow.position", 		parseRect(lyricWinXML.@position),
				"LyricWindow.resizeRect", 	parseRect(lyricWinXML.@resize_rect),
				
				"Lyric.position", 		parseRect(lyricWinXML.lyric.@position),
				"Lyric.textColor", 		parseColor(lyricXML.lyric.@textcolor),
				"Lyric.hilightColor", 	parseColor(lyricXML.lyric.@hilightcolor),
				
				//close button:
				"MButton.lyric.close.image", 		getBitmap(lyricWinXML.close.@image),
				"MButton.lyric.close.position", 	parseRect(lyricWinXML.close.@position),
				"MButton.lyric.close.align", 		String(lyricWinXML.close.@align)
				];
			table.putDefaults(skinDefaults);
			
			var miniXML:XML = skinXml.mini_window[0];
			//mini window:
			skinDefaults = [
				"MiniWindow.image", getBitmap(miniXML.@image),
				
				"MButton.mini.play.image", 				getBitmap(miniXML.play.@image),
				"MButton.mini.play.position", 			parseRect(miniXML.play.@position),
				
				"MButton.mini.pause.image", 				getBitmap(miniXML.pause.@image),
				"MButton.mini.pause.position", 			parseRect(miniXML.pause.@position),
				
				"MButton.mini.stop.image", 				getBitmap(miniXML.stop.@image),
				"MButton.mini.stop.position", 			parseRect(miniXML.stop.@position),
				
				"MButton.mini.pause.image", 				getBitmap(miniXML.pause.@image),
				"MButton.mini.pause.position", 			parseRect(miniXML.pause.@position),
				
				"MButton.mini.next.image", 				getBitmap(miniXML.next.@image),
				"MButton.mini.next.position",			parseRect(miniXML.next.@position),
				
				"MButton.mini.prev.image", 				getBitmap(miniXML.prev.@image),
				"MButton.mini.prev.position", 			parseRect(miniXML.prev.@position),
				
				"MButton.mini.exit.image", 				getBitmap(miniXML.exit.@image),
				"MButton.mini.exit.position", 			parseRect(miniXML.exit.@position),
				
				"MButton.mini.minimode.image", 			getBitmap(miniXML.minimode.@image),
				"MButton.mini.minimode.position", 		parseRect(miniXML.minimode.@position),
				
				"MButton.mini.minimize.image", 			getBitmap(miniXML.minimize.@image),
				"MButton.mini.minimize.position", 		parseRect(miniXML.minimize.@position),
				
				"MButton.mini.lyric.image", 				getBitmap(miniXML.lyric.@image),
				"MButton.mini.lyric.position", 			parseRect(miniXML.lyric.@position),
				
				"Info.mini.position", 	parseRect(miniXML.info.@position),
				"Info.mini.color", 		parseColor(miniXML.info.@color),
				
				"Led.mini.position", 		parseRect(miniXML.led.@position),
				"Led.mini.numberImage", 	getBitmap(miniXML.led.@image),
				"Led.mini.align", 		String(miniXML.led.@align),
				
				"MSlider.mini.progress.position", 		parseRect(miniXML.progress.@position),
				"MSlider.mini.progress.barImage", 		getBitmap(miniXML.progress.@bar_image),
				"MSlider.mini.progress.thumbImage", 	getBitmap(miniXML.progress.@thumb_image),
				"MSlider.mini.progress.fillImage", 		getBitmap(miniXML.progress.@fill_image),
				"MSlider.mini.progress.vertical", 		String(miniXML.progress.@vertical).toLocaleLowerCase() == "true",
				"MSlider.mini.volume.position", 		parseRect(miniXML.volume.@position),
				"MSlider.mini.volume.barImage", 		getBitmap(miniXML.volume.@bar_image),
				"MSlider.mini.volume.thumbImage", 		getBitmap(miniXML.volume.@thumb_image),
				"MSlider.mini.volume.fillImage",		getBitmap(miniXML.volume.@fill_image),
				"MSlider.mini.volume.vertical", 		String(miniXML.volume.@vertical).toLocaleLowerCase() == "true",
				
				//静音按钮
				"MToggleButton.mini.mute.image", 		getBitmap(miniXML.mute.@image),
				"MToggleButton.mini.mute.position", 	parseRect(miniXML.mute.@position),
			];
			
			table.putDefaults(skinDefaults);
		}
		0
		private function getBitmap(fileName:String):BitmapData{
			return skinProxy.getBitmap(fileName);
		}
		
		private function parseRect(s:String):IntRectangle{
			return MRectangle.create(s);
		}
		
		private function parseColor(vStr:String):ASColorUIResource {
			var v:uint = uint("0x" + vStr.split("#").join(""));
			return new ASColorUIResource(v);
		}
	}
}