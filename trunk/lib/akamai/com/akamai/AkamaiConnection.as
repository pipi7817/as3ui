
package com.akamai
{
	
	import com.akamai.events.*;
	import flash.errors.IOError;
	import flash.net.*;
    import flash.events.*;
    import flash.utils.*;
    import flash.system.Capabilities;
    import flash.media.SoundTransform;

	/**
	 * Dispatched when an error condition has occurred. The event provides an error number and a verbose description
	 * of each error:
	 * <table>
	 * <tr><th> Error Number</th><th>Description</th></tr>
	 * <tr><td>1</td><td>Hostname cannot be empty</td></tr>
	 * <tr><td>2</td><td>Buffer length must be &gt; 0.1</td></tr>
	 * <tr><td>3</td><td>Warning - this protocol is not supported on the Akamai network</td></tr>
	 * <tr><td>4</td><td>Warning - this port is not supported on the Akamai network</td></tr>
	 * <tr><td>5</td><td>Unable to load XML data from ident request</td></tr>
	 * <tr><td>6</td><td>Timed out while trying to connect</td></tr>
	 * <tr><td>7</td><td>Stream not found</td></tr>
	 * <tr><td>8</td><td>Cannot play, pause, seek, or resume since the stream is not defined</td></tr>
	 * <tr><td>9</td><td>Timed out trying to find the live stream</td></tr>
	 * <tr><td>10</td><td>Error requesting stream length</td></tr>
	 * <tr><td>11</td><td>Volume value out of range</td></tr>
	 * <tr><td>12</td><td>Network failure - unable to play the live stream</td></tr>
	 * <tr><td>13</td><td>Connection attempt rejected by server</td></tr>
	 * <tr><td>19</td><td>The Fast Start feature cannot be used with live streams</td></tr>
	 * <tr><td>21</td><td>NetStream IO Error event</td></tr>
	 * <tr><td>22</td><td>NetStream Failed - check your live stream auth params</td></tr>
	 * </table>
	 * 
	 * @eventType com.akamai.events.AkamaiErrorEvent.ERROR
	 */
 	[Event (name="error", type="com.akamai.events.AkamaiErrorEvent")]
 	/**
	 * Dispatched when a bandwidth estimate is complete. 
	 * 
	 * @eventType com.akamai.events.AkamaiNotificationEvent.BANDWIDTH
	 */
 	[Event (name="bandwidth", type="com.akamai.events.AkamaiNotificationEvent")]
 	/**
	 * Dispatched when the class has successfully connected to the Akamai Streaming service.
	 * 
	 * @eventType com.akamai.events.AkamaiNotificationEvent.CONNECTED
	 */
 	[Event (name="connected", type="com.akamai.events.AkamaiNotificationEvent")]
 	/**
	 * Dispatched when the class has detected, by analyzing the
	 * NetStream.netStatus events, the end of the stream. Deprecated in favor of 
	 * <code>com.akamai.events.AkamaiStatusEvent.NETSTREAM_PLAYSTATUS</code>
	 * when communicating with a FMS 2.5 or higher server. For progressive delivery
	 * of streams however, this event is the only indication provided that the stream
	 * has ended. 
	 * 
	 * @see com.akamai.events.AkamaiStatusEvent.NETSTREAM_PLAYSTATUS
	 * 
	 * @eventType com.akamai.events.AkamaiNotificationEvent.END_OF_STREAM
	 */
 	[Event (name="end", type="com.akamai.events.AkamaiNotificationEvent")]
 	/**
	 * Dispatched when the class has completed a stream length request.
	 * 
	 * @see #getStreamLength
	 * 
	 * @eventType com.akamai.events.AkamaiNotificationEvent.STREAM_LENGTH
	 */
 	[Event (name="streamlength", type="com.akamai.events.AkamaiNotificationEvent")]
 	/**
	 * Dispatched when the the class has successfully subscribed to a live stream.
	 * 
	 * @see #isLive
	 * @see #play
	 * 
	 * @eventType com.akamai.events.AkamaiNotificationEvent.SUBSCRIBED
	 */
 	[Event (name="subscribed", type="com.akamai.events.AkamaiNotificationEvent")]
 	/**
	 * Dispatched when the class has unsubscribed from a live stream, or when the live stream it was previously subscribed
	 * to has ceased publication.
	 * 
	 * @see #isLive
	 * @see #play
	 * @see #unsubscribe
	 * 
	 * @eventType com.akamai.events.AkamaiNotificationEvent.UNSUBSCRIBED
	 */
 	[Event (name="unsubscribed", type="com.akamai.events.AkamaiNotificationEvent")]
 	/**
	 * Dispatched when the class is making a new attempt to subscribe to a live stream
	 * 
	 * @see #isLive
	 * @see #play
	 * 
	 * @eventType com.akamai.events.AkamaiNotificationEvent.SUBSCRIBE_ATTEMPT
	 */
 	[Event (name="subscribeattempt", type="com.akamai.events.AkamaiNotificationEvent")]
 	/**
	 * Dispatched when the NetStream object has changed status.
	 * 
	 * @see #createStream
	 * 
	 * @eventType com.akamai.events.AkamaiStatusEvent.NETSTREAM
	 */
 	[Event (name="netstream", type="com.akamai.events.AkamaiStatusEvent")]
 	/**
	 * Dispatched when the NetConnection object has changed status.
	 * 
	 * @see #connect
	 * 
	 * @eventType com.akamai.events.AkamaiStatusEvent.NETCONNECTION
	 */
 	[Event (name="netconnection", type="com.akamai.events.AkamaiStatusEvent")]
 	/**
	 * Dispatched when the class has completely played a stream or switches to a different stream in a server-side playlist.
	 * 
	 * @see #createStream
	 * @see #play
	 * 
	 * @eventType com.akamai.events.AkamaiStatusEvent.NETSTREAM_PLAYSTATUS
	 */
 	[Event (name="playstatus", type="com.akamai.events.AkamaiStatusEvent")]
 	/**
	 * Dispatched when the class receives descriptive information embedded in the
	 * FLV file being played.
	 * 
	 * @see #createStream
	 * @see #play
	 * 
	 * @eventType com.akamai.events.AkamaiStatusEvent.NETSTREAM_METADATA
	 */
 	[Event (name="metadata", type="com.akamai.events.AkamaiStatusEvent")]
 	/**
	 * Dispatched when an embedded cue point is reached while playing an FLV file.
	 * 
	 * @see #createStream
	 * @see #play
	 * 
	 * @eventType com.akamai.events.AkamaiStatusEvent.NETSTREAM_CUEPOINT
	 */
 	[Event (name="cuepoint", type="com.akamai.events.AkamaiStatusEvent")]
 	/**
	 * Dispatched when the class receives information about ID3 data embedded in an MP3 file.
	 * 
	 * @see #getMp3Id3Info
	 * 
	 * @eventType com.akamai.events.AkamaiStatusEvent.MP3_ID3
	 */
 	[Event (name="id3", type="com.akamai.events.AkamaiStatusEvent")]
 	
 	 	
 	/**
	 * Dispatched repeatedly at the  <code>progressInterval</code> once class begins playing a stream. 
	 * Event is halted after <code>close</code> or <code>closeNetStream</code> is called. 
	 * 
	 * @see #progressInterval
	 * @see #close
	 * @see #closeNetStream
	 * 
	 * @eventType com.akamai.events.AkamaiNotificationEvent.PROGRESS
	 */
	 [Event (name="progress", type="com.akamai.events.AkamaiNotificationEvent")]
	 
	/**
	 * Dispatched when a stream from a FMS 2.5+ server is complete. Note that when conecting to progressive
	 * content, or a FMS1.7x server, this event will not be dispatched. The com.akamai.events.AkamaiNotificationEvent.END_OF_STREAM
	 * should be used instead, in order to detect when the stream has finished playing. 
	 * 
	 * @eventType com.akamai.events.AkamaiNotificationEvent.COMPLETE
	 * 
	 * @see com.akamai.events.AkamaiNotificationEvent.END_OF_STREAM
	 */
	 [Event (name="complete", type="com.akamai.events.AkamaiNotificationEvent")]
 	
 	
 	
	/**
	 *  The AkamaiConnection class manages the complexity of establishing a robust NetConnection
	 *  with the Akamai Streaming service.
	 *  It optionally creates a NetStream over that NetConnection and exposes an API to control the
	 *  playback of content over that NetStream. The AkamaiConnection class works with on-demand FLV (both
	 *  streaming and progressive) and MP3 playback (streaming only), as well as live FLV streams. 
	 *
	 */
	public class AkamaiConnection extends EventDispatcher
	{

    	// Declare private vars
    	private var _hostName:String;
    	private var _appName:String;
		private var _isLive:Boolean;
		private var _port:String;
		private var _protocol:String;
		private var _createStream:Boolean;
		private var _maxBufferLength:uint;
		private var _useFastStartBuffer:Boolean;
		private var _akLoader:URLLoader;
		private var _ip:String;
		private var _isPaused:Boolean;
		private var _streamLength:uint;
		private var _nc:AkamaiNetConnection;
		private var _ns:NetStream;
		private var _nsId3:NetStream;
		private var _aConnections:Array;
		private var _connectionTimer:Timer;
		private var _timeOutTimer:Timer;
		private var _liveStreamTimer:Timer;
		private var _liveStreamRetryTimer:Timer;
		private var _liveFCSubscribeTimer:Timer;
		private var _progressTimer:Timer;
		private var _liveStreamMasterTimeout:uint;
		private var _connectionAttempt:uint;
		private var _aNC:Array;
		private var _aboutToStop:uint;
		private var _volume:Number;
		private var _panning:Number;
		private var _connectionEstablished:Boolean;
		private var _streamEstablished:Boolean;
		private var _pendingLiveStreamName:String;
		private var _playingLiveStream:Boolean;
		private var _successfullySubscribed:Boolean;
		private var _authParams:String;
		private var _liveStreamAuthParams:String;
		private var _isProgressive:Boolean;
		private var _isBuffering:Boolean;
		
		// Declare private constants
		private const TIMEOUT:uint = 15000;
		private const LIVE_RETRY_INTERVAL:Number = 30000;
		private const LIVE_ONFCSUBSCRIBE_TIMEOUT:Number = 60000;
		private const DEFAULT_PROGRESS_INTERVAL:Number = 100;
		private const VERSION:String = "1.3";
		
		/**
		 *  Constructor. 
		 */
		public function AkamaiConnection():void {
			NetConnection.defaultObjectEncoding = flash.net.ObjectEncoding.AMF0;
			initVars();
			initializeTimers();
			
		}
		/**
		 * The connect method initiates a connection to either the Akamai Streaming service or a progressive
		 * link to a HTTP server. It accepts a single hostName parameter, which describes the host account with which 
		 * to connect. This parameter can optionally include the application name, separated by a "/". A progressive
		 * connection is requsted by passing the <code>null</code> object, or the string "null". All other strings
		 * are treated as requests for a streaming connection. Valid usage examples include:<ul>
		 * 			<li>instance_name.connect("cpxxxxx.edgefcs.net");</li>
		 * 			<li>instance_name.connect("cpxxxxx.edgefcs.net/ondemand");</li>
		 * 			<li>instance_name.connect("cpxxxxx.edgefcs.net/aliased_ondemand_app_name");</li>
		 *  		<li>instance_name.connect("aliased.domain.name/aliased_ondemand_app_name");</li>
		 * 			<li>instance_name.connect("cpxxxxx.live.edgefcs.net/live");</li></ul>
		 * 		    <li>instance_name.connect(null);</li></ul>
		 *  		<li>instance_name.connect("null");</li></ul>
		 *  If the application name is not specifed, then the class will use <em>ondemand</em>
		 *  if <code>isLive</code> is false and <em>live</em> if <code>isLive</code> is true.
		 *  To connect to a cp code requiring connection authorization, first set the <code>authParams</code>
		 *  property before calling this <code>connect</code> method. 
		 * <p/><br />
		 * 
		 * @param The Akamai hostname to which to connect. The application name may optionally be
		 * included in this string, separated from the hostname by a "/". For a progressive connection,
		 * pass <code>null</code>, either as a null object or as a string.
		 * 
		 * @see #isLive
		 * @see #authParams
		 */
		public function connect(hostName:String):void {
			if (hostName == null || hostName == "null") {
				setUpProgressiveConnection();
			} else {
				if (hostName == "" ) { 
					dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,1,"Hostname cannot be empty")); 
				} else {
					_isProgressive = false;
					_hostName = hostName.indexOf("/") != -1 ? hostName.slice(0,hostName.indexOf("/")):hostName;
					_appName = hostName.indexOf("/") != -1 && hostName.indexOf("/") != hostName.length-1 ? hostName.slice(hostName.indexOf("/")+1):isLive ? "live":"ondemand";
					_connectionEstablished = false;
					_streamEstablished = false;
					// request IP address of optimum server
					_akLoader= new URLLoader();	
					_akLoader.addEventListener("complete", akamaiXMLLoaded);
					_akLoader.addEventListener(IOErrorEvent.IO_ERROR, catchIOError);
					_akLoader.load(new URLRequest("http://" + _hostName + "/fcs/ident"));
				}
			}

		}
		/**
		 * The last measured bandwidth value in kilobits/second. Requires that a NetConnection has been
		 * established and that <code>detectBandwidth()</code> has previously been called. Since bandwidth
		 * detection between the client and the server is an asynchronous operation,
		 * to request the bandwidth, you must first make a call to the <code>detectBandwidth()</code> method
		 * and then wait for notifcation from the AkamaiNotificationEvent.BANDWIDTH event before requesting
		 * this property value.
		 * <p />
		 * This property is not available with progressive playback. 
		 * 
		 * @returns bandwidth estimate in kiloBits/sec, or -1 if the NetConnection has not yet been established.
		 * 
		 * @see #detectBandwidth
		 */
		// 
		public function get bandwidth():Number {
			return _connectionEstablished ? _nc.bandwidth : -1;
		};
		/**
		 * The last measured latency value, in milliseconds. The latency is an estimate of the time it
		 * takes a packet to travel from the client to the server.
		 * Requires that a NetConnection has been established and that <code>detectBandwidth()</code> method has previously been 
		 * called. Since bandwidth/latency detection between the client and the server is an asynchronous operation,
		 * to request the latency, you must first make a call to the <code>detectBandwidth()</code> method and then
		 * wait for notifcation from the AkamaiNotificationEvent.BANDWIDTH event before requesting this property value.
		 * <p />
		 * This property is not available with progressive playback.
		 * 
		 * @returns latency estimate in milliseconds, or -1 if the NetConnection has not yet been established.
		 * 
		 * @see #detectBandwidth
		 * @see #bandwidth
		 */
		public function get latency():Number {
			return _streamEstablished ? _nc.latency: -1;
		};
		/**
		 * The IP address of the server to which the class connected. This parameter will only be returned if the class has managed to
		 * successfully connect to the server. The class uses the IDENT function to locate the optimum (in terms
		 * of physical proximity and load) server for connections. 
		 * <p />
		 * This property is not available with progressive playback. 
		 * 
		 * @returns Server IP address as a string if the connection has been made, otherwise null.
		 * 
		 */
		public function get serverIPaddress():String {
			return _connectionEstablished ? _ip: null;
		}
		/**
		 * The last hostName used by the class. If the hostName was sent in the <code>connect</code> method
		 * concatenated with the application name (for example <code>connect("cpxxxx.edgefcs.net/myappalias")</code>)
		 * then this method will only return "cpxxxx.edgefcs.net". Use the <code>appName</code> to retrieve the
		 * application name.
		 * 
		 * @returns the last hostName used by the class
		 * 
		 * @see #appName
		 * 
		 */
		public function get hostName():String {
			return _hostName;
		}
		/**
		 * The last appName used by the class. 
		 * 
		 * @returns the last appName used by the class
		 * 
		 * @see #appName
		 * 
		 */
		public function get appName():String {
			return _appName;
		}
		/**
		 * The port on which the class has connected. This parameter will only be returned if the class has managed to
		 * successfully connect to the server. Possible port values are "1935", "443", and "80". This property will
		 * differ from requestedPort if the requestedPort value was "any", in which case this property will return
		 * the port that was actually used.
		 * <p />
		 * This property is not available with progressive playback.
		 * 
		 * @returns the port over which the connection has actually been made, otherwise null.
		 * 
		 * @see #requestedPort
		 */
		public function get actualPort():String {
			return _connectionEstablished ? _nc.port: null;
		}
		/**
		 * The name-value pairs required for invoking connection authorization services on the 
		 * Akamai network. Typically these include the "auth","aifp" and "slist"
		 * parameters. These name-value pairs must be separated by a "&" and should
		 * not commence with a "?", "&" or "/". An example of a valid authParams string
		 * would be:<p />
		 * 
		 * auth=dxaEaxdNbCdQceb3aLd5a34hjkl3mabbydbbx-bfPxsv-b4toa-nmtE&aifp=babufp&slist=secure/babutest
		 * 
		 * <p />
		 * These properties must be set before calling the <code>connect</code> method,
		 * since authorization is checked when the connection is first established.
		 * If the authorization parameters are rejected by the server, then error #13 
		 * will be dispatched  - "Connection attempt rejected by server".
		 * <p />
		 * For live stream, per stream authentication, which can occur in combination with connection
		 * authentication, set the <code>liveStreamAuthParams</code> parameters before calling
		 * the <code>play()</code> method. 
		 * 
		 * <p />
		 * Auth params cannot be used with progressive playback and are for streaming connections only. 
		 * 
		 * @returns the authorization name-value pairs.
		 * 
		 * @default empty string.
		 *
		 * @see #connect
		 * @see #liveStreamAuthParams
		 */
		public function get authParams():String {
			return _authParams;
		}
		/**
		 *  @private
		 */
		public function set authParams(ap:String):void {
			_authParams = ap;
		}
		/**
		 * The name-value pairs required for invoking stream-level authorization services against
		 * live streams on the Akamai network. Typically these include the "auth" and "aifp" 
		 * parameters. These name-value pairs must be separated by a "&" and should
		 * not commence with a "?", "&" or "/". An example of a valid authParams string
		 * would be:<p />
		 * 
		 * auth=dxaEaxdNbCdQceb3aLd5a34hjkl3mabbydbbx-bfPxsv-b4toa-nmtE&aifp=babufp
		 * 
		 * <p />
		 * These properties must be set before calling the <code>play</code> method,
		 * since per stream authorization is invoked when the file is first played (as opposed
		 * to connection auth params which are invoked when the connection is made).
		 * If the stream-level authorization parameters are rejected by the server, then
		 * AkamaiErrorEvent.ERROR event #22 "NetStream Failed - check your live stream auth params"
		 * will be dispatched. The AkamaiStatusEvent.NETSREAM event will also be dispatched with a <code>info.code</code> property 
		 * of "NetStream.Failed". Note that the AkamaiStatusEvent.SUBSCRIBED event will be 
		 * dispatched, even though stream playback will fail.
		 *
		 * @see #authParams
		 * @see #play
		 */
		public function get liveStreamAuthParams():String {
			return _liveStreamAuthParams;
		}
		/**
		 *  @private
		 */
		public function set liveStreamAuthParams(ap:String):void {
			_liveStreamAuthParams = ap;
		}
		/**
		 * The port over which the class was originally requested to connect via the <code>requestedPort</code> property.
		 * Possible requested port values are "any", "1935", "443" and "80". This property will
		 * differ from <code>actualPort</code> if the requestedPort value was "any", in which case <code>actualPort</code>
		 * will return the port that was actually used.
		 * <p />
		 * This property is not available with progressive playback. 
		 * 
		 * @returns the requested port 
		 * 
		 * @default "any"
		 * 
		 * @see #actualPort
		 */
		public function get requestedPort():String {
			return _port;
		}
		/**
		 *  @private
		 */
		public function set requestedPort(p:String):void {
			if (!(p.toLowerCase() == "any" || p == "1935" || p == "80" || p == "443")) {
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,4,"Warning - this port is not supported on the Akamai network"));
			
			} 
			_port = p;
			
		}
		/**
		 * The protocol over which the class has connected. This parameter will only be returned if the class has managed to
		 * successfully connect to the server. Possible protocol values are "rtmp" or "rtmpt". This property will
		 * differ from requestedProtocol if the requestedProtocol value was "any", in which case this property will return
		 * the protocol that was actually used.
		 * 
		 * <p />
		 * This property is not available with progressive playback.
		 * 
		 * @returns the protocol over which the connection has actually been made, otherwise null.
		 * 
		 * @see #requestedProtocol
		 */
		public function get actualProtocol():String {
			return _connectionEstablished ? _nc.protocol : null;
		}
		/**
		 * The protocol over which the class was originally requested to connect via the <code>requestedProtocol</code> property.
		 * Possible requested port values are "any", "rtmp" or "rtmpt". This property will
		 * differ from <code>actualProtocol</code> if the requestedProtocol value was "any", in which case <code>actualProtocol</code>
		 * will return the protocol that was actually used.
		 * 
		 * <p />
		 * This property is not available with progressive playback.
		 * 
		 * @returns the requested protocol 
		 * 
		 * @default "any"
		 * 
		 * @see #actualProtocol
		 */
		public function get requestedProtocol():String {
			return _protocol;
		}
		/**
		 *  @private
		 */
		public function set requestedProtocol(p:String):void {
			if (!(p.toLowerCase()== "any" || p.toLowerCase() == "rtmp" || p.toLowerCase() == "rtmpt")) {
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,3,"Warning - this protocol is not supported on the Akamai network"));
			} 
			_protocol = p;
			
		}
		/**
		 * The interval in milliseconds at which the AkamaiNotificationEvent.PROGRESS is dispatched.
		 * This event commences with the first <code>play()</code> request and continues until <code>close()</code>
		 * is called. 
		 * 
		 * @returns the AkamaiNotificationEvent.PROGRESS interval in milliseconds.
		 * 
		 * @default 100
		 * 
		 * @see #play
		 * @see #close
		 */
		public function get progressInterval():Number {
			return _progressTimer.delay;
		}
		/**
		 *  @private
		 */
		public function set progressInterval(delay:Number):void {
			_progressTimer.delay = delay;
		}
		/**
		 * The bytes downloaded by the current progressive stream. This property only has meaning
		 * for progressive streams. 
		 * 
		 * @returns the bytes that have been downloaded for the current progressive stream.
		 */
		public function get bytesLoaded():Number {
			return _ns.bytesLoaded;
		}
		/**
		 * The total bytes of the current progressive stream. This property only has meaning
		 * for progressive streams. 
		 * 
		 * @returns the total bytes of the current progressive stream.
		 */
		public function get bytesTotal():Number {
			return _ns.bytesTotal;
		}

		/**
		 * The version of this class. Akamai may release updates to this class and the version number
		 * will increment with each release. 
		 * 
		 */
		public function get version():String {
			return VERSION;
		}
		/**
		 * The maximum buffer length set for the NetStream, in seconds. If <code>useFastStartBuffer</code> has
		 * been set false (the default), then this value will be used to set the constant buffer value on the NetStream. If
		 * <code>useFastStartBuffer</code> has been set true, then the NetStream buffer will alternate between 0.1
		 * (after a NetStream.Play.Start event) and the value set by this property.
		 * 
		 * @default 3
		 * 
		 * @see #useFastStartBuffer
		 * 
		 */
		public function get maxBufferLength():Number {
			return _maxBufferLength;
		}
		/**
		 * @private
		 */
		public function set maxBufferLength(length:Number):void{
			 if (length < 0.1) {
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,2,"Buffer length must be > 0.1")); 
			 } else {
				_maxBufferLength = length;
			 }
		}
		/**
		 * The bufferTime, in seconds, currently reported by the stream. This property only returns a value if the
		 * a NetStream has been created as a result of <code>createStream</code> being set true. The class will attempt
		 * to maintain the buffer at the value defined by <code>maxBufferLength</code>.
		 * 
		 * @see #createStream
		 */
		public function get bufferTime():Number {
			return _streamEstablished ? _ns.bufferTime : -1;
		}
		/**
		 * The buffer percentage currently reported by the stream. This property only returns a value if the
		 * a NetStream has been created as a result of <code>createStream</code> being set true. This property
		 * will always have an integer value between 0 and 100. The max value is capped at 100 even if the bufferLength
		 * exceeds the bufferTime.
		 * 
		 * @see #bufferTime
		 * @see #maxBufferLength
		 */
		public function get bufferPercentage():Number {
			return _streamEstablished ? Math.min(100,(Math.round(_ns.bufferLength*100/_ns.bufferTime))) : -1;
		}
		/**
		 * Defines whether the current connection is progressive or not.
		 * 
		 * @returns true if the conenction is progressive or false if not. 
		 * 
		 * @see #connect
		 */
		public function get isProgressive():Boolean {
			return _isProgressive;
		}
		/**
		 * Defines whether the current stream is a live stream. Playback of live streams requires a subscription process
		 * to be managed by the class and is handled differently from on-demand streams.<p />
		 * Note that the Fast Start buffer management feature cannot be used with live streams, since live data cannot
		 * be prebuffered. If <code>useFastStartBuffer</code> is <code>true</code> when <code>isLive</code> is set <code>true</code>,
		 * then <code>useFastStartBuffer</code> will automatically be set <code>false</code> and error event #19 dispatched.
		 * 
		 * @default false
		 * #see useFastStartBuffer
		 */
		public function get isLive():Boolean {
			return _isLive;
		}
		/**
		 * @private
		 */
		public function set isLive(isLive:Boolean):void {
			if (_useFastStartBuffer && isLive) {
				_useFastStartBuffer = false;
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,19,"The Fast Start feature cannot be used with live streams"));
			}
			_isLive = isLive;
		}
		/**
		 * The maximum number of seconds the class should wait before timing out while trying to locate a live stream
		 * on the network. This time begins decrementing the moment a <code>play</code> request is made against a live
		 * stream, or after the class receives an onUnpublish event while still playing a live stream, in which case it
		 * attempts to automatically reconnect. After this master time out has been triggered, the class will issue
		 * an Error event #9.
		 * 
		 * @default 3600
		 */
		public function get liveStreamMasterTimeout():Number {
			return _liveStreamMasterTimeout/1000;
		}
		/**
		 * @private
		 */
		public function set liveStreamMasterTimeout(numOfSeconds:Number):void {
			_liveStreamMasterTimeout = numOfSeconds*1000;
			_liveStreamTimer.delay = _liveStreamMasterTimeout;
		}
		/**
		 * Initiates a new bandwidth measurement. Note that the player for the Apple&reg; Mac OS&reg; operating system has a bug when detecting bandwidth on
		 * the latest Akamai network, so the class will call the old bandwidth detection methods when dealing with this client.
		 * To recover the estimated bandwidth value, wait for the AkamaiNotificationEvent.BANDWIDTH event and then inspect
		 * the <code>bandwidth</code> property.<p />
		 * (Apple&reg; and Mac OS&reg; are trademarks of Apple Inc., registered in the U.S. and other countries. Use of
		 * these marks is for information purposes only and is not intended to imply endorsement by Apple of
		 * Akamai products or services).
		 * 
		 * <p />
		 * This method is not available with progressive playback.
		 * 
		 * @returns true if the connection has been established, otherwise false.
		 */
		public function detectBandwidth():Boolean {
			if (_connectionEstablished) {
				if (Capabilities.version.indexOf("MAC") != -1) {
					_nc.expectBWDone = true;
					_nc.call("checkBandwidth",null);
				} else {
					// try the new bandwidth method first
					_nc.call("_checkbw",null);
				}
			}
			return _connectionEstablished 
		}
		/**
		 * Determines whether the class should create and manage a NetStream, in addition to establishing a NetConnection
		 * with the Akamai Streaming service.
		 * 
		 * @default false
		 */
		public function get createStream():Boolean {
			return _createStream;
		}
		/**
		 * @private
		 */
		public function set createStream(create:Boolean):void {
			_createStream = create;
		}
		/**
		 * Returns a reference to the active NetConnection object. This property will
		 * only return a valid reference if the connection was successful. Use this property to obtain
		 * access to NetConnection properties and methods that are not proxied by this class.
		 * 
		 * @returns the NetConnection object, or null if the connection was unsuccessful.
		 */
		public function get netConnection():NetConnection {
			return _connectionEstablished ? NetConnection(_nc): null;
		}
		/**
		 * Returns a reference to the active NetStream object. This property will
		 * only return a valid reference if <code>createStream</code> was set true prior 
		 * to <code>connect</code> being called.
		 * 
		 * @returns the NetStream object, or null if the NetStream was not established.
		 * 
		 * @see #createStream
		 */
		public function get netStream():NetStream {
			return _streamEstablished ? _ns: null;
		}
		/**
		 * Returns frames per second of the current NetStream. 
		 * 
		 */
		public function get fps():Number{
			return _streamEstablished ? _ns.currentFPS: -1;
		}
		/**
		 * Returns the number of seconds of data in the subscribing stream's buffer in live (unbuffered) mode. 
		 * This property will only return a valid reference if <code>createStream</code> was set true prior 
		 * to <code>connect</code> being called and the stream being played is a live stream. 
		 * 
		 * @see #createStream
		 * @see #isLive
		 */
		public function get liveDelay():Number{
			return (_streamEstablished  && _isLive)? _ns.liveDelay: -1;
		}
		/**
		 * Primary method for playing content on the active NetStream, if it exists. This mehthod supports both streaming
		 * and progressive playback.
		 * <p />
		 * Streaming playback:
		 * <br />
		 * The stream name argument should not include the file type extension. Examples of valid stream names include: <ul>
		 * <li>myfile</li>
		 * <li>myfolder/myfile</li>
		 * <li>my_live_stream&#64;567</li>
		 * <li>my_secure_live_stream&#64;s568</li>
		 * <li>myfolder/mp3:myfile</li>
		 * </ul>
		 * Examples of invalid stream names include:
		 * <ul>
		 * <li>myfile.flv</li>
		 * <li>myfolder/myfile.flv</li>
		 * <li>myfolder/myfile.mp3</li>
		 * </ul>
		 * <p />
		 * Progressive playback:
		 * <br />
		 * The stream name argument must be an absolute or relative path to a FLV file and must include the file
		 * extension. MP3 files cannot be played through this class using progressive playback. Ensure that the
		 * Flash player security sandbox restrictions do not prohibit the loading of the MP3 from the source
		 * being specified. Examples of valid stream arguments for progressive playback include:
		 * <ul>
		 * <li>http://myserver.mydomain.com/myfolder/myfile.flv</li>
		 * <li>myfolder/myfile.flv</li>
		 * </ul>
		 * 
		 * @param the name of the stream to play. 
		 */
		public function play(name:String):void {
			if (_streamEstablished) {
				if (!_progressTimer.running) {
					_progressTimer.start();				
				}
				_isPaused = false;
				if (_isLive) {
					if (_liveStreamAuthParams != "") {
						_pendingLiveStreamName = name.indexOf("?") != -1 ? name + "&"+_liveStreamAuthParams : name+"?"+_liveStreamAuthParams;
					} else {
						_pendingLiveStreamName = name;
					}
					_playingLiveStream = true;
					_successfullySubscribed = false;
					startLiveStream();					
				} else {
					_playingLiveStream = false;
					if (_isProgressive) {
						_ns.play(name);
					} else {
						_ns.play(name,0);
					}
					
				}
			} else {
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,8,"Cannot play, pause, seek or resume since the stream is not defined"));
			}
		}
		/**
		 * Pauses the active netStream, if it exists.
		 */
		public function pause():void {
			if (_streamEstablished) {
				_ns.pause();
				_isPaused = true;
			} else {
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,8,"Cannot play, pause, seek or resume since the stream is not defined"));
			}
		}
		/**
		 * Resumes the active netStream, if it exists.
		 */
		public function resume():void {
			if (_streamEstablished) {
				_ns.resume();
				_isPaused = false;
			} else {
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,8,"Cannot play, pause, seek or resume since the stream is not defined"));
			}
		}
		/**
		 * Seeks the active NetStream to a specific offset, if the NetStream exists.
		 * 
		 * @param the time value, in seconds, to which to seek. 
		 */
		public function seek(offset:Number):void {
			if (_streamEstablished) {
				_ns.seek(offset);
			} else {
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,8,"Cannot play, pause, seek or resume since the stream is not defined"));
			}
		}
		/**
		 * Initiates the process of unsubscribing from the active live NetStream. This method can only be called if
		 * the class is currently subscribed to a live stream. Since unsubscription is an asynchronous
		 * process, confirmation of a successful unsubscription is delivered via the AkamaiNotificationEvent.UNSUBSCRIBED event. 
		 * 
		 * @return true if previously subscribed, otherwise false.
		 */
		public function unsubscribe():Boolean {
			if (_successfullySubscribed) {
				resetAllLiveTimers();
				_playingLiveStream = false;
				_ns.play(false);
				_nc.call("FCUnsubscribe", null, _pendingLiveStreamName);
				return true;
			} else {
				return false;
			}
		}
		/**
		 * The volume of the current NetStream. Possible volume values lie between 0 (silent) and 1 (full volume).
		 * 
		 * @default 1
		 */
		public function get volume():Number{
			return _volume;
		}
		/**
		 * @private
		 */
		public function set volume(vol:Number):void {
			if (vol < 0 || vol > 1) {
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,11,"Volume value out of range"));
			} else {
				_volume = vol;
				if (_streamEstablished) {
					_ns.soundTransform = (new SoundTransform(_volume,_panning));
				}
			}
		}
		/**
		 * The panning of the current NetStream. Possible volume values lie between -1 (full left) to 1 (full right).
		 * 
		 * @default 0
		 */
		public function get panning():Number{
			return _panning;
		}
		/**
		 * @private
		 */
		public function set panning(panning:Number):void {
			if (panning < -1 || panning > 1) {
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,11,"Invalid volume parameters(s)"));
			} else {
				_panning = panning;
				if (_streamEstablished) {
					_ns.soundTransform = (new SoundTransform(_volume,_panning));
				}
			}
		}
		/**
		 * Returns the current time of the stream, in seconds. This property will only return a valid 
		 * value if the NetStream has been established.
		 */
		public function get time():Number {
			return _streamEstablished ?_ns.time : -1;
		}
		/**
		 * Returns the current time of the stream, as timecode HH:MM:SS. This property will only return a valid 
		 * value if the NetStream has been established.
		 */
		public function get timeAsTimeCode():String {
			return _streamEstablished ? timeCode(_ns.time): null;
		}
		/**
		 * Returns the buffering status of the stream. This value will be <code>true</code> after NetStream.Play.Start
		 * and before NetStream.Buffer.Full or NetStream.Buffer.Flush and <code>false</code> at all other times. 
		 */
		public function get isBuffering():Boolean {
			return _isBuffering;
		}
		/**
		 * Initiates the server request to measure the stream length of a file. Since this measurement is an asynchronous
		 * process, the stream length value can retrieved by calling the <code>streamLength</code> method after receiving 
		 * the AkamaiNotificationEvent.STREAM_LENGTH event. Note that the name of the file being measured is 
		 * decoupled from the file being played, meaning that you can request the length of one file while playing another.
		 * 
		 * @param the name of the file for which length is to be requested.
		 * 
		 * @see #streamLength
		 */
		public function requestStreamLength(filename:String):Boolean {
			if (!_connectionEstablished|| _isLive || filename == "") {
				return false;
			} else {
				_streamLength = undefined;
				// if the filename includes parameters, strip them off, since the server canot handle them.
				_nc.call("getStreamLength", new Responder(onStreamLengthResult, onStreamLengthFault), filename.indexOf("?") != -1 ? filename.slice(0,filename.indexOf("?")):filename );
				return true;
			}
		}
		/**
		 * Returns the stream length (duration) in seconds of the file specified by the last request to <code>requestStreamLength</code>. 
		 * This method can only be called after the AkamaiNotificationEvent.STREAM_LENGTH event has been received.
		 * 
		 * @return the length in seconds of the file
		 */
		public function get streamLength():Number {
				return _streamLength;
		}
		/**
		 * Returns the stream length (duration) in timecode HH:MM:SS format, of the file specified by the last request to
		 * <code>requestStreamLength</code>. This method can only be called after the
		 * AkamaiNotificationEvent.STREAM_LENGTH event has been received.
		 * 
		 * @return the length as timecode HH:MM:SS
		 */
		public function get streamLengthAsTimeCode():String{
			return _streamEstablished ? timeCode(_streamLength): null;
		}
		/**
		 * Initiates the process of extracting the ID3 information from an MP3 file. Since this process is asynchronous,
		 * the actual ID3 metadata is retrieved by listening for the AkamaiStatusEvent.MP3_ID3 and inspecting the <code>info</code> parameter.
		 * 
		 * @return false if the NetConnection has not yet defined, otherwise true. 
		 */
		public function getMp3Id3Info(filename:String):Boolean {
			if (!_connectionEstablished) {
				return false;
			} else {
				if (!(_nsId3 is NetStream)) {
					_nsId3 = new NetStream(_nc);
					_nsId3.client = this;
					_nsId3.addEventListener(Event.ID3,onId3);
					_nsId3.addEventListener(NetStatusEvent.NET_STATUS,id3StreamStatus);
	    		}
				if (filename.slice(0, 4) == "mp3:" || filename.slice(0, 4) == "id3:") {
					filename = filename.slice(4);
				}
				_nsId3.play("id3:"+filename);
				return true;
			}
		}
		/**
		 * Dictates whether a fast start (dual buffer) strategy should be used. A fast start buffer means that the
		 * NetStream buffer is set to value of 0.1 seconds after a NetStream.Play.Start or NetStream.Buffer.Empty event
		 * and then to maxBufferLength after the NetStream.Buffer.Full event is received. This gives the advantages of a
		 * fast stream start combined with a robust buffer for long-term bandwidth. Users whose connections
		 * are close to the bitrate of the stream may see very rapid stuttering of the stream with
		 * this approach, so it is best deployed in situations in which each users' bandwidth is several multiples
		 * of the streaming files' bitrate.<p />
		 * 
		 * Note that fast start cannot be used with LIVE STREAMS, since live data canot be prebuffered. If you attempt to set
		 * useFastStartBuffer to <code>true</code> when <code>isLive</code> is <code>true</code>, then error event #19
		 * "The Fast Start feature cannot be used with live streams" will be dispatched and the value will not be set.
		 * 
		 * @see maxBufferLength
		 * @see #isLive
		 */
		public function get useFastStartBuffer():Boolean {
			return _useFastStartBuffer;
		}
		/**
		 * @private
		 */
		public function set useFastStartBuffer(b:Boolean):void {
			if (_isLive && b) {
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,19,"The Fast Start feature cannot be used with live streams"));
			}else {
				_useFastStartBuffer = b;
				if (!b) {
					_ns.bufferTime = _maxBufferLength;
				}
			}
		}
		/**
		 * Closes the NetConnection and NetStream instances, if they exist.
		 * After calling this method, the API will cease to function, so this method
		 * should be the last method that is called when interacting with the class.
		 * 
		 */
		public function close():void {
			if (_streamEstablished) {
				_progressTimer.stop();
				_ns.close();
				_streamEstablished = false;
			}
			if (_connectionEstablished) {
				_nc.close();
				_connectionEstablished = false;
			}
		}
		/**
		 * Closes the NetStream instance only. This method stops playing all data on the stream,
		 * sets the time property to 0, and makes the stream available for another use.  
		 * If mutiple instances of the AkamaiConnection class are being used in a project, use this 
		 * method to close down streams as you switch playback between instances. 
		 * 
		 */
		public function closeNetStream():void {
			if (_streamEstablished) {
				_progressTimer.stop();
				_ns.close();
			}
		}
		/**
		 * Used internally by the class
		 * @private
		 */
		public function onId3( info:Object ):void
            {
                dispatchEvent(new AkamaiStatusEvent(AkamaiStatusEvent.MP3_ID3,info));
            }
		/**
		 * Catches netstream onTranstion events
		 * @private
		 */
		public function onTransition(info:Object,... args):void {
        		// no action is currently taken
    	}
    	/** Catches netstream onPlayStatus events
    	 * @private
    	 */
		public function onPlayStatus(info:Object):void {
        		dispatchEvent(new AkamaiStatusEvent(AkamaiStatusEvent.NETSTREAM_PLAYSTATUS,info));
        		if (info.code == "NetStream.Play.Complete") {
        			dispatchEvent(new AkamaiNotificationEvent(AkamaiNotificationEvent.COMPLETE)); 
        		}
    	}
    	/** Catches netstream onMetaData events and looks for duration of a progressive stream
    	 * @private
    	 */
		public function onMetaData(info:Object):void {
        		dispatchEvent(new AkamaiStatusEvent(AkamaiStatusEvent.NETSTREAM_METADATA,info));
    			if (_isProgressive && !isNaN(info["duration"])) {
    				_streamLength = Number(info["duration"]);
					dispatchEvent(new AkamaiNotificationEvent(AkamaiNotificationEvent.STREAM_LENGTH)); 
    			}
    	}
    	/** Catches netstream cuepoint events
    	 * @private
    	 */
		public function onCuePoint(info:Object):void {
        		dispatchEvent(new AkamaiStatusEvent(AkamaiStatusEvent.NETSTREAM_CUEPOINT,info));
    	}
		/** Sets default values for certain variables
		 * @private
		 */
		private function initVars():void {	
			_createStream = false;
			_maxBufferLength = 3;
			_volume = 1;
			_panning = 0;
			_liveStreamMasterTimeout = 3600000;
			_useFastStartBuffer = false;
			_isBuffering = false;
			_port = "any";
			_protocol = "any";
			_isLive = false;
			_authParams = "";
			_liveStreamAuthParams = "";
			_aboutToStop = 0;
		}
		/** Handles the responder result from a streamlength request.
		 * @private
		 */
		private function onStreamLengthResult(streamLength:Number):void {
			_streamLength = streamLength;
			dispatchEvent(new AkamaiNotificationEvent(AkamaiNotificationEvent.STREAM_LENGTH)); 
		}
		/** Handles the responder fault after a streamlength request
		 * @private
		 */
		private function onStreamLengthFault():void {
			_streamLength = undefined;
			dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,10,"Error requesting stream length"))
		}
		/** Catches IO errors when requesting IDENT xml
		 * @private
		 */
		private function catchIOError(event:IOErrorEvent):void {
			dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,5,"Unable to load XML data from ident request"));	
		}
	    /** Handles the XML return from the IDENT request
	    * @private
	    */
	    private function akamaiXMLLoaded(event:Event):void { 
				_ip = XML(_akLoader.data).ip;
				buildConnectionSequence();
				
		}
		/** Builds an array of connection strings and starts connecting
		 * @private
		 */
		private function buildConnectionSequence():void {
			var aPortProtocol:Array = buildPortProtocolSequence();
			_aConnections = new Array();
			_aNC = new Array();
			for (var a:uint = 0; a<aPortProtocol.length; a++) {
				var connectionObject:Object = new Object();
				var address:String = aPortProtocol[a].protocol+"://"+_ip+":"+aPortProtocol[a].port+"/"+_appName+"?_fcs_vhost="+_hostName+(_authParams == "" ? "":"&"+_authParams);
				connectionObject.address = address;
				connectionObject.port = aPortProtocol[a].port;
				connectionObject.protocol = aPortProtocol[a].protocol;
				_aConnections.push(connectionObject);
			}
			_timeOutTimer.reset();
			_timeOutTimer.start();
			_connectionAttempt = 0;
			_connectionTimer.reset();
			_connectionTimer.delay = _authParams == "" ? 200:350;
			_connectionTimer.start();
			tryToConnect(null);
		}
		/** Attempts to connect to FMS using a particular connection string
		 * @private
		 */
		private function tryToConnect(evt:TimerEvent):void {
			_aNC[_connectionAttempt] = new AkamaiNetConnection();
			_aNC[_connectionAttempt].addEventListener(NetStatusEvent.NET_STATUS,netStatus);
    		_aNC[_connectionAttempt].addEventListener(SecurityErrorEvent.SECURITY_ERROR,netSecurityError);
    		_aNC[_connectionAttempt].addEventListener(AsyncErrorEvent.ASYNC_ERROR,asyncError);
			_aNC[_connectionAttempt].addEventListener(AkamaiNotificationEvent.BANDWIDTH,bubbleNotificationEvent);
			_aNC[_connectionAttempt].addEventListener(AkamaiStatusEvent.FCSUBSCRIBE,onFCSubscribe);
			_aNC[_connectionAttempt].addEventListener(AkamaiStatusEvent.FCUNSUBSCRIBE,onFCUnsubscribe);
			_aNC[_connectionAttempt].client = _aNC[_connectionAttempt];
			_aNC[_connectionAttempt].index = _connectionAttempt;
			_aNC[_connectionAttempt].expectBWDone = false;
			_aNC[_connectionAttempt].port = _aConnections[_connectionAttempt].port;
			_aNC[_connectionAttempt].protocol = _aConnections[_connectionAttempt].protocol;
			_aNC[_connectionAttempt].connection = this;
			try {
			_aNC[_connectionAttempt].connect(_aConnections[_connectionAttempt].address, false);
			}
			catch (error:Error) {
				// the connectionTimer will time out and report an error.
			}
			finally {
				_connectionAttempt++;
				if (_connectionAttempt >= _aConnections.length) {
					_connectionTimer.stop();
				}
			}
		}
		/** Catches events from the AkamaiNetConnection instance and bubbles them upward.
		 * @private
		 */
		private function bubbleNotificationEvent(e:AkamaiNotificationEvent):void {
				dispatchEvent(new AkamaiNotificationEvent(e.type)); 	
		}
		/** Handles the onFCSubscribe call from the server
		 * @private
		 */
		private function onFCSubscribe(e:AkamaiStatusEvent):void {
			switch (e.info.code) {
				case "NetStream.Play.Start" :
					resetAllLiveTimers();
					_successfullySubscribed = true;
					dispatchEvent(new AkamaiNotificationEvent(AkamaiNotificationEvent.SUBSCRIBED)); 
					_ns.play(_pendingLiveStreamName,-1);
					if (_isPaused) {
						_ns.pause();
					}
					break;
				case "NetStream.Play.StreamNotFound" :
					_liveStreamRetryTimer.reset();
					_liveStreamRetryTimer.start();
					break;
				} 
		}
		/** Handles the onFCUnsubscribe call from the server
		 * @private
		 */
		private function onFCUnsubscribe(e:AkamaiStatusEvent):void {
			switch (e.info.code) {
				case "NetStream.Play.Stop":
					_successfullySubscribed = false;
					dispatchEvent(new AkamaiNotificationEvent(AkamaiNotificationEvent.UNSUBSCRIBED)) 
					if (_playingLiveStream) {
						startLiveStream();
					}
				break;
			}
		}
		/** Notifies the parent that the stream has been unsubscribed
		 * @private
		 */
		private function unsubscribedFromStream(e:AkamaiStatusEvent):void {
			dispatchEvent(new AkamaiStatusEvent(AkamaiStatusEvent.FCUNSUBSCRIBE,e.info)); 
		}
		/** Handles all status events from the NetConnections
		 * @private
		 */
		private function netStatus(event:NetStatusEvent):void {
    		if (_connectionEstablished) {
    			// only dispatch netconnection events once we have a good connection, otherwise
    			// the user receives all the close() events when the parallel unused connection attempts
    			// are shut down
    			dispatchEvent(new AkamaiStatusEvent(AkamaiStatusEvent.NETCONNECTION,event.info));
			}
			switch (event.info.code) {
				case "NetConnection.Connect.Rejected":
					handleRejection();
    				break;
				case "NetConnection.Call.Failed":
					if (event.info.description.indexOf("_checkbw") != -1) {
						event.target.expectBWDone = true;
						event.target.call("checkBandwidth",null);
					}
					break;
				case "NetConnection.Connect.Success":
					_timeOutTimer.stop();
					_connectionTimer.stop();
					for (var i:uint = 0; i<_aNC.length; i++) {
						if (i != event.target.index) {
							_aNC[i].close();
							_aNC[i] = null;
						}
					}
					_nc = AkamaiNetConnection(event.target);
					if (_createStream) {
						setupStream();
					} else {
						handleGoodConnect();
					}	
					break;
			}
  		}
		/** Assembles the array of ports and protocols to be attempted
		 * @private
		 */
		private function buildPortProtocolSequence():Array {
			var aTemp:Array = new Array();
			if (_port == "any" && _protocol == "any") {
				aTemp.push({port:"1935", protocol:"rtmp"});
				aTemp.push({port:"80", protocol:"rtmp"});
				aTemp.push({port:"443", protocol:"rtmp"});
				aTemp.push({port:"80", protocol:"rtmpt"});
				aTemp.push({port:"1935", protocol:"rtmpt"});
				aTemp.push({port:"443", protocol:"rtmpt"});
			} else if (_port == "any" && _protocol != "any") {
				aTemp.push({port:"1935", protocol:_protocol});
				aTemp.push({port:"80", protocol:_protocol});
				aTemp.push({port:"443", protocol:_protocol});
			} else if (_protocol == "any" && _port != "any") {
				aTemp.push({port:_port, protocol:"rtmp"});
				aTemp.push({port:_port, protocol:"rtmpt"});
			} else {
				aTemp.push({port:_port, protocol:_protocol});
			}
			return aTemp;
		}
		/** Catches the master timeout when no connections have succeeded within TIMEOUT.
		 * @private
		 */
		private function masterTimeout(evt:Event):void {
			for (var i:uint = 0; i<_aNC.length; i++) {
				_aNC[i].close();
				_aNC[i] = null;
			}
			dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,6,"Timed-out while trying to connect")); 
		}
		/** Handles the case when the server rejects the connection
		 * @private
		 */
		private function handleRejection():void {
			_timeOutTimer.stop();
			_connectionTimer.stop();
			for (var i:uint = 0; i<_aNC.length; i++) {
				_aNC[i].close();
				_aNC[i] = null;
			}
			dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,13,"Connection attempt rejected by server")); 
    	}
		/** Catches any netconnection net security errors
		 * @private
		 */
		private function netSecurityError(event:SecurityErrorEvent):void {
    			// no action currently taken
    	}
    	/** Catches any async errors
    	 * @private
    	 */
		private function asyncError(event:AsyncErrorEvent):void {
    	}
    	/** Creates the NetStream
    	 * @private
    	 */
		private function setupStream():void {
			_ns = new NetStream(_nc);
			_ns.bufferTime = _useFastStartBuffer ? 0.1 : _maxBufferLength;
			_ns.addEventListener(NetStatusEvent.NET_STATUS,streamStatus);
    		_ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR,asyncError);
    		_ns.addEventListener(IOErrorEvent.IO_ERROR,netStreamIOError);
    		_ns.client = this;
    		_ns.soundTransform = new SoundTransform(_volume,_panning);
    		_streamEstablished = true;
    		handleGoodConnect();
		}
		/** Handles NetStream IOError events
		 * @private
		 */
		private function netStreamIOError(event:IOErrorEvent):void {
			dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,21,"NetStream IO Error event:"+event.text)); 
		
		}
		/** Handles NetStream status events
		 * @private
		 */
		private function streamStatus(event:NetStatusEvent):void {
			dispatchEvent(new AkamaiStatusEvent(AkamaiStatusEvent.NETSTREAM,event.info));
			if (_useFastStartBuffer) {
				if (event.info.code == "NetStream.Play.Start" || event.info.code == "NetStream.Buffer.Empty") {
					_ns.bufferTime = 0.1;
				}
				if (event.info.code == "NetStream.Buffer.Full") {
					_ns.bufferTime = _maxBufferLength;
				}
			}
			switch(event.info.code) {
				case "NetStream.Play.Start":
					_aboutToStop = 0;
					_isBuffering = true;
					break;
				case "NetStream.Play.Stop":
					if (_aboutToStop == 2) {
						_aboutToStop = 0;
						handleEnd();
					} else {
						_aboutToStop = 1
					}
					break;
				case "NetStream.Buffer.Empty":
					if (_aboutToStop == 1) {
						_aboutToStop = 0;
						handleEnd();
					} else {
						_aboutToStop = 2
					}
					break;
				case "NetStream.Buffer.Full":
					_isBuffering = false;
					break;
				case "NetStream.Play.StreamNotFound":
					dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,7,"Stream not found")); 
					break;
				case "NetStream.Buffer.Flush":
					_isBuffering = false;
					break;
				case "NetStream.Failed":
					dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,22,"NetStream Failed - check your live stream auth params")); 
					break;
				case "NetStream.Play.Failed":
					dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,22,"NetStream Failed - check your live stream auth params")); 
					break;
			}
		}
	    /** Handles a id3 netStatus callback
		 * @private
		 */
		private function id3StreamStatus(e:NetStatusEvent):void {
			// Suppress the output since the netStream will report stream-not-found
		}
		/** Handles a successful connection
		 * @private
		 */
		private function handleGoodConnect():void {
			_connectionEstablished = true;
			dispatchEvent(new AkamaiNotificationEvent(AkamaiNotificationEvent.CONNECTED)); 
		}
		/** Handles the detection of the end of a stream for FCS 1.7x servers which do
		 *  not issue the NetStream.onPlayStatus.Complete event
		 * @private
		 */
		private function handleEnd():void {
			dispatchEvent(new AkamaiNotificationEvent(AkamaiNotificationEvent.END_OF_STREAM)); 
		}
		/** Catches the timeout when a live stream has been requested but cannot be found on the server
		 * @private
		 */
		private function liveStreamTimeout(e:TimerEvent):void {
			resetAllLiveTimers();
			dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,9,"Timed-out trying to find the live stream")); 
		}
		/** Utility funciton for generating time code
		 * @private
		 */
		private function timeCode(sec:Number):String {
			var h:Number = Math.floor(sec/3600);
			var m:Number = Math.floor((sec%3600)/60);
			var s:Number = Math.floor((sec%3600)%60);
			return (h == 0 ? "":(h<10 ? "0"+h.toString()+":" : h.toString()+":"))+(m<10 ? "0"+m.toString() : m.toString())+":"+(s<10 ? "0"+s.toString() : s.toString());
		}
		/** Begins subscription to a live stream
		 * @private
		 */
		private function startLiveStream():void {
			resetAllLiveTimers();
			_liveStreamTimer.start();
			fcsubscribe();
			
		}
		/** Calls FCsubscribe on the netconnection
		 * @private
		 */
		private function fcsubscribe():void {
			dispatchEvent(new AkamaiNotificationEvent(AkamaiNotificationEvent.SUBSCRIBE_ATTEMPT));
			_nc.call("FCSubscribe", null, _pendingLiveStreamName);
			_liveFCSubscribeTimer.reset();
			_liveFCSubscribeTimer.start();
		}
		/** Handles the FCSubscribe retry
		 * @private
		 */
		private function retrySubscription(e:TimerEvent):void {
			fcsubscribe();
		}
		/** Handles a non-responsive FCSubscribe method on the server
		 * @private
		 */
		private function liveFCSubscribeTimeout():void {
			resetAllLiveTimers();
			dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,12,"Network failure - unable to play the live stream")); 
		}
		/** Dispatches a progress event
		 * @private
		 */
		private function updateProgress(e:TimerEvent):void {
			dispatchEvent(new AkamaiNotificationEvent(AkamaiNotificationEvent.PROGRESS)); 
		}
		
		/** Utility method to reset all timers used in live stream subscription.
		 * @private
		 */
		private function resetAllLiveTimers():void {
			_liveStreamTimer.reset();
			_liveStreamRetryTimer.reset();
			_liveFCSubscribeTimer.reset();
			
		}
		/** Prepare all the timers that will be used by the class
		 * @private
		 */
		private function initializeTimers():void {
			// Master connection timeout
			_timeOutTimer = new Timer(TIMEOUT, 1);
			_timeOutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, masterTimeout);
			// Controls the delay between each connection attempt
			_connectionTimer = new Timer(200);
			_connectionTimer.addEventListener(TimerEvent.TIMER, tryToConnect);
			// Master live stream timeout
			_liveStreamTimer = new Timer(_liveStreamMasterTimeout, 1);
			_liveStreamTimer.addEventListener(TimerEvent.TIMER_COMPLETE, liveStreamTimeout);
			// Timeout when waiting for a response from FCSubscribe
			_liveFCSubscribeTimer = new Timer(LIVE_ONFCSUBSCRIBE_TIMEOUT,1);
			_liveFCSubscribeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, liveFCSubscribeTimeout);
			// Retry interval when calling fcsubscribe
			_liveStreamRetryTimer = new Timer(LIVE_RETRY_INTERVAL,1);
			_liveStreamRetryTimer.addEventListener(TimerEvent.TIMER_COMPLETE, retrySubscription);
			// Progress interval
			_progressTimer = new Timer(DEFAULT_PROGRESS_INTERVAL);
			_progressTimer.addEventListener(TimerEvent.TIMER, updateProgress);
		
		}
		/** Establish the progressive connection
		 * @private
		 */
		private function setUpProgressiveConnection():void {
			_isProgressive = true;
			_nc = new AkamaiNetConnection();
    		_nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR,netSecurityError);
    		_nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR,asyncError);
    		_nc.connect(null);
    		if (_createStream) {
					setupStream();
				} else {
					handleGoodConnect();
			}
			
		}
	}
}