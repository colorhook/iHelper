package com.koubei.ihelper.model
{
	import org.robotlegs.mvcs.Actor;
	
	[Bindable]
	public class OptionModel extends Actor
	{
		public function OptionModel()
		{
			super();
		}
		
		public var jpegFormat:Boolean = true;
		public var jpegQuality:Number = 80;
		public var scale:Number = 0.8;
		
	}
}