package com.koubei.ihelper.signals{
	
	import flash.filesystem.File;
	
	import org.osflash.signals.Signal;
	
	public class UploadSignal extends Signal{
		
		public function UploadSignal(){
			super(File);
		}
	}
}