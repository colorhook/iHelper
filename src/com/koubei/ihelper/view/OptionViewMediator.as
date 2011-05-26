package com.koubei.ihelper.view
{
	import com.koubei.ihelper.model.OptionModel;
	import com.koubei.ihelper.services.ILogService;
	
	import flash.events.Event;
	
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
			eventMap.mapListener(view.jpgQualitySlider, SliderEvent.CHANGE, onJPEGQualityChanged);
			eventMap.mapListener(view.slider, SliderEvent.CHANGE, onSliderChanged);
			view.jpgQualitySlider.value = optionModel.jpegQuality;
			view.slider.value = optionModel.scale;
			logService.info("[OptionViewMediator] onRegister");
		}
		
		
		private function onRadioGroupChanged(event:Event):void{
			if(view.imageFormat.selectedValue == "PNG"){
				view.jpgQualitySlider.enabled = false;
				optionModel.jpegFormat = false;
			}else{
				view.jpgQualitySlider.enabled = true;
				optionModel.jpegFormat = true;
			}
		}
		
		private function onJPEGQualityChanged(event:SliderEvent):void{
			optionModel.jpegQuality = event.value;
		}
		private function onSliderChanged(event:SliderEvent):void{
			optionModel.scale = event.value;
		}
	}
}