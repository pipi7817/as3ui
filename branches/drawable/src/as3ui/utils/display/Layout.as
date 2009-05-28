package as3ui.utils.display
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class Layout
	{
		public function Layout()
		{
		}
		
		static public function getChildren(a_parent:DisplayObjectContainer):Array
		{
			var list:Array = [];
			for ( var i:int=0;i<a_parent.numChildren;i++)
			{
				list.push(a_parent.getChildAt(i));
			}
			return list;
		}
		
		static public function getTotalWidth(a_list:Array):int
		{
			var total:Number = 0;
			for each ( var a_disp:DisplayObject in a_list)
			{
				total += a_disp.width;
			}
			
			return total;			
		}

		static public function getTotalHeight(a_list:Array):int
		{
			var total:Number = 0;
			for each ( var a_disp:DisplayObject in a_list)
			{
				total += a_disp.height;
			}
			
			return total;			
		}

		static public function getMaxWidth(a_list:Array):int
		{
			var max:int = 0;
			for each ( var a_disp:* in a_list)
			{
				max = Math.max(max,a_disp.width);
			}
			
			return max;			
		}


		static public function getMaxHeight(a_list:Array):int
		{
			var max:int = 0;
			for each ( var a_disp:* in a_list)
			{
				max = Math.max(max,a_disp.height);
			}
			
			return max;			
		}
		
		static public function AlignCenterHorizontal(a_list:Array):void
		{
			var max:int = getMaxHeight( a_list);
			for each ( var a_disp:DisplayObject in a_list)
			{
				a_disp.y = Math.round( (max - a_disp.height)*.5 );
			}
		}

		static public function AlignCenterVertical(a_list:Array):void
		{
			var max:int = getMaxWidth( a_list);
			for each ( var a_disp:DisplayObject in a_list)
			{
				a_disp.x = Math.round( (max - a_disp.width)*.5 );
			}
		}

		static public function AlignCenter(a_list:Array):void
		{
			var maxWidth:int = getMaxWidth( a_list);
			var maxHeight:int = getMaxHeight( a_list);
			
			for each ( var a_disp:DisplayObject in a_list)
			{
				a_disp.y = Math.round( (maxHeight - a_disp.height)*.5 );
				a_disp.x = Math.round( (maxWidth - a_disp.width)*.5 );
			}
		}
		
		static public function DistributeHorizontal(a_width:int,a_list:Array,a_pixelSnap:Boolean = true):void
		{
			
			if(a_list.length < 2)
			{
					AlignCenterHorizontal(a_list);
			}
			else if(a_list.length == 2)
			{
				a_list[0].x = 0;
				a_list[1].x = a_pixelSnap? Math.round( a_width - a_list[1].width ) : a_width - a_list[1].width;
			}
			else
			{
				var total:Number = getTotalWidth(a_list) - a_list[a_list.length-1].width;
				var diff:Number = a_width - total - a_list[a_list.length-1].width;
				var segment:Number = diff/(a_list.length-1);
				var xpos:Number = 0;
				for each ( var disp:DisplayObject in a_list)
				{
					disp.x = a_pixelSnap? Math.round( xpos ) : xpos;
					xpos += disp.width + segment;
				}
			}

		}

		static public function DistributeVertical(a_height:int,a_list:Array,a_pixelSnap:Boolean = true):void
		{
			
			if(a_list.length < 2)
			{
					AlignCenterVertical(a_list);
			}
			else if(a_list.length == 2)
			{
				a_list[0].y = 0;
				a_list[1].y = a_pixelSnap? Math.round( a_height - a_list[1].height ) : a_height - a_list[1].height;
			}
			else
			{
				var total:Number = getTotalHeight(a_list) - a_list[a_list.length-1].height;
				var diff:Number = a_height - total - a_list[a_list.length-1].height;
				var segment:Number = diff/(a_list.length-1);
				var ypos:Number = 0;
				for each ( var disp:DisplayObject in a_list)
				{
					disp.y = a_pixelSnap? Math.round( ypos ) : ypos;
					ypos += disp.height + segment;
				}
			}

		}				
	}
}