package com.koubei.ihelper.services
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class MemeryTalker extends EventDispatcher
	{
		public static const MESSAGE:String = "message";
		public static const CONNECT_NAME:String="__MemeryTalker";
		
		public function MemeryTalker()
		{
			connection = new LocalConnection();
			connection.client = this;
			connection.addEventListener(StatusEvent.STATUS, onStatus);
			try{
				connection.connect(CONNECT_NAME);
			}catch(error:ArgumentError){
			}
		}
		
		private function onStatus(event:StatusEvent):void {
			this.dispatchEvent(event);
		}
		
		public function sendMessage(message:String):void{
			connection.send(CONNECT_NAME, "onReceiveMessage", message);
		}
		
		public function onReceiveMessage(message:String):void{
			var event:Event = new Event(MESSAGE);
			event.data = message;
			this.dispatchEvent(event);
		}

	}
}