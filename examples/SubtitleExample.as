package
{
	import as3ui.UIObject;
	import as3ui.controls.button.BaseButton;
	import as3ui.controls.button.ButtonEvent;
	import as3ui.controls.button.TextButton;
	import as3ui.managers.SubtitleManager;
	import as3ui.managers.subtitlemanager.events.SubtitleEvent;
	
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class SubtitleExample extends UIObject
	{
		
		[Embed(systemFont='Arial', fontName="Arial", fontWeight="bold", mimeType="application/x-font-truetype")]
		private var FONT:Class;
				
		[Embed(source='../src/resources/png/button/ButtonYellow_up.png')]
		private var PNG_UP:Class;
		
		private var m_subtext:TextField;
		
		public function SubtitleExample()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
			addEventListener(ButtonEvent.PRESS,onPressButton);
			

			draw();
		}

		private function draw() : void
		{
			
			var btn:TextButton;
			var xpos:int = 0;

			btn = new TextButton(getLabel("ShowText1"),new PNG_UP());
			btn.name = "ShowText1"; 
			btn.x = xpos;
			addChild(btn);
			xpos += btn.width + 10;

			btn = new TextButton(getLabel("ShowText2"),new PNG_UP());
			btn.name = "ShowText2"; 
			btn.x = xpos;
			addChild(btn);
			xpos += btn.width + 10;

			btn = new TextButton(getLabel("ClearText"),new PNG_UP());
			btn.name = "ClearText"; 
			btn.x = xpos;
			addChild(btn);
			xpos += btn.width + 10;
			
			m_subtext = new TextField();
			m_subtext.defaultTextFormat = new TextFormat("Arial",24,0xFFFFFF,true);
			m_subtext.embedFonts = true;
			m_subtext.antiAliasType = AntiAliasType.ADVANCED;
			m_subtext.text = "";
			m_subtext.autoSize = TextFieldAutoSize.LEFT;
			m_subtext.x = 10;
			m_subtext.y = 110;
			addChild(m_subtext);

		}
		
		private function onPressButton(a_event:ButtonEvent) : void
		{
			dispatchEvent( new Event( (a_event.target as BaseButton).name,true,true) );			
		}
		
		private function getLabel(a_text:String) : TextField
		{
			var label:TextField = new TextField();
			label.defaultTextFormat = new TextFormat("Arial",11,0x000000);
			label.embedFonts = true;
			label.antiAliasType = AntiAliasType.ADVANCED;
			label.text = a_text;
			label.autoSize = TextFieldAutoSize.LEFT;

			return label;
		}
		
		private function onAdded( a_event:Event ) : void
		{
			var xml:XML = <actions>
								<action type="SHOW" trigger="ShowText1">
									<text timeout="2000" delay="0" position="bottom"><![CDATA[Text 1]]></text>
									<text timeout="4000" delay="400" position="top"><![CDATA[Text 2]]></text>
									<text timeout="6000" delay="600"><![CDATA[Text 3]]></text>
								</action>
								<action type="SHOW" trigger="ShowText2">
									<text timeout="2000" delay="0" position="bottom"><![CDATA[Text a]]></text>
									<text timeout="4000" delay="200" position="top"><![CDATA[Text b]]></text>
									<text timeout="6000" delay="300"><![CDATA[Text c]]></text>
								</action>
								<action type="HIDE" trigger="ClearText" />
					</actions>;
					 

			SubtitleManager.setContext(this);
			SubtitleManager.loadConfig(xml);	 
			SubtitleManager.instance.addEventListener(SubtitleEvent.SHOW,onShow);	
			SubtitleManager.instance.addEventListener(SubtitleEvent.HIDE,onHide);	

			setSize(600,200);
			
		}
		
		private function onShow( a_event:SubtitleEvent ) : void
		{
			graphics.clear();
			graphics.beginFill(0x333333);
			graphics.drawRect(0,100,width,height-120);
			graphics.endFill();	
			m_subtext.visible = true;	
			m_subtext.text 	= a_event.text.replace(/\\n/g,"\n");
		}
		
		private function onHide( a_event:SubtitleEvent ) : void
		{
			graphics.clear();
			m_subtext.visible = false;	
			m_subtext.text 	= "";
		}
		
	}
}