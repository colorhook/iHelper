package com.koubei.ihelper.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class ApplicationModel extends Actor
	{
		
		public var updateURL:String = "";
		public var uploadFieldName:String = "uploadFile";
		public var uploadEndpoint:String = "http://www.koubei.com/common/marlineup.html";
		public function ApplicationModel()
		{
			super();
		}
	}
}