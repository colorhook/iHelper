package com.koubei.ihelper.signals
{
	import org.osflash.signals.Signal;
	
	public class FileUploadedSignal extends Signal
	{
		public function FileUploadedSignal()
		{
			super(String);
		}
	}
}