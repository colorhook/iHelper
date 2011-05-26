package com.koubei.ihelper.view
{
	import com.koubei.ihelper.model.OptionModel;
	import com.koubei.ihelper.services.ILogService;
	
	import flash.events.Event;
	
	import mx.events.NumericStepperEvent;
	import mx.events.SliderEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Mediator;
	
	public class OptionViewMediator extends Mediator
	{
		
		[Injector]public var logService:ILogService;
		[Injector]public var view:OptionView;
		[Injector]public var opitonModel:OptionModel;
		
		public function OptionViewMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			eventMap.mapListener(view.pngCheckBox, Event.CHANGE, onCheckBoxChanged);
			eventMap.mapListener(view.jpgCheckBox, Event.CHANGE, onCheckBoxChanged);
			eventMap.mapListener(view.jpgQualityStepper, NumericStepperEvent.CHANGE, onJPEGQualityChanged);
			eventMap.mapListener(view.slider, SliderEvent.CHANGE, onSliderChanged);
			view.jpgQualityStepper.value = opitonModel.jpegQuality;
			view.slider.value = optionModel.scale;
			logService.info("[OptionViewMediator] onRegister");
		}
		
		
		private function onCheckBoxChanged(event:Event):void{
			if(view.pngCheckBox.selected){
				view.jpgCheckBox.selected = false;
				view.jpgQualityStepper.enabled = false;
			}else{
				view.pngCheckBox.selected = false;
				view.jpgQualityStepper.enabled = true;
			}
			opitonModel.jpegFormat = !view.pngCheckBox.selected;
		}
		
		private function onJPEGQualityChanged(event:NumericStepperEvent):void{
			opitonModel.jpegQuality = event.value;
		}
		private function onSliderChanged(event:SliderEvent):void{
			opitonModel.scale = event.value;
		}
	}
}