package com.koubei.ihelper.view
{
	import com.koubei.ihelper.model.ImageModel;
	import com.koubei.ihelper.services.ILogService;
	import com.koubei.ihelper.signals.ImageSelectedChangeSignal;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mx.controls.Image;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Mediator;
	
	public class ImageZoomMediator extends Mediator
	{
		[Inject]
		public var view:ImageZoom;
		
		[Inject]
		public var logService:ILogService;
		
		[Inject]
		public var imageSelectedChangeSignal:ImageSelectedChangeSignal;
		
		[Inject]
		public var imageModel:ImageModel;
		
		public function ImageZoomMediator()
		{
			super();
		}
		
		public override function onRegister():void
		{
			logService.info("[ImageZoomViewMediator] onRegister");
			imageSelectedChangeSignal.add(onImageSelectedChanged);
			
		}
		
		private function onImageSelectedChanged(index:int):void{
			var bitmapData:BitmapData = imageModel.getBitmapDataAt(index);
			view.source = new Bitmap(bitmapData);
		}
		
		
	}
}