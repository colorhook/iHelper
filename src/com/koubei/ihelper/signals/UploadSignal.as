package com.koubei.ihelper.signals{
	
	import flash.filesystem.File;
	
	import org.osflash.signals.Signal;
	
	public class UploadSignal extends Signal{
		
		public var file:File;
		
		public function UploadSignal(file:File){
			this.file = file;
		}
	}
}