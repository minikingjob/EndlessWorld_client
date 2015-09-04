package com.core.managers {
	import com.utils.ObjectUtils;
	import com.core.AppManager;
	import com.core.handlers.Handler;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	
	/**资源加载器*/
	public class PhpLoader {
		private static var _loadedMap:Object = {};
		private var _urlLoader:URLLoader = new URLLoader();
		private var _urlRequest:URLRequest = new URLRequest();
		private var _url:String;
		private var _complete:Handler;
		private var _isCache:Boolean;
		private var _isLoading:Boolean;
		
		public function PhpLoader() {			
			_urlLoader.addEventListener(Event.COMPLETE, onComplete);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onStatus);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		}
		
		/**中止加载*/
		public function tryToCloseLoad():void {
			try {
				_urlLoader.close();
				AppManager.timer.clearTimer(checkLoad);
				_isLoading = false;
			} catch (e:Error) {
			}
		}
		
		private function doLoad():void {
			_isLoading = true;
			//加随机数，避免取缓存数据
			if (_urlRequest.method == URLRequestMethod.POST) {
				_urlRequest.url += "?l=" + Math.random();
			}else {
				var tmpArr:Array = _urlRequest.url.split("?");
				if (tmpArr.length <= 1) _urlRequest.url += "?l=" + Math.random();
				else _urlRequest.url += "&l=" + Math.random();
			}
			_urlLoader.load(_urlRequest);
		}
		
		private function onStatus(e:HTTPStatusEvent):void {
		
		}
		
		private function onError(e:Event):void {
			AppManager.log.error("Load Error:", e.toString());
			endLoad(null);
		}
		
		private function onComplete(e:Event):void {
			var content:* = null;
			
			content = _urlLoader.data;
			if (_isCache) {
				_loadedMap[_url] = content;
			}
			endLoad(content);
		}
		
		private function endLoad(content:*):void {
			AppManager.timer.clearTimer(checkLoad);
			_isLoading = false;
			if (_complete != null) {
				var handler:Handler = _complete;
				_complete = null;
				handler.executeWith([content]);
			}
		}
		
		/**加载资源*/
		public function load(urlRequest:URLRequest, complete:Handler, isCache:Boolean = false):void {
			if (_isLoading) {
				AppManager.log.warn("Loader is try to close.", _url);
				tryToCloseLoad();
			}
			
			_urlRequest = urlRequest;
			_complete = complete;
			_isCache = isCache;
			_url = _urlRequest.url;
			
			var content:* = getResLoaded(_url);
			if (content != null) {
				return endLoad(content);
			}
			AppManager.timer.doLoop(10000, checkLoad);
			doLoad();
		}
		
		/**如果10秒没有获取到数据，则停止获取，返回null*/
		private function checkLoad():void {
			tryToCloseLoad();
			endLoad(null);
		}
		
		/**获取已加载的资源*/
		public static function getResLoaded(url:String):* {
			return _loadedMap[url];
		}
		
		/**设置资源*/
		public static function setResLoaded(url:String, content:*):void {
			_loadedMap[url] = content;
		}
		
		/**删除已加载的资源*/
		public static function clearResLoaded(url:String):void {
			var res:Object = _loadedMap[url];			
			delete _loadedMap[url];
		}
		
		/**加载资源的地址*/
		public function get url():String {
			return _url;
		}
	}
}