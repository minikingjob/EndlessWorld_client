package xu.love.qq.component.board.playlistWindow 
{
	import org.aswing.FlowLayout;
	import org.aswing.Insets;
	import org.aswing.JButton;
	import org.aswing.JMenu;
	import org.aswing.JPanel;
	import org.aswing.JPopupMenu;
	import org.aswing.JSeparator;
	import org.aswing.JSpacer;
	
	import xu.love.qq.component.lookAndFeel.playlistWindow.MToolBarUI;
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class ToolBar extends JPanel
	{
		private var _addButton:JButton;
		private var _delButton:JButton;
		private var _showListButton:JButton;
		private var _sortButton:JButton;
		private var _searchButton:JButton;
		private var _editButton:JButton;
		private var _modelButton:JButton;
		
		private var _addMenu:JPopupMenu;
		
		public function ToolBar() 
		{
			super(new FlowLayout(2, 0, 0, false));
			
			_addButton = createMenuButton("添加");
			_addButton.addActionListener(function():void { _addMenu.show(_addButton, _addButton.getMousePosition().x, 0); } );
			
			_addMenu = new JPopupMenu;
			//_addMenu.setOpaque(false);
			_addMenu.addMenuItem("文件...");
			_addMenu.addMenuItem("文件夹...");
			_addMenu.addMenuItem("本地搜索...");
			_addMenu.addMenuItem("网络搜索...");
			_addMenu.append(new JSeparator);
			
			_addMenu.addMenuItem("添加URL....");
			
			_delButton = createMenuButton("删除");
			_showListButton = createMenuButton("列表");
			_sortButton = createMenuButton("排序");
			_searchButton = createMenuButton("搜索");
			_editButton = createMenuButton("编辑");
			_modelButton = createMenuButton("模式");
		}
		
		private function createMenuButton(tip:String = null):JButton {
			var b:JButton = new JButton("");
			b.setUIElement(true);
			b.setToolTipText(tip);
			b.setMargin(new Insets);
			b.setBorder(null);
			append(b);
			return b;
		}
		
		override public function getUIClassID():String {
			return "ToolBarUI";
		}
		
		public function getAddButton():JButton { return _addButton; }
		
		public function getDelButton():JButton { return _delButton; }
		
		public function getListButton():JButton { return _showListButton; }

		public function getSortButton():JButton
		{
			return _sortButton;
		}

		public function getSearchButton():JButton
		{
			return _searchButton;
		}

		public function getEditButton():JButton
		{
			return _editButton;
		}

		public function getModelButton():JButton
		{
			return _modelButton;
		}


	}

}