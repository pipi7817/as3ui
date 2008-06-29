package se.konstruktor.as3ui.video
{

	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	
	import fl.video.VideoError;

	public class MediaTest extends TestCase
	{
		private var m_instance:Media;

		public function MediaTest(methodName:String=null)
		{
			super(methodName)
		}

		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new MediaTest());
//	 		ts.addTest(new MediaTest("testInstantiated"));
   			return ts;
   		}

		override protected function setUp():void
		{
			super.setUp();
			m_instance = new Media();
			// addChild(m_instance);
		}

		override protected function tearDown():void
		{
			super.tearDown();
			//removeChild(m_instance);
			m_instance = null;
		}

		public function testInstantiated():void
		{
			assertTrue("media is Media", m_instance is Media);
		}

		public function testParseURL():void
		{
			m_instance.parseURL("rtmp://host.domain.com:8080/app_name/stream_name");
			assertEquals("rtmp:/",m_instance.protocol);
			assertEquals(8080,m_instance.portNumber);
			assertEquals("host.domain.com",m_instance.serverName);
			assertEquals("app_name",m_instance.appName);
			assertEquals("stream_name",m_instance.streamName);
			assertEquals(false,m_instance.isRelative);
			assertEquals(true,m_instance.isRTMP);
			
			m_instance.parseURL("rtmp://host.domain.com/app_name/stream_name");
			assertEquals("rtmp:/",m_instance.protocol);
			assertEquals(null,m_instance.portNumber);
			assertEquals("host.domain.com",m_instance.serverName);
			assertEquals("app_name",m_instance.appName);
			assertEquals("stream_name",m_instance.streamName);
			assertEquals(false,m_instance.isRelative);
			assertEquals(true,m_instance.isRTMP);

			try
			{
			m_instance.parseURL("rtmp://host.domain.com/?app_name/stream_name");
				
				assertTrue("rtmp://host.domain.com/?app_name/stream_name should triger a VideoError ",false);
			} 
			catch (e:VideoError)
			{
				assertEquals("1004: Invalid source: rtmp://host.domain.com/?app_name/stream_name",e.message);
			}
//
//			m_instance = VideoURL.parseURL("rtmp://host.domain.com:80/?rtmp://wrapped.domain.com:8080/wrapped_app_name/wraped_stream_name");
//			assertEquals("rtmp:/",m_instance.protocol);
//			assertEquals("80",m_instance.portNumber);
//			assertEquals("host.domain.com",m_instance.serverName);
//			assertEquals("wrapped_app_name",m_instance.appName);
//			assertEquals("wraped_stream_name",m_instance.streamName);
//			assertEquals(false,m_instance.isRelative);
//			assertEquals(true,m_instance.isRTMP);

			m_instance.parseURL("rtmp://host.domain.com/app_name/stream_name");
			assertEquals("rtmp:/",m_instance.protocol);
			assertEquals(null,m_instance.portNumber);
			assertEquals("host.domain.com",m_instance.serverName);
			assertEquals("app_name",m_instance.appName);
			assertEquals("stream_name",m_instance.streamName);
			assertEquals(false,m_instance.isRelative);
			assertEquals(true,m_instance.isRTMP);


			m_instance.parseURL("rtmp://host.domain.com:80/app_name/stream_name");
			assertEquals("rtmp:/",m_instance.protocol);
			assertEquals("80",m_instance.portNumber);
			assertEquals("host.domain.com",m_instance.serverName);
			assertEquals("app_name",m_instance.appName);
			assertEquals("stream_name",m_instance.streamName);
			assertEquals(false,m_instance.isRelative);
			assertEquals(true,m_instance.isRTMP);

			m_instance.parseURL("rtmp://host.domain.com:8080/app_name/1/stream_name/1/2/3?value=abc");
			assertEquals("rtmp:/",m_instance.protocol);
			assertEquals("8080",m_instance.portNumber);
			assertEquals("host.domain.com",m_instance.serverName);
			assertEquals("app_name/1",m_instance.appName);
			assertEquals("stream_name/1/2/3?value=abc",m_instance.streamName);
			assertEquals(false,m_instance.isRelative);
			assertEquals(true,m_instance.isRTMP);

			m_instance.parseURL("rtmp://host.domain.com:8080/app_name");
			assertEquals("rtmp:/",m_instance.protocol);
			assertEquals("8080",m_instance.portNumber);
			assertEquals("host.domain.com",m_instance.serverName);
			assertEquals("app_name",m_instance.appName);
			assertEquals(null,m_instance.streamName);
			assertEquals(false,m_instance.isRelative);
			assertEquals(true,m_instance.isRTMP);

			m_instance.parseURL("/host.domain.com/app_name/stream_name");
			assertEquals(true,m_instance.isRelative);
			assertEquals(false,m_instance.isRTMP);

			m_instance.parseURL("rtmpt://host.domain.com:8080/app_name/1/stream_name/1/2/3?value=abc");
			assertEquals("rtmpt:/",m_instance.protocol);
			assertEquals(true,m_instance.isRTMP);

			m_instance.parseURL("rtmps://host.domain.com:8080/app_name/1/stream_name/1/2/3?value=abc");
			assertEquals("rtmps:/",m_instance.protocol);
			assertEquals(true,m_instance.isRTMP);

			m_instance.parseURL("rtmpe://host.domain.com:8080/app_name/1/stream_name/1/2/3?value=abc");
			assertEquals("rtmpe:/",m_instance.protocol);
			assertEquals(true,m_instance.isRTMP);

			m_instance.parseURL("rtmpte://host.domain.com:8080/app_name/1/stream_name/1/2/3?value=abc");
			assertEquals("rtmpte:/",m_instance.protocol);
			assertEquals(true,m_instance.isRTMP);


			m_instance.parseURL("rtmp://host.domain.com:8080/app_name.flv");
			assertEquals("app_name",m_instance.appName);

			m_instance.parseURL("rtmp://host.domain.com:8080/app_name/stream_name.flv");
			assertEquals("app_name",m_instance.appName);
			assertEquals("stream_name",m_instance.streamName);
			
		}

	}
}