package com.koubei.ihelper.utils
{
	import cmodule.zaail.CLibInit;
	
	import com.zaalabs.zaail.ZaaILInterface;
	
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	

	
	public class FileUtils
	{
		public function FileUtils()
		{
			throw new Error("fileUtils is a static class");
		}
		
		
		private static var _loader:CLibInit;
		private static var _lib:*;
		
		
		private static function get loader():CLibInit{
			if(_loader == null)
			{
				_loader = new CLibInit();
			}
			
			return _loader;
		}
		
		private static function get lib() : Object
		{
			if(_lib == null)
			{
				_lib = loader.init();
			}
			
			return _lib;
		}
		
		public static function getBitmapDataByFile(file:File):BitmapData{
			var stream:FileStream = new FileStream();
			var ba:ByteArray = new ByteArray();
			stream.open(file, FileMode.READ);
			stream.readBytes(ba, 0, stream.bytesAvailable);
			stream.close();
			loader.supplyFile(file.name, ba);
			lib.ilInit();
			lib.ilOriginFunc(ZaaILInterface.IL_ORIGIN_UPPER_LEFT);
			lib.ilEnable(ZaaILInterface.IL_ORIGIN_SET);
			
			if(lib.ilLoadImage(file.name) != 1)	// 1 means successful load
			{
				return null;
			}
			
			var width : int = lib.ilGetInteger(ZaaILInterface.IL_IMAGE_WIDTH);
			var height : int = lib.ilGetInteger(ZaaILInterface.IL_IMAGE_HEIGHT);
			var depth : int = lib.ilGetInteger(ZaaILInterface.IL_IMAGE_DEPTH);
			var output : ByteArray = new ByteArray();
			lib.ilGetPixels(0, 0, 0, width, height, depth, output);
			output.position = 0;
			
			var bmd : BitmapData = new BitmapData(width, height);
			bmd.setPixels(new Rectangle(0, 0, width, height), output);
			return bmd;
		}
		
		public static function getFileByPath(path:String):File{
			return new File(File.applicationDirectory.resolvePath(path).nativePath);
		}
		public static function save(path:String, bytes:ByteArray):void{
			var file:File =getFileByPath(path);
			var fileStream:FileStream = new FileStream();
			try{
				fileStream.open(file, FileMode.WRITE);
				fileStream.writeBytes(bytes);
			}catch (error:Error) {
			}finally {
				fileStream.close();
			}
		}
	}
}