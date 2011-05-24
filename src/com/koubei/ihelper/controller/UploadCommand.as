package com.koubei.ihelper.controller
{
	import com.koubei.ihelper.model.ApplicationModel;
	import com.koubei.ihelper.services.ILogService;
	import com.koubei.ihelper.signals.UploadSignal;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	import flex.lang.reflect.Field;
	
	import org.robotlegs.mvcs.Command;
	
	public class UploadCommand extends Command
	{
		[Inject]public var uploadSignal:UploadSignal;
		[Inject]public var appModel:ApplicationModel;
		[Inject]public var logService:ILogService;
		
		public function execute():void
		{
			var file:File = uploadSignal.file;
			var request:URLRequest = new URLRequest(appModel.uploadEndpoint);
			addEventsToFile(file);
			file.upload(request, appModel.uploadFieldName);
			logService.info("[UploadCommand]start upload"+file.toString());
		}
		
		private function addEventsToFile(file:File):void{
			file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onUploadComplete);
			file.addEventListener(Event.CANCEL, onUploadCancenl);
			file.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			file.addEventListener(Event.OPEN, onUploadStart);
			file.addEventListener(ProgressEvent.PROGRESS, onUploaderProgress);
		}
		
		private function removeEventListener(file:File):void{
			file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onUploadComplete);
			file.removeEventListener(Event.CANCEL, onUploadCancenl);
			file.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			file.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			file.removeEventListener(Event.OPEN, onUploadStart);
			file.removeEventListener(ProgressEvent.PROGRESS, onUploaderProgress);
		}
		
		private function onUploadComplete(event:DataEvent):void{
			removeEventListener(event.target);
			logService.info("[UploadCommand]upload complete"+event.target.toString());
		}
		private function onUploadStart(event:Event):void{
			removeEventListener(event.target);
			logService.info("[UploadCommand]upload start"+event.target.toString());
		}
		private function onUploaderProgress(event:ProgressEvent):void{
			removeEventListener(event.target);
			logService.info("[UploadCommand]upload progress"+event.target.toString());
		}
		private function onUploadCancel(event:Event):void{
			removeEventListener(event.target);
			logService.info("[UploadCommand]upload cancel"+event.target.toString());
		}
		private function onSecurityError(event:SecurityErrorEvent):void{
			removeEventListener(event.target);
			logService.info("[UploadCommand]upload security error"+event.target.toString());
		}
		private function onIOError(event:IOErrorEvent):void{
			removeEventListener(event.target);
			logService.info("[UploadCommand]upload io error"+event.target.toString());
		}
	}
}