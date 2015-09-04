package xu.love.qq.mvc.model 
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import org.aswing.BoundedRangeModel;
	import org.aswing.DefaultBoundedRangeModel;
	
	import xu.love.qq.geom.Song;
	import xu.love.qq.mvc.AppConst;
	
	
	/**
	 * ...
	 * MP3播放管理核心
	 * @author tangzx <xu love qq>
	 */
	public class MP3PlayCoreProxy extends BasicProxy
	{
		public static const NAME:String = "MP3PlayCoreProxy";
		
		private var _mainSd:Sound;
		private var _mainCh:SoundChannel;
		/**
		 * 是不是已停止
		 */
		private var _isStop:Boolean = true;
		/**
		 * 是不是已暂住
		 */
		private var _isPause:Boolean = false;
		/**
		 * 记录当前播放头位置
		 */
		private var _currentTime:Number = 0;
		/**
		 * 设置音量用
		 */
		private var _soundTransform:SoundTransform = new SoundTransform(0.7);
		
		private var _currentSong:Song;
		
		private var timeModel:BoundedRangeModel = new DefaultBoundedRangeModel;
		
		private var tempShape:Shape = new Shape;
		
		public function MP3PlayCoreProxy() 
		{
			super(NAME);
		}
		
		public function playSong(s:Song):void {
			_currentSong = s;
			stop();
			if (_mainSd) {
				_disposeSound(_mainSd);
			}
			
			_mainSd = _createSound();
			_mainSd.load(new URLRequest(s.getMp3Url()));
			_stopChannel();
			_currentTime = 0;
			this.play();
			this.sendNotification(AppConst.SYS_ON_PLAY, s);
		}
		
		
		
		/**
		 * 播放当前声音对象
		 */
		public function play():void
		{
			_mainCh = _playSD(getCurrentTime());
			_isPause = false;
			_isStop = false;
			tempShape.addEventListener(Event.ENTER_FRAME, __soundPlayProgress);
			//EnterFrameManager.add(__soundPlayProgress);
			__onStatusChange();
		}
		
		
		
		/**
		 * 暂停
		 */
		public function pause():void {
			_isPause = true;
			if (_mainCh) {
				tempShape.removeEventListener(Event.ENTER_FRAME, __soundPlayProgress);
				//EnterFrameManager.del(__soundPlayProgress);
				_stopChannel();
				__onStatusChange();
			}
		}
		
		
		
		/**
		 * 停止播放
		 */
		public function stop():void {
			_isStop = true;
			this._stopChannel();
			tempShape.addEventListener(Event.ENTER_FRAME, __soundPlayProgress);
			//EnterFrameManager.del(__soundPlayProgress);
			__onStatusChange();
		}
		
		
		
		/**
		 * 跳到进度播放
		 * @param	percent
		 */
		public function seek(percent:Number, isProgrammatic:Boolean = true):void {
			_mainCh = _playSD(getTotalTime() * percent);
			if (isPause()) {
				this._stopChannel();
			}
		}
		
		
		/**
		 * 声音的总时长 毫秒
		 * @return
		 */
		public function getTotalTime():Number {
			if (_mainSd.bytesLoaded == 0) {
				return Number.MAX_VALUE;
			}
			return _mainSd.length * _mainSd.bytesTotal / _mainSd.bytesLoaded;
		}
		
		
		/**
		 * 当前时间
		 * @return
		 */
		public function getCurrentTime():Number {
			if (!isPause()) {
				if(_mainCh)
					_currentTime = _mainCh.position;
			}
			return _currentTime;
		}
		
		
		
		/**
		 * 设置音量
		 * @param	percent
		 */
		public function setVolume(percent:Number, isProgrammatic:Boolean = true):void {
			_soundTransform.volume = Math.max(0, Math.min(1, percent));
			if (_mainCh)
				_mainCh.soundTransform = _soundTransform;
			
			this.sendNotification(AppConst.SD_VOLUME, getVolume());
		}
		
		
		
		public function getVolume():Number {
			return _soundTransform.volume;
		}
		
		/**
		 * 是否在播放中
		 */
		public function isPlay():Boolean {
			return !_isStop && !_isPause;
		}
		
		
		
		/**
		 * 是否在暂停中
		 */
		public function isPause():Boolean {
			return _isPause;
		}
		
		
		/**
		 * 是否已停止
		 */
		public function isStop():Boolean {
			return _isStop;
		}
		
		
		/**
		 * 生成一个已初始化的声音对象
		 * @return
		 */
		private function _createSound():Sound {
			var _sd:Sound = new Sound;
			_sd.addEventListener(Event.COMPLETE,			__onSoundLoadComplete);
			_sd.addEventListener(ProgressEvent.PROGRESS,	__onSoundProgress);
			_sd.addEventListener(IOErrorEvent.IO_ERROR,		__onSoundLoadError);
			return _sd;
		}
		
		
		
		private function _disposeSound(sd:Sound):void {
			try{
				sd.close();
			} catch(e:*){
				
			}
			sd.removeEventListener(Event.COMPLETE,			__onSoundLoadComplete);
			sd.removeEventListener(ProgressEvent.PROGRESS,	__onSoundProgress);
			sd.removeEventListener(IOErrorEvent.IO_ERROR,	__onSoundLoadError);
		}
		
		
		
		private function _playSD(time:Number):SoundChannel {
			if (_mainCh) {
				_mainCh.stop();
				_mainCh.removeEventListener(Event.SOUND_COMPLETE,	__onSoundPlayComplete);
			}
			
			_mainCh = _mainSd.play(time);
			_mainCh.soundTransform = _soundTransform;
			_mainCh.addEventListener(Event.SOUND_COMPLETE,	__onSoundPlayComplete);
			return _mainCh;
		}
		
		
		
		private function _stopChannel():void {
			if (_mainCh) {
				_currentTime = _mainCh.position;
				_mainCh.stop();
			}else
				_currentTime = 0;
			_mainCh = null;
		}
		
		
		
		/**
		 * 声音播放完成时
		 * @param	e
		 */
		private function __onSoundPlayComplete(e:Event):void 
		{
			stop();
			this.sendNotification(AppConst.SYS_NEXT);
		}
		
		
		
		/**
		 * 声音加载的过程
		 * @param	e
		 */
		private function __onSoundProgress(e:ProgressEvent):void 
		{
			
		}
		
		
		/**
		 * 声音加载出错。下一首
		 * @param	e
		 */
		private function __onSoundLoadError(e:IOErrorEvent):void {
			_currentSong.setInvalidURL(true);
			//this.sendNotification(AppConst.SYS_NEXT);
		}
		
		
		
		/**
		 * 加载完成，非播放完成
		 * @param	e
		 */
		private function __onSoundLoadComplete(e:Event):void {
			//加载完成
			
		}
		
		
		/**
		 * 一旦播放，不停的发送播放进度信息
		 */
		private function __soundPlayProgress(e:Event = null):void {
			this.sendNotification(AppConst.SD_PLAY_PROGRESS);
		}
		
		
		private function __onStatusChange():void {
			this.sendNotification(AppConst.SD_STATUS_CHANGE);
		}
		
		/**
		 * 获取播放状态 
		 * @return 
		 * 
		 */		
		public function getStatus():String{
			var s:String = "停止";
			if(!isStop()){
				s = isPlay() ? "播放" : "暂停";
			}
			return s;
		}
		
		
		public function getCurrentSong():Song{
			return _currentSong;
		}
		
		
		public function getTimeModel():BoundedRangeModel{
			return timeModel;
		}
		
	}
	
}