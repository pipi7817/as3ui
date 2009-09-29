package UIComponentExample
{
	import as3ui.display.UIComponent;

	public class ComponentItem extends UIComponent
	{
		private var m_cnt:int;
		public function ComponentItem()
		{
			super();
			
			
			for(var i:int = 0; i<10;i++)
			{
				setSize(100+Math.random()*100,20+Math.random()*50,true);
				setChanged();
			}
			
		}
		
		override protected function draw():void
		{
			m_cnt++;
			trace("ComponentItem.draw() : " + m_cnt);
			with(graphics)
			{
				beginFill(0xFF0000,0.2);
				drawRect(0,0,width,height);
				endFill();
			}
		}
		
	}
}