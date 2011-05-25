package com.koubei.ihelper.view
{
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Mediator;
	
	public class ImageZoomViewMediator extends Mediator
	{
		[Inject]
		public var view:ImageZoomView;
		[Inject]
		public var logService:ILogService;
		

		
		public function ImageZoomViewMediator()
		{
			super();
		}
		
		public override function onRegister():void
		{
			logService.info("[ImageZoomViewMediator] onRegister");
		}
		
		
	}
}