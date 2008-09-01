package as3ui.controls.button
{
	import flash.display.Bitmap;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import gs.TweenLite;
	import gs.easing.Quad;
	
	import as3ui.controls.button.rotatebutton.Cursor;
	
	public class RotateButton extends BaseButton
	{
		
		
		[Embed(source='../src/resources/png/button/ButtonRotate_down.png')]
		private var DOWN_PNG:Class;

		[Embed(source='../src/resources/png/button/ButtonRotate_over.png')]
		private var OVER_PNG:Class;

		[Embed(source='../src/resources/png/button/ButtonRotate_out.png')]
		private var OUT_PNG:Class;

		[Embed(source='../src/resources/png/button/ButtonRotate_label.png')]
		private var LABEL_PNG:Class;

		private var m_radius:int = 100;
		private var m_cursor:Cursor;
		private var m_circle:Sprite;
		private var m_angle:Number;
		private var m_angleCache:Number;

		private var m_outState:Bitmap;
		private var m_downState:Bitmap;
		private var m_overState:Bitmap;
		

		private var m_label:Bitmap;
		
		private static const R45:Number = Math.PI/4;
		private static const R90:Number = Math.PI/2;
		private static const R180:Number = Math.PI;
		
		
		public function RotateButton()
		{
			
			m_radius = 27; // Math.round(m_outState.width/2) - 5;

			addEventListener(ButtonEvent.PRESS,onButtonPress);
			addEventListener(ButtonEvent.RELEASE,onButtonRelease);
			addEventListener(ButtonEvent.RELEASE_OUTSIDE,onButtonRelease);
			
			
			
//			m_outState = new Sprite();
//			
//			m_outState.graphics.beginFill(0xFFFFFF,0.15);
//			m_outState.graphics.drawCircle(0,0,m_radius)
//			m_outState.graphics.endFill();
//
//			var line:Shape = new Shape();
//			line.graphics.lineStyle(1,0xFFFFFF,0.7);
//			line.graphics.drawCircle(0,0,m_radius);
//			m_outState.addChild(line); 	
//
//			var blur:Shape = new Shape();
//			blur.graphics.lineStyle(1,0xFFFFFF,1);
//			blur.graphics.drawCircle(0,0,m_radius);
//			m_outState.addChild(blur); 			
//
//			blur.filters = [new GlowFilter(0xFFFFFF,0.5,5,5,4,2,false,true)];
//						
//			
			
			
			
			m_overState = new OVER_PNG();
			m_outState = new OUT_PNG();
			m_downState = new DOWN_PNG();
			m_label = new LABEL_PNG();
			
			m_downState.alpha = 0;
			m_outState.alpha = 1;
			m_overState.alpha = 0;
			
			m_downState.x = -Math.round(m_downState.width/2);
			m_outState.x = -Math.round(m_outState.width/2);
			m_overState.x = -Math.round(m_overState.width/2);
			m_label.x = -Math.round(m_label.width/2);

			m_downState.y = -Math.round(m_downState.height/2);
			m_outState.y = -Math.round(m_outState.height/2);
			m_overState.y = -Math.round(m_overState.height/2);
			m_label.y = -Math.round(m_label.height/2);
			

			


			m_cursor = new Cursor();

			addChild(m_cursor);
			
			m_circle = new Sprite();
			m_circle.graphics.lineStyle(2,0xFFFFFF,0,false,LineScaleMode.NONE);
			m_circle.graphics.drawCircle(0,0,m_radius);
			addChild(m_circle);
			
			angle =  -Math.PI/2;





			addChild(m_downState);
			addChild(m_outState);
			addChild(m_overState)
			addChild(m_label);
			
			addEventListners();
			
			super();
		}
		

		private function addEventListners():void
		{
			addEventListener(ButtonEvent.CHANGE_STATE,onChangeState);
		}



		/*
		* Event handlers
		*/
		override protected function rollOutHandler(a_event:MouseEvent):void
		{
			if(m_enabled)
			{
				m_isMouseOver = false;
				if(!a_event.buttonDown)
				{
					state = ButtonState.RELEASED
					dispatchEvent(m_rollOutEvent);
				}
				else
				{
					if(m_isFocus)
					{
						dispatchEvent(m_rollOutWhileDownEvent);
					}
				}
			}
		}
		
		private function onCompleteSnap(): void 
		{
			
			trace("SNAP DONE " + (angle/(Math.PI/180)));
			//dispatchEvent(new ButtonEvent( ButtonEvent.PRESS,true,true) );
		}
		
		private function onButtonPress(event:ButtonEvent) : void
		{
			m_angleCache = m_angle;
			m_cursor.pressed(true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		private function onButtonRelease(event:ButtonEvent) : void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			
			m_cursor.pressed(false);

			var snap:Number;
			var mod:Number;
			
			if(angle>0)
			{
				mod = ( angle % ( Math.PI/2 ) ) ;
				if( Math.abs( mod ) < R45)
				{
					snap = angle - angle % ( R90 );
				}
				else
				{
					snap = angle - angle % ( R90 ) + R90;
				}
			}
			else 
			{
				mod = ( angle % ( -Math.PI/2 ) ) ;
				if( Math.abs( mod ) < R45)
				{
					snap = angle - angle % ( -R90 );
				}
				else
				{
					snap = angle - angle % ( -R90 ) - R90;
				}				 
			}
			TweenLite.to(this,0.1,{ease:gs.easing.Quad.easeIn,angle:snap,onComplete:onCompleteSnap});					
			
		}
		
		private function onMouseMove(event:MouseEvent) : void
		{
			
			var centerX:Number = 0;
			var centerY:Number = 0;
			m_angle = Math.atan2((mouseY - centerY ), (mouseX - centerX)); 

			angle = m_angle;
		}
		
		protected function onChangeState(event:ButtonEvent):void
		{
			var time:Number = 0.15;
			
			switch (state)
			{
				case ButtonState.OVER:
				
					TweenLite.to(m_outState,time,{alpha:0});
					TweenLite.to(m_downState,time,{alpha:0});
					TweenLite.to(m_overState,time,{alpha:1});
					TweenLite.to(m_label,time,{alpha:0});
					
					m_cursor.active(true);
				break;

				case ButtonState.PRESSED:
					TweenLite.to(m_outState,time,{alpha:0});
					TweenLite.to(m_downState,time,{alpha:1});
					TweenLite.to(m_overState,time,{alpha:0});
					TweenLite.to(m_label,time,{alpha:0});
				break;

				default:
					TweenLite.to(m_outState,time,{alpha:1});
					TweenLite.to(m_downState,time,{alpha:0});
					TweenLite.to(m_overState,time,{alpha:0});
					m_cursor.active(false);
				break;
			} 
		}
		

		/*
		* Public methods
		*/
				
		
		public function undo() : void
		{
			if(!isNaN(m_angleCache))
			{
				m_angleCache = NaN
				angle = m_angleCache;
			}
		}
		
		public function get angle() : Number
		{
			return m_angle;
		}

		public function set angle(a_radians:Number) : void
		{
			
//			var radians:Number = a_angle * (Math.PI/180);
//			trace(a_radians);
			m_cursor.x = m_radius * Math.cos(a_radians);
			m_cursor.y = m_radius * Math.sin(a_radians);
			m_cursor.rotation = a_radians / (Math.PI/180) + 90;
			
			
			m_angle = a_radians;
		}


	}
	
}
	
