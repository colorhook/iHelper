package com.koubei.ihelper.controller
{
	import com.koubei.ihelper.model.ImageModel;
	import com.koubei.ihelper.services.ILogService;
	import com.koubei.ihelper.signals.FileSelectedSignal;
	import com.koubei.ihelper.signals.ImageLoadedSignal;
	import com.koubei.ihelper.utils.FileUtils;
	
	import flash.display.BitmapData;
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Command;
	
	public class OpenImageCommand extends Command
	{
		
		[Inject]public var logService:ILogService;
		[Inject]public var imageModel:ImageModel;
		[Inject]public var files:Array;
		[Inject]public var imageLoadedSignal:ImageLoadedSignal;
		
		public override function execute():void{
			logService.info("[OpenImageCommand] execute");
			var items:Array = [];
			for(var i:uint = 0, l:uint = files.length; i < l ;i++){
				var bmd:BitmapData = FileUtils.getBitmapDataByFile(files[i]);
				imageLoadedSignal.dispatch(bmd);
				if(bmd){
					items.push({file:files[i], bitmapData: bmd});
				}
			}
			//imageModel.addItems(items);
		}
		
		
		
		

	}
}