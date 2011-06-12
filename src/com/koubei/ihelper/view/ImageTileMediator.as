package com.koubei.ihelper.view
{
	import com.koubei.ihelper.services.ILogService;
	import com.koubei.ihelper.signals.ImageLoadedSignal;
	
	import flash.display.BitmapData;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ImageTileMediator extends Mediator{
		
		[Inject]public var logService:ILogService;
		[Inject]public var view:ImageTile;
		[Inject]public var imageLoadedSignal:ImageLoadedSignal;
		
		public function ImageTileMediator(){
			super();
		}
		
		override public function onRegister():void{
			logService.info("[ImageTileMediator] onRegister");
			imageLoadedSignal.add(onImageLoaded);
		}
		
		private function onImageLoaded(bmd:BitmapData):void{
			var imageBox:ImageBox = new ImageBox();	
			view.addChild(imageBox);
			imageBox.bitmapData = bmd;
		}
	}
}