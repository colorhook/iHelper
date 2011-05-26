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
	
	public class ApplicationContext extends SignalContext{

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
			injector.mapSingleton(ImageModel);
			injector.mapSingleton(OptionModel);
			injector.mapSingleton(MemeryTalker);
			injector.mapSingleton(ImageModelChangeSignal);
			injector.mapSingleton(ImageSelectedChangeSignal);
			injector.mapSingleton(OptionChangedSignal);
			/*/injector.mapSingletonOf(ILogService,NullLogService);
			//*/injector.mapSingletonOf(ILogService,LogService);
		}
		/**
		 * initialize controller
		 * map Event and Command
		 */ 
		protected function initializeController():void{
			commandMap.mapEvent(ContextEvent.STARTUP, StartupCommand, ContextEvent, true);
		}
		/**
		 * initialize signal
		 * map Signal and Command
		 */ 
		protected function initializeSignal():void{
			signalCommandMap.mapSignalClass(AutoUpdateSignal, AutoUpdateCommand, true);
			signalCommandMap.mapSignalClass(LoadSpringSignal, LoadSpringCommand, true);
			signalCommandMap.mapSignalClass(FileSelectedSignal, OpenImageCommand);
			signalCommandMap.mapSignalClass(UploadSignal, UploadCommand);
			signalCommandMap.mapSignalClass(FileUploadedSignal, FileUploadedCommand);
		}
		/**
		 * initialize view
		 * map View and Mediator
		 */ 
		protected function initializeView():void{
			mediatorMap.mapView(ApplicationView, ApplicationViewMediator);
			mediatorMap.mapView(ImageList, ImageListMediator);
			mediatorMap.mapView(ImageZoom, ImageZoomMediator);
			mediatorMap.mapView(ToolBar, ToolBarMediator);
			mediatorMap.mapView(ActionBar, ActionBarMediator);
			mediatorMap.mapView(OptionView, OptionViewMediator);
			mediatorMap.mapView(ImageBox, ImageBoxMediator);
		}
		
	}
}