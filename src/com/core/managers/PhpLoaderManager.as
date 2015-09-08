package com.core.managers 
{
	import com.core.AppManager;
	import com.core.handlers.Handler;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author minichen
	 */
	public class PhpLoaderManager extends EventDispatcher
	{
		private static var _instance:PhpLoaderManager;
		public static function get instance():PhpLoaderManager {
			if (!_instance)_instance = new PhpLoaderManager();
			return _instance;
		}		
		public function PhpLoaderManager() {}
		
		/********************************************************
		 * 变量
		 * ******************************************************
		 */
		//线性加载队列
		private var _phpLoader:PhpLoader = new PhpLoader();		
		//存储加载队列
		private var _phpInfos:Array = [];
		
		private var _isLoading:Boolean;
		private var _urlRequest:URLRequest = new URLRequest();
		private var _retryNum:int = 1;
		private var _failRes:Object = {};
		
		/**
		 * 调用php
		 * @param	type		一般选择"GET"或"POST"两种方式
		 * @param	url			php地址
		 * @param	jsonStr		参数
		 * @param	complete	加载完成回调
		 * @param	error		加载错误回调
		 * @param	isCache		是否缓存加载结果
		 */
		public function phpCall(type:String, url:String, jsonStr:String, complete:Handler, error:Handler, isCache:Boolean = false):void {	
			var phpInfo:PhpInfo = new PhpInfo();
			phpInfo.type = type;
			phpInfo.url = url;
			phpInfo.paramJson = jsonStr;
			phpInfo.complete = complete;
			phpInfo.error = error;
			phpInfo.isCacheContent = isCache;	
			
			var content:* = ResLoader.getResLoaded(phpInfo.url);
			if (content != null) {
				endLoad(phpInfo, content);
			} else {
				_phpInfos.push(phpInfo);
				checkNext();
			}
		}
		
		private function checkNext():void {
			var key:String;	
			if (_isLoading) {
				return;
			}
			_isLoading = true;
			while (_phpInfos.length > 0) {
				var phpInfo:PhpInfo = _phpInfos.shift();
				var content:* = PhpLoader.getResLoaded(phpInfo.url);
				if (content != null) {
					endLoad(phpInfo, content);
				} else {
					_urlRequest.url = phpInfo.url;
					_urlRequest.method = phpInfo.type;
					var jsonObj:Object = { };
					if(phpInfo.paramJson != "" && phpInfo.paramJson != null){
						try {
							jsonObj = JSON.parse(phpInfo.paramJson);						
						}catch (e:Error) {
							AppManager.log.error("Load Error:phpCall param error."+phpInfo.paramJson);
							continue;
						}
					}
					if(_urlRequest.method == "POST"){
						var urlVariable:URLVariables = new URLVariables();					
						for(key in jsonObj) {
							urlVariable[key] = JSON.stringify(jsonObj[key]);
							trace(key, JSON.stringify(jsonObj[key]));
						}
						_urlRequest.data = urlVariable;
					}else {
						var count:int = 0;
						for(key in jsonObj) {
							if(count <= 0)_urlRequest.url += ("?" +key + "=" + jsonObj[key]);
							else _urlRequest.url += ("&" +key + "=" + jsonObj[key]);
						}
					}
					
					_phpLoader.load(_urlRequest, new Handler(loadComplete, [phpInfo]), phpInfo.isCacheContent);					
					return;
				}
			}
			_isLoading = false;
			if (hasEventListener(Event.COMPLETE)) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		private function loadComplete(phpInfo:PhpInfo, content:*):void {
			endLoad(phpInfo, content);
			_isLoading = false;
			checkNext();
		}
		
		private function endLoad(phpInfo:PhpInfo, content:*):void {
			//如果加载后为空，放入队列末尾重试
			if (content == null) {
				var errorCount:int = _failRes[phpInfo.url] || 0;
				if (errorCount < _retryNum) {
					_failRes[phpInfo.url] = errorCount + 1;
					_phpInfos.push(phpInfo);
					return;
				} else {
					AppManager.log.warn("load error:", phpInfo.url);
					if (phpInfo.error != null) {
						phpInfo.error.executeWith([phpInfo.url]);
						return;
					}
				}
			}
			if (phpInfo.complete != null) {
				phpInfo.complete.executeWith([content]);
			}
		}
		
		/**删除已加载的资源*/
		public function clearResLoaded(url:String):void {
			PhpLoader.clearResLoaded(url);
		}
		
		/**尝试关闭加载*/
		public function tryToCloseLoad(url:String):void {
			if (_phpLoader.url == url) {
				_phpLoader.tryToCloseLoad();
				_isLoading = false;
				checkNext();
			}
		}
		
		/**停止并清理当前未完成的加载*/
		public function stopAndClearLoad():void {
			_phpInfos.length = 0;
			_phpLoader.tryToCloseLoad();
			_isLoading = false;
		}
		
		/**加载出错后的重试次数，默认重试一次*/
		public function get retryNum():int {
			return _retryNum;
		}
		
		public function set retryNum(value:int):void {
			_retryNum = value;
		}
			
	}

}

import com.core.handlers.Handler;

class PhpInfo {
	public function PhpInfo() {
	}
	public var type:String;
	public var url:String;
	public var paramJson:String;
	public var complete:Handler;
	public var error:Handler;
	public var isCacheContent:Boolean;
}