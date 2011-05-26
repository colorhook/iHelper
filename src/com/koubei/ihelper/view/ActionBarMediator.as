package com.koubei.ihelper.view
{
	import com.koubei.ihelper.model.ImageModel;
	import com.koubei.ihelper.services.ILogService;
	import com.koubei.ihelper.signals.*;
	import com.koubei.ihelper.signals.FileSelectedSignal;
	import com.zaalabs.zaail.ZaaILInterface;
	
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	
	import org.osflash.signals.Signal;
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Mediator;
	
	public class ActionBarMediator extends Mediator
	{
		[Inject]public var view:ActionBar;
		[Inject]public var logService:ILogService;
		[Inject]public var fileSelectedSignal:FileSelectedSignal;
		[Inject]public var uploadSignal:UploadSignal;
		[Inject]public var imageModel:ImageModel;
		[Inject]public var imageSelectedChangeSignal:ImageSelectedChangeSignal;
		
		private var browseClickedSignal:NativeSignal;
		private var uploadClickedSignal:NativeSignal;
		
		private var _fileToAdd : File;
		private static const SELECT_SOURCE:String="选择图片";
		
		public function ActionBarMediator()
		{
			super();
		}
		
		
		public override function onRegister():void
		{
			browseClickedSignal = new NativeSignal(view.browseButton, MouseEvent.CLICK, MouseEvent);
			browseClickedSignal.add(onBrowseButtonClicked);
			uploadClickedSignal = new NativeSignal(view.uploadButton, MouseEvent.CLICK, MouseEvent);
			uploadClickedSignal.add(onUploadButtonClicked);
			eventMap.mapListener(view, NativeDragEvent.NATIVE_DRAG_ENTER, dragInHandler);
			eventMap.mapListener(view, NativeDragEvent.NATIVE_DRAG_DROP, dragDropHandler);
			imageSelectedChangeSignal.add(onImageSelectedChanged);
			
			view.uploadButton.enabled = false;
			logService.info("[ApplicationViewMediator] onRegister");
		}
		
		
		private function dragInHandler(event : NativeDragEvent) : void
		{
			if(event.clipboard.hasFormat(ClipboardFormats.FILE_LIST_FORMAT))
			{
				NativeDragManager.acceptDragDrop(view);
			}
		}
		
		private function dragDropHandler(event : NativeDragEvent) : void
		{
			var files : Array = event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			fileSelectedSignal.dispatch(files);
		}
		
		private function onBrowseButtonClicked(event : MouseEvent):void
		{
			_fileToAdd = File.desktopDirectory;
			_fileToAdd.addEventListener(FileListEvent.SELECT_MULTIPLE, fileSelected, false, 0, true);
			_fileToAdd.addEventListener(Event.CANCEL, fileCanceled, false, 0, true);
			_fileToAdd.browseForOpenMultiple(SELECT_SOURCE, [ZaaILInterface.FILE_FILTER]);
		}
		
		private function onUploadButtonClicked(event : MouseEvent):void
		{
			var item:* = imageModel.getItemAt(_modelIndex);
			var file:File = item.file as File;

			uploadSignal.dispatch(file);
		}
		
		private var _modelIndex:int;
		private function onImageSelectedChanged(index:int):void{
			if(index>=0){
				view.uploadButton.enabled=true;
			}else{
				view.uploadButton.enabled=false;
			}
			_modelIndex = index;
		}
		
		private function fileSelected(event : FileListEvent) : void
		{
			releaseFileToAddHandlers();
			fileSelectedSignal.dispatch(event.files);
		}
		
		private function fileCanceled(event : Event) : void
		{
			releaseFileToAddHandlers();
			_fileToAdd = null;
		}
		
		private function releaseFileToAddHandlers() : void
		{
			_fileToAdd.removeEventListener(FileListEvent.SELECT_MULTIPLE, fileSelected);
			_fileToAdd.removeEventListener(Event.CANCEL, fileCanceled);
		}
	}
}