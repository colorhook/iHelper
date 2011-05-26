package com.koubei.ihelper.view
{
	import com.koubei.ihelper.model.ApplicationModel;
	import com.koubei.ihelper.model.ImageModel;
	import com.koubei.ihelper.model.OptionModel;
	import com.koubei.ihelper.services.ILogService;
	import com.koubei.ihelper.signals.ImageSelectedChangeSignal;
	import com.koubei.ihelper.signals.OptionChangedSignal;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import mx.controls.Image;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ImageBoxMediator extends Mediator
	{
		[Inject]public var logService:ILogService;
		[Inject]public var view:ImageBox;
		[Inject]public var imageSelectedChangeSignal:ImageSelectedChangeSignal;
		[Inject]public var imageModel:ImageModel;
		[Inject]public var optionMode:OptionModel;
		[Inject]public var appModel:ApplicationModel;
		[Inject]public var optionChangedSignal:OptionChangedSignal
		
		public function ImageBoxMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			eventMap.mapListener(view.image, MouseEvent.MOUSE_DOWN, onImageMouseDown);
			imageSelectedChangeSignal.add(onImageSelectedChanged);
			optionChangedSignal.add(onOptionChangedSignal);
			view.maxImageHeight = appModel.maxHeight;
			view.maxImageWidth = appModel.maxWidth;
		}
		
		private function onImageMouseDown(event:MouseEvent):void{
			eventMap.mapListener(view.stage, MouseEvent.MOUSE_UP,onStageMouseUp);
			view.image.startDrag();
		}
		
		
		private function onStageMouseUp(event:MouseEvent):void{
			eventMap.unmapListener(view.stage, MouseEvent.MOUSE_UP, onStageMouseUp);
			view.image.stopDrag();
		}
		private function onOptionChangedSignal():void{
			trace("onOptionChange");
			view.scale = optionMode.scale;
		}
		private function onImageSelectedChanged(index:int):void{
			var bitmapData:BitmapData = imageModel.getBitmapDataAt(index);
			view.bitmapData = bitmapData;
		}
	}
}