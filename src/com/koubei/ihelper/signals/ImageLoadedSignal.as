package com.koubei.ihelper.signals
{
	import flash.display.BitmapData;
	
	import org.osflash.signals.Signal;
	
	public class ImageLoadedSignal extends Signal
	{
		public function ImageLoadedSignal()
		{
			super(BitmapData);
		}
	}
}