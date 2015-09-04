package xu.love.qq.utils 
{
	
	/**把一个显示对象转成BitmapData
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class BitmapDataUtil
	{
		import flash.display.DisplayObject;
		import flash.display.Bitmap;
		import flash.display.BitmapData;
		import flash.display.GradientType
		import flash.display.Shape
		import flash.geom.Matrix;
		import flash.geom.Point;
		import flash.geom.Rectangle;
		import org.aswing.geom.IntDimension;
		
		/**
		 * 裁剪图像区域
		 * @param	_target		绘制的目标对象
		 * @param	_rect		区域
		 * @return	返回一个bitmapData
		 */
		public static function bitmapDataCut(_target:DisplayObject,_rect:Rectangle):BitmapData
		{
			var __bitmapData:BitmapData = new BitmapData(_rect.width, _rect.height,true,0x00);
			var __matix:Matrix = new Matrix();
			__matix.createBox(1, 1, 0, -_rect.x, -_rect.y);
			_rect.x = _rect.y = 0;
			__bitmapData.draw(_target, __matix, null, null, _rect);
			return __bitmapData;
		}
		/**
		 * 与上面的仅一点不同.:返回的是bitmap
		 * @param	_target
		 * @param	_rect
		 * @return
		 */
		public static function bitmapCut(_target:DisplayObject,_rect:Rectangle):Bitmap
		{
			return new Bitmap(bitmapDataCut(_target, _rect));
		}
		/**
		 * 缕空
		 * @param	bmd1 缕空对象
		 * @param	transparentcolor 缕空色
		 * @return	返回值
		 */
		public static function transparent(bmd1:BitmapData,transparentcolor:uint = 0xff00ff):BitmapData
		{
			var bitmap1:Bitmap = new Bitmap(bmd1);
			var bmd2:BitmapData = new BitmapData(bitmap1.width, bitmap1.height, true, 0x00CCCCCC);
			var pt:Point = new Point(0, 0);
			var rect:Rectangle = new Rectangle(0, 0, bitmap1.width, bitmap1.height);
			bmd2.threshold(bmd1, rect, pt, "==", transparentcolor, 0xFF0000, 0xFFFFFF, true);
			bmd1.dispose();
			return bmd2;
		}
		/**
		 * 返回指定对象绘制的指定宽高BitmapData对象
		 * @param d 绘制对象
		 * @param size 返回的BitmapData宽高
		 * @param area 只获取的对象大小
		 * @param backgroundColor 背景用来填补的颜色
		 * @return 
		*/
		static public function getBitmapDataBySize(d:DisplayObject, size:IntDimension, area:Rectangle = null, backgroundColor:int = -1):BitmapData
		{
			if(d.width < 1 || d.height < 1) return null;
			d = new Bitmap(getBitmapData(d,area));
			var s:Number = size.width/d.width < size.height/d.height ? size.width/d.width : size.height/d.height;
			
			var max:Matrix = new Matrix();
			max.scale(s,s);
			
			var p:Point = new Point();
				p.x = (size.width-d.width*s)/2;
				p.y = (size.height-d.height*s)/2;
				
			var old_bmd:BitmapData;
			old_bmd = new BitmapData(d.width*s,d.height*s,true,0xFFFFFF);
			old_bmd.draw(d,max);
			
			var new_bmd:BitmapData;
			
			if(backgroundColor == -1){
				new_bmd = new BitmapData(size.width,size.height,true,0xFFFFFF);
			}else{
				new_bmd = new BitmapData(size.width,size.height,false,backgroundColor);
			}
			
			new_bmd.copyPixels(old_bmd, new Rectangle(0, 0, old_bmd.width, old_bmd.height), p);
			return new_bmd;
		}
		/**
		 * 返回指定对象绘制的指定宽高BitmapData对象
		 * @param d 绘制对象
		 * @param w h 返回的BitmapData宽高
		 * @param area 只获取的对象大小
		 * @param backgroundColor 背景用来填补的颜色
		 * @return 
		*/
		static public function getBitmapDataBySize2(d:DisplayObject, w:uint, h:uint, area:Rectangle = null, backgroundColor:int = -1):BitmapData
		{
			if(d.width < 1 || d.height < 1) return null;
			d = new Bitmap(getBitmapData(d,area));
			var s:Number =w/d.width < h/d.height ?w/d.width : h/d.height;
			
			var max:Matrix = new Matrix();
			max.scale(s,s);
			
			var p:Point = new Point();
				p.x = (w-d.width*s)/2;
				p.y = (h-d.height*s)/2;
				
			var old_bmd:BitmapData;
			old_bmd = new BitmapData(d.width*s,d.height*s,true,0xFFFFFF);
			old_bmd.draw(d,max);
			
			var new_bmd:BitmapData;
			if(backgroundColor == -1){
				new_bmd = new BitmapData(w,h,true,0xFFFFFF);
			}else{
				new_bmd = new BitmapData(w,h,false,backgroundColor);
			}
			new_bmd.copyPixels(old_bmd,new Rectangle(0,0,old_bmd.width,old_bmd.height),p);
			return new_bmd;
		}
		/**
		 * 返回指定对象绘制的BitmapData对象
		 * @param target 需要绘制的对象
		 * @param area 绘制区域
		 * @return 绘制好的BitmapData对象，如果指定对象大小为0或者指定区域大小为0,则返回null
		 * 
		 */		
		static public function getBitmapData(target:DisplayObject,area:Rectangle = null):BitmapData{
			//如果目标对象大小为空，则返回null
			if(target == null || target.width < 1 || target.height < 1) return null;
			//如果目标对象大小为空，则返回null
			if(area != null){
				if(area.width < 1 || area.height < 1) return null;
			}
			
			var result:BitmapData;
			if(area != null && area.width > 0 && area.height > 0){
				result = new BitmapData(area.width,area.height,true,0);
			}else{
				result = new BitmapData(target.width,target.height,true,0);
			}
			if (area){ result.draw(target, new Matrix(1,0, 0, 1,-area.x,-area.y))}
			else {result.draw(target)}
			return result;
		}
		public static function BitmapEncode(img:Bitmap):String {
			var _img:BitmapData = new BitmapData(img.width, img.height, true, 0);
			_img.draw(img)
			var str:String=encode(_img)
			return str
		}
		/**
		 * 位图转 字符串
		 * @param 
		 * @return 
		*/
		public static function encode(img:BitmapData):String{
			//var a:uint = getTimer();
			var result:String = "";
			var w:uint = img.width;
			var h:uint = img.height;
			result = [w, h].toString();
			//trace(result)
			for(var i:uint = 0 ; i < h ; i ++){
				for(var j:uint = 0 ; j < w ; j++){
					var c:String = img.getPixel32(j,i).toString(16);
					if(c == "ffffffff") c = "";
					result = result + "," + c;
				}
			}
			
			return result;
		}
		/**
		 * 字符串 转 位图
		 * @param 
		 * @return 
		*/
		public static function decode(str:String):BitmapData{
			var result:BitmapData;
			var arr:Array = str.split(",");
			if(arr.length < 3) return null;
			var w:uint = uint(arr[0]);
			var h:uint = uint(arr[1]);
			
			result = new BitmapData(w,h,true,0);
			var len:uint = arr.length - 2;
			if (len != w * h) return result;
			arr.splice(0, 2)
			var _x:uint
			var _y:uint
			var c:String 
			for (var i:uint = 0 ; i < arr.length ; i ++) {
				_x = (i % w)
				_y=uint(i/w)
				c= arr[i];
				if (c == "") c = "ffffffff";
				result.setPixel32(_x,_y,uint("0x" + c));
			}
			return result;
		}
		/**
		 * 倒影对象
		 * @param 
		 * @return 
		*/
		static public function Reflection(obj:DisplayObject, alpha1:Number = 0.8, alpha2:Number = 0):Bitmap
		{ 
			//对源显示对象做上下反转处理 
			var bd:BitmapData=new BitmapData(obj.width,obj.height,true,0); 
			var mdMtx:Matrix=new Matrix(); 
			mdMtx.d=-1;mdMtx.ty=bd.height; 
			bd.draw(obj,mdMtx); 
			//生成一个渐变遮罩 
			var width:int=bd.width; 
			var height:int=bd.height; 
			mdMtx=new Matrix(); 
			mdMtx.createGradientBox(width,height,0.5 * Math.PI); 
			var shape:Shape = new Shape(); 
			shape.graphics.beginGradientFill(GradientType.LINEAR,[0,0],[alpha1,alpha2],[0,0xFF],mdMtx) 
			shape.graphics.drawRect(0,0,width,height); 
			shape.graphics.endFill(); 
			
			var mask_bd:BitmapData=new BitmapData(width,height,true,0); 
			mask_bd.draw(shape); 
			//生成最终效果 
			bd.copyPixels(bd,bd.rect,new Point(0,0),mask_bd,new Point(0,0),false); 
			//将倒影位图放在源显示对象下面 
			var ref:Bitmap = new Bitmap(); 
			ref.bitmapData=bd; 
			return ref
		}
	}
	
}