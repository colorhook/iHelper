package com.koubei.ihelper.controller
{
	import cmodule.zaail.CLibInit;
	
	import com.koubei.ihelper.services.ILogService;
	import com.koubei.ihelper.signals.FileSelectedSignal;
	import com.zaalabs.zaail.ZaaILInterface;
	
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import org.robotlegs.mvcs.Command;
	
	public class OpenImageCommand extends Command
	{
		
		private static var _loader:CLibInit;
		private static var _lib:*;
		
		[Inject]
		public var logService:ILogService;
		
		
		public override function execute():void{
			var file : File;
			var stream : FileStream;
			var ba : ByteArray;
			
			//if(event.files && event.files.length > 0)
		}
		
		private function getBitmapDataByFile(file:File):BitmapData{
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
				logService.error("Could not load the selected image:"+file.toString());
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

	}
}