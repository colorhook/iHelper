package com.koubei.ihelper.services
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.events.TextEvent;
	import flash.net.LocalConnection;

	public class MemeryTalker extends EventDispatcher
	{
		public static const MESSAGE:String = "message";
		public static const CONNECT_AIR:String="__MemeryTalker__AIR";
		public static const CONNECT_FLASH:String = "__MemeryTalker__AIR";
		
		protected var connection:LocalConnection;
		
		public function MemeryTalker()
		{
			connection = new LocalConnection();
			connection.client = this;
			connection.addEventListener(StatusEvent.STATUS, onStatus);
			try{
				connection.connect(CONNECT_AIR);
			}catch(error:ArgumentError){
			}
		}
		
		private function onStatus(event:StatusEvent):void {
			this.dispatchEvent(event);
		}
		
		public function sendMessage(message:String):void{
			connection.send(CONNECT_FLASH, "onReceiveMessage", message);
		}
		
		public function onReceiveMessage(message:String):void{
			var event:TextEvent = new TextEvent(MESSAGE);
			event.text = message;
			this.dispatchEvent(event);
		}

	}
}