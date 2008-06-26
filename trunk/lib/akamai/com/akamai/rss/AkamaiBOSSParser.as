package com.akamai.rss{

	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import com.akamai.rss.*;
	import com.akamai.events.*;
	import flash.xml.XMLNode;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * Dispatched when an error condition has occurred. The event provides an error number and a verbose description
	 * of each error. The errors thrown by this class include:
	 * <table>
	 * <tr><th> Error Number</th><th>Description</th></tr>
	 * <tr><td>14</td><td>HTTP loading operation failed</td></tr>
	 * <tr><td>15</td><td>XML is not well formed</td></tr>
	 * <tr><td>17</td><td>Class is busy and cannot process your request</td></tr>
	 * <tr><td>18</td><td>XML does not conform to BOSS standard</td></tr>
	 * <tr><td>20</td><td>Timed out trying to load the XML file</td></tr>
	 * </table>
	 * 
	 * @eventType com.akamai.events.AkamaiErrorEvent.ERROR
	 */
 	[Event (name="error", type="com.akamai.events.AkamaiErrorEvent")]
	/**
	 * Dispatched when the BOSS xml response has been successfully loaded. 
	 * 
	 * @eventType com.akamai.events.AkamaiNotificationEvent.LOADED
	 */
 	[Event (name="loaded", type="com.akamai.events.AkamaiNotificationEvent")]
	/**
	 * Dispatched when the BOSS xml response has been successfully parsed. 
	 * 
	 * @eventType com.akamai.events.AkamaiNotificationEvent.PARSED
	 */
 	[Event (name="parsed", type="com.akamai.events.AkamaiNotificationEvent")]
 	
	/**
	 *  The AkamaiBOSSParser class loads and parses an XML feed from the Akamai StreamOS BOSS service.
	 *  These feeds have the following data structure:<p />
	 * <listing version="3.0">
	 *  &lt;FLVPlayerConfig&gt;
	 *   &lt;stream&gt;
	 *	  &lt;entry&gt;
	 *      &lt;serverName&gt;cpxxxxx.edgefcs.net&lt;/serverName&gt;
	 *      &lt;appName&gt;ondemand&lt;/appName&gt;
	 *      &lt;streamName&gt;&lt;![CDATA[xxxxx/6c/04/6c0442cadf77337d43a89fc56d2b28f9-461c1402]]/&gt;&lt;/streamName>
	 *      &lt;isLive&gt;false&lt;/isLive&gt;
	 *      &lt;bufferTime&gt;2&lt;/bufferTime&gt;
	 *    &lt;/entry&gt;
	 *  &lt;/stream&gt;
	 * &lt;/FLVPlayerConfig&gt;
	 * </listing>
	 *
	 */
	public class AkamaiBOSSParser extends EventDispatcher {

		// Declare vars
		private var _xml:XML;
		private var _rawData:String;
		private var _serverName:String;
		private var _appName:String;
		private var _streamName:String;
		private var _isLive:Boolean;
		private var _bufferTime:Number;
		private var _busy:Boolean;
		private var _timeoutTimer:Timer;
		
		//Declare constants
		public const VERSION:String = "1.0";
		private const TIMEOUT_MILLISECONDS:uint= 15000;

		/**
		 * Constructor
		 * @private
		 */
		public function AkamaiBOSSParser():void {
			_busy = false;
			_timeoutTimer = new Timer(TIMEOUT_MILLISECONDS,1);
			_timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,doTimeOut);
		}
		/**
		 * Loads a BOSS feed and initiates the parsing process.
		 * 
		 * @return true if the load is initiated otherwise false if the class is busy
		 * 
		 * @see isBusy
		 */
		public function load(src:String):Boolean {
			if (!_busy) {
				_busy = true;
				_timeoutTimer.reset();
				_timeoutTimer.start();
				var xmlLoader:URLLoader = new URLLoader();
				xmlLoader.addEventListener("complete",xmlLoaded);
				xmlLoader.addEventListener(IOErrorEvent.IO_ERROR,catchIOError);
				xmlLoader.load(new URLRequest(src));
				return true;
			} else {
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,17,"Class is busy and cannot process your request"));
				return false;
			}
		}
		/**
		 * The raw data string returned by the BOSS service. This value will still
		 * be populated even if the data is not well-formed XML, to assist with debugging.
		 * 
		 */
		public function get rawData():String {
			return _rawData;
		}
		/**
		 * The BOSS feed as an XML object. 
		 * 
		 */
		public function get xml():XML {
			return _xml;
		}
		/**
		 * The Akamai hostname, in the form cpxxxxx.edgefcs.net
		 * 
		 */
		public function get serverName():String{
			return _serverName;
		}
		/**
		 * The Akamai application name
		 * 
		 */
		public function get appName():String {
			return _appName;
		}
		/**
		 * The stream name
		 * 
		 */
		public function get streamName():String {
			return _streamName;
		}
		/**
		 * The Akamai Hostname, a concatenation of the server and application names
		 * 
		 */
		public function get hostName():String {
			return _serverName+"/"+_appName;
		}
		/**
		 * Boolean parameter indicating whether the stream is live or not
		 * 
		 */
		public function get isLive():Boolean {
			return _isLive;
		}
		/**
		 * Boolean parameter indicating whether the class is already busy loading a feed. Since the 
		 * load is asynchronous, the class will not allow a new <code>load()</code> request until
		 * the prior request has ended.
		 * 
		 */
		public function get isBusy():Boolean {
			return _busy;
		}
		/**
		 * The buffer time designated for this stream
		 * 
		 */
		public function get bufferTime():Number {
			return _bufferTime;
		}
		/** Catches the time out of the initial load request.
		  * @private
		  */
		private function doTimeOut(e:TimerEvent):void {
			trace(" boss timed out");
			dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,20,"Timed out trying to load the XML file"));
		}
		/** Handles the XML request response
		 * @private
		 */
		private function xmlLoaded(e:Event):void {
			_timeoutTimer.stop();
			_rawData=e.currentTarget.data.toString();
			try {
				_xml=XML(_rawData);
				dispatchEvent(new AkamaiNotificationEvent(AkamaiNotificationEvent.LOADED));
				parseXML();
			} catch (err:Error) {
				_busy = false;
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,15,"XML is not well formed"));
			}
		}
		/** Parses the RSS xml feed into useful properties
		 * @private
		 */
		private function parseXML():void {
			_busy = false;
			if (!verifyRSS(_xml)) {
				dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,18,"XML does not conform to BOSS standard"));
			} else {
				_serverName = _xml.stream.entry.serverName;
				_appName = _xml.stream.entry.appName;
				_streamName = _xml.stream.entry.streamName;
				_isLive = _xml.stream.entry.isLive.toString().toUpperCase() == "TRUE";
				_bufferTime = Number(xml.stream.entry.bufferTime);
				dispatchEvent(new AkamaiNotificationEvent(AkamaiNotificationEvent.PARSED));
			}
		}
		/** A simple verification routine to check if the XML received conforms
		 * to some basic BOSS requirements. This routine does not validate against
		 * any DTD.
		 * @private
		 */
		private function verifyRSS(src:XML):Boolean {
			return !(src.stream.entry.serverName == undefined || src.stream.entry.appName == undefined || src.stream.entry.streamName == undefined || src.stream.entry.isLive == undefined  || src.stream.entry.bufferTime == undefined  );
		}

		/** Catches IO errors when requesting the xml 
		 * @private
		 */
		private function catchIOError(e:IOErrorEvent):void {
			_busy = false;
			_timeoutTimer.stop();
			dispatchEvent(new AkamaiErrorEvent(AkamaiErrorEvent.ERROR,14,"HTTP loading operation failed"));
		}
	}
}