package com.koubei.ihelper.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class ApplicationModel extends Actor
	{
		
		public var updateURL:String = "";
		public var uploadFieldName:String = "uploadFile";
		public var uploadEndpoint:String = "http://www.koubei.com/common/marlineup.html";
		public var maxWidth:Number = 1024;
		public var maxHeight:Number = 768;
		public var minWidth:Number = 1;
		public var minHeight:Number = 1;
		public function ApplicationModel()
		{
			super();
		}
	}
}