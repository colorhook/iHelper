package com.koubei.ihelper.controller
{
	import com.koubei.ihelper.model.ApplicationModel;
	import com.koubei.ihelper.model.OptionModel;
	import com.koubei.ihelper.services.ILogService;
	import com.koubei.ihelper.signals.FileUploadedSignal;
	import com.koubei.ihelper.signals.UploadSignal;
	import com.koubei.ihelper.utils.FileUtils;
	import com.koubei.ihelper.utils.ImageUtils;
	
	import flash.display.BitmapData;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import org.robotlegs.mvcs.Command;

	public class UploadCommand extends Command
	{
		[Inject]public var uploadSignal:UploadSignal;
		[Inject]public var appModel:ApplicationModel;
		[Inject]public var optionModel:OptionModel
		[Inject]public var logService:ILogService;
		[Inject]public var bitmapData:BitmapData;
		[Inject]public var filename:String;
		
		[Inject]public var fileUploadedSignal:FileUploadedSignal;
		
		public override function execute():void
		{
			var file:File = generateTempFile(filename);
			var request:URLRequest = new URLRequest(appModel.uploadEndpoint);
			addEventListeners(file);
			file.upload(request, appModel.uploadFieldName);
			logService.info("[UploadCommand]start upload"+file.toString());
		}
		
		private function generateTempFile(filename:String):File{
			var bytearray:ByteArray;
			if(optionModel.jpegFormat){
				bytearray = ImageUtils.toJPEG(bitmapData, optionModel.jpegQuality);
			}else{
				bytearray = ImageUtils.toPNG(bitmapData);
			}
			return FileUtils.save(filename, bytearray);
		}
		private function addEventListeners(file:File):void{
			file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onUploadComplete);
			file.addEventListener(Event.CANCEL, onUploadCancel);
			file.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			file.addEventListener(Event.OPEN, onUploadStart);
			file.addEventListener(ProgressEvent.PROGRESS, onUploaderProgress);
		}
		
		private function removeEventListeners(file:File):void{
			file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onUploadComplete);
			file.removeEventListener(Event.CANCEL, onUploadCancel);
			file.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			file.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			file.removeEventListener(Event.OPEN, onUploadStart);
			file.removeEventListener(ProgressEvent.PROGRESS, onUploaderProgress);
			try{
				file.deleteFile();
			}catch(error:Error){}
		}
		
		private function onUploadComplete(event:DataEvent):void{
			removeEventListeners(event.target as File);
			fileUploadedSignal.dispatch(event.data);
			logService.info("[UploadCommand]upload complete: "+event.data);
		}
		private function onUploadStart(event:Event):void{
			logService.info("[UploadCommand]upload start: "+event.target.toString());
		}
		private function onUploaderProgress(event:ProgressEvent):void{
			logService.info("[UploadCommand]upload progress: "+event.bytesLoaded +"/"+event.bytesLoaded);
		}
		private function onUploadCancel(event:Event):void{
			removeEventListeners(event.target as File);
			logService.info("[UploadCommand]upload cancel: "+event.target.toString());
		}
		private function onSecurityError(event:SecurityErrorEvent):void{
			removeEventListeners(event.target as File);
			logService.info("[UploadCommand]upload security error: "+event.text);
		}
		private function onIOError(event:IOErrorEvent):void{
			removeEventListeners(event.target as File);
			logService.info("[UploadCommand]upload io error: "+event.errorID);
		}
	}
}