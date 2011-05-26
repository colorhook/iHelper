package com.koubei.ihelper.utils
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.JPEGEncoder;
	import mx.graphics.codec.PNGEncoder;


	public class ImageUtils
	{
		public function ImageUtils()
		{
			throw new Error("ImageUtils is a static class");
		}
		
		public static function scaleImage(bitmapData:BitmapData, scale:Number = 1):BitmapData{
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);
			
			var bmd:BitmapData = new BitmapData(bitmapData.width * scale,
				bitmapData.height * scale, true, 0x000000);
			bmd.draw(bitmapData, matrix, null, null, null, true);
			return bmd;
		}

		public static function toJPEG(bitmapData:BitmapData, quality:Number = 80):ByteArray{
			var jpegEncoder:JPEGEncoder = new JPEGEncoder(quality);
			return jpegEncoder.encode(bitmapData);
		}
		
		public static function toPNG(bitmapData:BitmapData):ByteArray{
			var pngEncoder:PNGEncoder = new PNGEncoder();
			return pngEncoder.encode(bitmapData);
		}
	}
}