/*
* Copyright (c) 2010 the original author or authors
* 
* Permission is hereby granted to use, modify, and distribute this file 
* in accordance with the terms of the license agreement accompanying it.
*/
package com.koubei.ihelper.controller{
	
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import com.koubei.ihelper.model.ApplicationModel;
	import com.koubei.ihelper.services.ILogService;
	
	import org.robotlegs.mvcs.Command;
	
	public class AutoUpdateCommand extends Command{
		
		[Inject]public var logService:ILogService;
		[Inject]public var appModel:ApplicationModel;
		
		private var updateUI:ApplicationUpdaterUI=new ApplicationUpdaterUI();
		
		override public function execute():void{
			logService.info("AutoUpdateCommand execute");
			updateUI=new ApplicationUpdaterUI();
			updateUI.updateURL=appModel.updateURL;
			updateUI.isCheckForUpdateVisible=false;
			updateUI.addEventListener(UpdateEvent.INITIALIZED,onUpdateUIInitialize);
			updateUI.initialize();
		} 
		
		private function onUpdateUIInitialize(event:UpdateEvent):void{
			logService.info("StartupCommand updateUI initialize");
			var updateUI:ApplicationUpdaterUI=event.target as ApplicationUpdaterUI;
			updateUI.removeEventListener(UpdateEvent.INITIALIZED,onUpdateUIInitialize);
			updateUI.checkNow();
		}
		
	}
}