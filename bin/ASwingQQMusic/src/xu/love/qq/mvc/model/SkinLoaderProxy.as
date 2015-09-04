package xu.love.qq.mvc.model 
{
	import com.riaidea.utils.zip.ZipArchive;
	import com.riaidea.utils.zip.ZipFile;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import xu.love.qq.mvc.AppConst;
	import xu.love.qq.utils.BMPDecoder;
	import xu.love.qq.utils.BitmapDataUtil;
	
	
	
	/**
	 * ...
	 * @author tangzx <xu love qq>
	 */
	public class SkinLoaderProxy extends BasicProxy
	{
		public static function getInstance():SkinLoaderProxy {
			return instance;
		}
		public static var instance:SkinLoaderProxy;
		
		public static const NAME:String = "SkinProxy";
		
		public function SkinLoaderProxy(data:Object = null) 
		{
			instance = this;
			
			super(NAME, data);
		}
		
		//zip
		private var zip:ZipArchive;	
		//XML配置文件
		private var skinXML:XML;
		private var listXML:XML;
		private var lrcXML:XML;
		//缕空色
		private var tnpetColor:Number;	
		//BMP解析
		private var bmpDecoder:BMPDecoder = new BMPDecoder;
		//当前解析索引
		private var decodeIndex:int = 0;
		//一帧解析几个
		private var decodeCount:int = 10;
		//解析完成的BMP
		private var bmpMap:Object =  { };
		private var ready:Boolean;
		
		/**
		 * 加载皮肤文件
		 * @param	url
		 */
		public function loadSkin(data:ByteArray):void {
			data.endian = Endian.LITTLE_ENDIAN;
			zip = new ZipArchive;
			zip.open(data);
			ready = false;
			
			//清空BMP池
			/*for(var k:String in bmpMap){
			bmpMap[k].dispose();
			}*/
			bmpMap = new Object;
			
			skinXML = this.fixXML(getZipFileByName("skin.xml").data.toString());
			listXML = parseXML(getZipFileByName("playlist.xml").data.toString());
			lrcXML = parseXML(getZipFileByName("lyric.xml").data.toString());
			//缕空色
			tnpetColor = Number(skinXML.@transparent_color.split("#").join("0x"));
			//解析索引计数
			decodeIndex = 0;
			//线程式解析BMP
			decodeBMP();
			//EnterFrameManager.add(decodeBMP);
		}
		
		/**
		 * 解析BMP
		 */
		private function decodeBMP():void
		{
			decodeCount = zip.numFiles;
			for (var c:int = 0; c < decodeCount; c++) {
				var zipFile:ZipFile = zip.getFileAt(c);
				var zipName:String = zipFile.name.toLocaleLowerCase();
				if (zipName.indexOf(".bmp") != -1) {
					var bitmap:BitmapData = bmpDecoder.decode(zipFile.data);
					bmpMap[zipName] = BitmapDataUtil.transparent(bitmap, tnpetColor);
				}
				
				/*decodeIndex++;
				
				if (decodeIndex >= zip.numFiles) {
					EnterFrameManager.del(decodeBMP);
					ready = true;
					//完成
					this.sendNotification(AppConst.SYS_SKIN_LOAD_COMPLETE);
					return;
				}*/
			}
			ready = true;
			//完成
			this.sendNotification(AppConst.SYS_SKIN_LOAD_COMPLETE);
		}
		
		
		
		/**
		 * 忽略大小写名称取file
		 * @param	name
		 * @return
		 */
		public function getZipFileByName(name:String):ZipFile {
			for (var i:Number = 0; i < zip.numFiles; i++) {
				if (name.toLocaleLowerCase() == zip.getFileAt(i).name.toLocaleLowerCase()) {
					return zip.getFileAt(i);
				}
			}
			return null;
		}
		
		
		public function getBitmap(libName:String):BitmapData {
			libName = libName.toLocaleLowerCase();
			var bmp:BitmapData = bmpMap[libName] as BitmapData;
			if(bmp)
				return bmp.clone();
			return bmpMap[libName];
		}
		
		
		/**
		 * 防止解析错误
		 * 将 <startup interval=4 /> 类型的改正成
		 * <startup interval="4" />
		 */
		private function fixXML(xmlString:String):XML {
			var reg:RegExp = /= *([^\"'])+[ |\/]/;
			return new XML(xmlString.replace(reg, "=\"$1\" ").toLocaleLowerCase());
		}
		
		private function parseXML(str:String):XML{
			return new XML(str.toLocaleLowerCase());
		}
		
		public function getSkinXml():XML {
			return skinXML;
		}
		
		public function getListXml():XML{
			return listXML;
		}
		
		public function getLyricXML():XML{
			return lrcXML;
		}
	}
	
}