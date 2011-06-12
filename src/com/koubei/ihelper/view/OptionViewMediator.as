package com.koubei.ihelper.view
{
	import com.koubei.ihelper.model.OptionModel;
	import com.koubei.ihelper.services.ILogService;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.RadioButtonGroup;
	import mx.events.SliderEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class OptionViewMediator extends Mediator
	{
		
		[Inject]public var logService:ILogService;
		[Inject]public var view:OptionView;
		[Inject]public var optionModel:OptionModel;
		
		public function OptionViewMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			eventMap.mapListener(view.imageFormat, Event.CHANGE, onRadioGroupChanged);
			eventMap.mapListener(view.rotateL, MouseEvent.CLICK, onRotateLClicked);
			eventMap.mapListener(view.rotateR, MouseEvent.CLICK, onRotateRClicked);
			logService.info("[OptionViewMediator] onRegister");
		}
		private function onRadioGroupChanged(event:Event):void{
			if(view.imageFormat.selectedValue == "PNG"){
				optionModel.jpegFormat = false;
			}else{
				optionModel.jpegFormat = true;
			}
		}
		private function onRotateLClicked(event:MouseEvent):void{
			optionModel.rotation -= 90;
		}
		private function onRotateRClicked(event:MouseEvent):void{
			optionModel.rotation = 90;
		}

	}
}