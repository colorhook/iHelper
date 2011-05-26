package com.koubei.ihelper.view
{
	import com.koubei.ihelper.services.ILogService;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ApplicationViewMediator extends Mediator
	{
		[Inject]
		public var view:ApplicationView;
	
		[Inject]
		public var logService:ILogService;

		
		public function ApplicationViewMediator()
		{
			super();
		}
		
		
	}
}