package com.koubei.ihelper.view
{
	import com.koubei.ihelper.model.ImageModel;
	import com.koubei.ihelper.services.ILogService;
	import com.koubei.ihelper.signals.ImageModelChangeSignal;
	import com.koubei.ihelper.signals.ImageSelectedChangeSignal;
	
	import flash.events.Event;
	
	import mx.controls.Image;
	import mx.events.ListEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ImageListMediator extends Mediator{
		
		[Inject]public var logService:ILogService;
		[Inject]public var imageModel:ImageModel;
		[Inject]public var imageChangeSignal:ImageModelChangeSignal;
		[Inject]public var imageSelectedChangeSignal:ImageSelectedChangeSignal;
		
		[Inject]public var view:ImageList;
		
		public function ImageListMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			imageChangeSignal.add(onImageModelChanged);
			this.addViewListener(ListEvent.CHANGE, onViewSelectedChange);
		}
		
		private function onViewSelectedChange(event:ListEvent):void{
			var index:int = view.selectedItem.index;
			imageSelectedChangeSignal.dispatch(index);
		}
		private function onImageModelChanged():void{
			view.dataProvider = imageModel.getImageList();
		}
	}
}