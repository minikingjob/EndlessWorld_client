package mvc.view.ui.sceen 
{
	import feathers.controls.GroupedList;
	import feathers.controls.PanelScreen;
	import feathers.data.HierarchicalCollection;
	import feathers.layout.HorizontalLayout;
	import flash.display.BitmapData;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class GroupListTest extends PanelScreen 
	{
		
		public function GroupListTest() 
		{
			super();
			initUI();
		}
		
		private function initUI():void {
			var list:GroupedList = new GroupedList();
			list.width = 250;
			list.height = 300;
			this.addChild( list );
			var redbmd:BitmapData = new BitmapData(100, 50, true, 0xAAFF0000);
			var greenbmd:BitmapData = new BitmapData(100, 50, true, 0xAA00FF00);
			var bluebmd:BitmapData = new BitmapData(100, 50, true, 0xAA0000FF);
			var textrueRed:Texture = Texture.fromBitmapData(redbmd);
			var textrueGreen:Texture = Texture.fromBitmapData(greenbmd);
			var textrueBlue:Texture = Texture.fromBitmapData(greenbmd);
			
			var groceryList:HierarchicalCollection = new HierarchicalCollection(
			[
				{
					header: { text: "Dairy" },
					children:
					[
						{ text: "red", thumbnail: textrueRed },
						{ text: "green", thumbnail: textrueGreen },
					]
				},
				{
					header: { text: "Bakery" },
					children:
					[
						{ text: "blue", thumbnail: textrueBlue },
					]
				},
				{
					header: { text: "Produce" },
					children:
					[
						{ text: "red", thumbnail: textrueRed },
						{ text: "green", thumbnail: textrueGreen },
						{ text: "blue", thumbnail: textrueBlue},
					]
				},
			]);
			list.dataProvider = groceryList;
			list.itemRendererProperties.labelField = "text";
			list.itemRendererProperties.iconSourceField = "thumbnail";
			list.headerField = "header";
			list.headerRendererProperties.contentLabelField  = "text";
			list.addEventListener( Event.CHANGE, list_changeHandler );
			
			//var layout:HorizontalLayout = new HorizontalLayout();
			//layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_JUSTIFY;
			//layout.gap = 10;
			//layout.paddingTop = layout.paddingRight = layout.paddingBottom = layout.paddingLeft = 15;				
			//list.layout = layout;
			
			list.scrollBarDisplayMode = GroupedList.SCROLL_BAR_DISPLAY_MODE_FLOAT;
		}
		
		private function list_changeHandler( event:Event ):void
		{
			var list:GroupedList = GroupedList( event.currentTarget );
			trace( "selectedGroupIndex:", list.selectedGroupIndex, "selectedItemIndex:", list.selectedItemIndex );
		}
	}

}