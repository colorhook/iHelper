package com.koubei.ihelper.controller
{
	import com.colorhook.spring.context.ContextLoader;
	import com.koubei.ihelper.model.ApplicationModel;
	import com.koubei.ihelper.services.ILogService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import mx.core.Application;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadSpringCommand extends Command
	{

		private static const CONFIG_PATH:String = "assets/xml/spring-config.xml";
		
		[Inject]
		public var appModel:ApplicationModel;
		[Inject]
		public var logService:ILogService;
		
		public override function execute():void
		{
			var loader:ContextLoader = new ContextLoader();
			loader.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(CONFIG_PATH);
		}
		
		private function onLoaderComplete(event:Event):void{
			var loader:ContextLoader = event.target as ContextLoader;
			loader.removeEventListener(Event.COMPLETE, onLoaderComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			var appModelBean:* = loader.contextInfo.getBean("appModel");
			if(appModelBean){
				logService.info("appModelBean found:" + String(appModelBean));
				for(var i:* in appModelBean){
					try{
						appModel[i] = appModelBean[i];
						logService.debug("appModel["+i+"]="+appModelBean[i]);
					}catch(error:*){
						logService.debug("appModel["+i+"] setter failure");
					}
				}
			}else{
				logService.debug("appModelBean not found");
			}
		}
		private function onIOError(event:IOErrorEvent):void{
			var loader:ContextLoader = event.target as ContextLoader;
			loader.removeEventListener(Event.COMPLETE, onLoaderComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
	}
}