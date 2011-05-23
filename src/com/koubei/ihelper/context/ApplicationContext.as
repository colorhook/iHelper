package com.koubei.ihelper.context
{
	import com.koubei.ihelper.model.*;
	import com.koubei.ihelper.controller.*;
	import com.koubei.ihelper.services.*;
	import com.koubei.ihelper.view.*;
	import com.koubei.ihelper.signals.*;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	import org.robotlegs.mvcs.SignalContext;
	
	public class ApplicationContext extends SignalContext
	{

		/**
		 * The Startup Hook
		 * in this hook, initialize Model, Service, Controller and View
		 * follow the MVCS Design Pattern.
		 */ 
		override public function startup():void{	
			initializeModel();
			initializeController();
			initializeSignal();
			initializeView();
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
		}
		/**
		 * initialize model and service.
		 * map Actor (contains Model and Service)
		 */ 
		protected function initializeModel():void{
			injector.mapSingleton(ApplicationModel);
			injector.mapSingleton(AutoUpdateSignal);
			/**/injector.mapSingletonOf(ILogService,NullLogService);
			//*/injector.mapSingletonOf(ILogService,LogService);
		}
		/**
		 * initialize controller
		 * map Event and Command
		 */ 
		protected function initializeController():void{
			commandMap.mapEvent(ContextEvent.STARTUP, StartupCommand, ContextEvent, true);
		}
		
		protected function initializeSignal():void{
			signalCommandMap.mapSignalClass(AutoUpdateSignal, AutoUpdateCommand);
		}
		/**
		 * initialize view
		 * map View and Mediator
		 */ 
		protected function initializeView():void{
			
			mediatorMap.mapView(ApplicationView, ApplicationViewMediator);
			
			
		}
		/**
		 * initialize twitter service commands
		 * If I want to get a user data or publish a tweet to twitter.com, All I need to do is dispatch a 
		 * TwitterServiceEvent on a Meditor
		 * @see TwitterServiceEvent
		 * @see TwitterCommand
		 */ 
		
	}
}