/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.koubei.ihelper.controller{
	
	
	import com.koubei.ihelper.services.ILogService;
	import com.koubei.ihelper.signals.AutoUpdateSignal;
	import com.koubei.ihelper.signals.LoadSpringSignal;
	
	import org.robotlegs.mvcs.Command;

	public class StartupCommand extends Command{
		
		[Inject]public var logService:ILogService;
		[Inject]public var autoUpdateSignal:AutoUpdateSignal;
		[Inject]public var loadSpringSignal:LoadSpringSignal;
		
		override public function execute():void{
			logService.info("StartupCommand execute");
			//autoUpdateSignal.dispatch();
			loadSpringSignal.dispatch();
		}
		
		
		
	}
}