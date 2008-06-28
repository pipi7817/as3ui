package se.konstruktor.as3ui.video {

	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	
	import fl.video.VideoError;

	public class VideoURLTest extends TestCase {
		private var m_instance:VideoURL;

		public function VideoURLTest(methodName:String=null) {
			super(methodName)
		}

		public static function suite():TestSuite {
  			
   			var ts:TestSuite = new TestSuite();
//	 		ts.addTest(new VideoURLTest("testInstantiated"));
	 		ts.addTest(new VideoURLTest());
   			return ts;
   		}

		override protected function setUp():void {
			super.setUp();
			m_instance = new VideoURL();
			// addChild(m_instance);
		}

		override protected function tearDown():void {
			super.tearDown();
			//removeChild(m_instance);
			m_instance = null;
		}

		public function testInstantiated():void {
			assertTrue("videoURL is VideoURL", m_instance is VideoURL);
		}

		public function testParseURL():void
		{
			var result:VideoMedia;

			result = VideoURL.parseURL("rtmp://host.domain.com:8080/app_name/stream_name");
			assertEquals("rtmp:/",result.protocol);
			assertEquals(8080,result.portNumber);
			assertEquals("host.domain.com",result.serverName);
			assertEquals("app_name",result.appName);
			assertEquals("stream_name",result.streamName);
			assertEquals(false,result.isRelative);
			assertEquals(true,result.isRTMP);
			
			result = VideoURL.parseURL("rtmp://host.domain.com/app_name/stream_name");
			assertEquals("rtmp:/",result.protocol);
			assertEquals(null,result.portNumber);
			assertEquals("host.domain.com",result.serverName);
			assertEquals("app_name",result.appName);
			assertEquals("stream_name",result.streamName);
			assertEquals(false,result.isRelative);
			assertEquals(true,result.isRTMP);

			try
			{
			result = VideoURL.parseURL("rtmp://host.domain.com/?app_name/stream_name");
				
				assertTrue("rtmp://host.domain.com/?app_name/stream_name should triger a VideoError ",false);
			} 
			catch (e:VideoError)
			{
				assertEquals("1004: Invalid source: rtmp://host.domain.com/?app_name/stream_name",e.message);
			}
//
//			result = VideoURL.parseURL("rtmp://host.domain.com:80/?rtmp://wrapped.domain.com:8080/wrapped_app_name/wraped_stream_name");
//			assertEquals("rtmp:/",result.protocol);
//			assertEquals("80",result.portNumber);
//			assertEquals("host.domain.com",result.serverName);
//			assertEquals("wrapped_app_name",result.appName);
//			assertEquals("wraped_stream_name",result.streamName);
//			assertEquals(false,result.isRelative);
//			assertEquals(true,result.isRTMP);

			result = VideoURL.parseURL("rtmp://host.domain.com/app_name/stream_name");
			assertEquals("rtmp:/",result.protocol);
			assertEquals(null,result.portNumber);
			assertEquals("host.domain.com",result.serverName);
			assertEquals("app_name",result.appName);
			assertEquals("stream_name",result.streamName);
			assertEquals(false,result.isRelative);
			assertEquals(true,result.isRTMP);


			result = VideoURL.parseURL("rtmp://host.domain.com:80/app_name/stream_name");
			assertEquals("rtmp:/",result.protocol);
			assertEquals("80",result.portNumber);
			assertEquals("host.domain.com",result.serverName);
			assertEquals("app_name",result.appName);
			assertEquals("stream_name",result.streamName);
			assertEquals(false,result.isRelative);
			assertEquals(true,result.isRTMP);

			result = VideoURL.parseURL("rtmp://host.domain.com:8080/app_name/1/stream_name/1/2/3?value=abc");
			assertEquals("rtmp:/",result.protocol);
			assertEquals("8080",result.portNumber);
			assertEquals("host.domain.com",result.serverName);
			assertEquals("app_name/1",result.appName);
			assertEquals("stream_name/1/2/3?value=abc",result.streamName);
			assertEquals(false,result.isRelative);
			assertEquals(true,result.isRTMP);

			result = VideoURL.parseURL("rtmp://host.domain.com:8080/app_name");
			assertEquals("rtmp:/",result.protocol);
			assertEquals("8080",result.portNumber);
			assertEquals("host.domain.com",result.serverName);
			assertEquals("app_name",result.appName);
			assertEquals(null,result.streamName);
			assertEquals(false,result.isRelative);
			assertEquals(true,result.isRTMP);

			result = VideoURL.parseURL("/host.domain.com/app_name/stream_name");
			assertEquals(true,result.isRelative);
			assertEquals(false,result.isRTMP);

			result = VideoURL.parseURL("rtmpt://host.domain.com:8080/app_name/1/stream_name/1/2/3?value=abc");
			assertEquals("rtmpt:/",result.protocol);
			assertEquals(true,result.isRTMP);

			result = VideoURL.parseURL("rtmps://host.domain.com:8080/app_name/1/stream_name/1/2/3?value=abc");
			assertEquals("rtmps:/",result.protocol);
			assertEquals(true,result.isRTMP);

			result = VideoURL.parseURL("rtmpe://host.domain.com:8080/app_name/1/stream_name/1/2/3?value=abc");
			assertEquals("rtmpe:/",result.protocol);
			assertEquals(true,result.isRTMP);

			result = VideoURL.parseURL("rtmpte://host.domain.com:8080/app_name/1/stream_name/1/2/3?value=abc");
			assertEquals("rtmpte:/",result.protocol);
			assertEquals(true,result.isRTMP);


			result = VideoURL.parseURL("rtmp://host.domain.com:8080/app_name.flv");
			assertEquals("app_name",result.appName);

			result = VideoURL.parseURL("rtmp://host.domain.com:8080/app_name/stream_name.flv");
			assertEquals("app_name",result.appName);
			assertEquals("stream_name",result.streamName);
		}

	}
}