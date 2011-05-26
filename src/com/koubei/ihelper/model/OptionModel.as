package com.koubei.ihelper.model
{
	import com.koubei.ihelper.signals.OptionChangedSignal;
	
	import org.robotlegs.mvcs.Actor;
	

	public class OptionModel extends Actor
	{
		public function OptionModel(){
			super();
		}
		
		[Inject]public var optionChangedSignal:OptionChangedSignal;
		private var _jpegFormat:Boolean = true;
		private var _jpegQuality:Number = 80;
		private var _scale:Number = 0.8;
		
		public function set jpegFormat(b:Boolean):void{
			if(_jpegFormat == b){
				return;
			}
			_jpegFormat= b;
			optionChangedSignal.dispatch();
		}
		
		public function  get jpegFormat():Boolean{
			return _jpegFormat;
		}
		public function set jpegQuality(value:Number):void{
			if(_jpegQuality == value){
				return;
			}
			_jpegQuality= value;
			optionChangedSignal.dispatch();
		}
		public function  get jpegQuality():Number{
			return _jpegQuality;
		}
		
		public function set scale(value:Number):void{
			if(_scale == value){
				return;
			}
			_scale= value;
			optionChangedSignal.dispatch();
		}
		public function  get scale():Number{
			return _scale;
		}
	}
}