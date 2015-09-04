package mvc.view.ui.sceen 
{
	import feathers.controls.PanelScreen;
	
	/**
	 * ...
	 * @author minichen
	 */
	public class OptionsScreen extends PanelScreen 
	{
		
		public function OptionsScreen() 
		{
			super();
			
		}
		override protected function initialize():void
        {
            super.initialize();
            this.title = "Options";
        }
	}

}