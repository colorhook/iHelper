package com.koubei.ihelper.view
{
	import com.koubei.ihelper.services.ILogService;
	
	import flash.display.NativeWindow;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ToolBarMediator extends Mediator
	{
		
		[Inject]public var logService:ILogService;
		[Inject]public var view:ToolBar;
		
		public function ToolBarMediator(){
			super();
		}
		
		
		override public function onRegister():void{
			eventMap.mapListener(view, MouseEvent.MOUSE_DOWN, onTitleMouseDown);
			eventMap.mapListener(view.minimizeButton, MouseEvent.CLICK, minimize);
			eventMap.mapListener(view.maximizeButton, MouseEvent.CLICK, maximize);
			eventMap.mapListener(view.closeButton, MouseEvent.CLICK, closeSelf);
		}
		
		private function onTitleMouseDown(event:MouseEvent):void{
			if(event.target != view){
				return;
			}
			eventMap.mapListener(view.stage, MouseEvent.MOUSE_UP,onStageMouseUp);
			view.stage.nativeWindow.startMove();
		}
		
		
		private function onStageMouseUp(event:MouseEvent):void{
			eventMap.unmapListener(view.stage, MouseEvent.MOUSE_UP, onStageMouseUp);
		}
		
		private function minimize(event:MouseEvent):void{
			logService.info("[User action] minimize");
			view.stage.nativeWindow.minimize();
		}
		
		private function maximize(event:MouseEvent):void{
			logService.info("[User action] maximize");
			var window:NativeWindow = view.stage.nativeWindow;
			if(window.displayState=="normal"){
				window.maximize();
			}else{
				window.restore();
			}
		}
		
		private function closeSelf(event:MouseEvent):void{
			logService.info("[User action] close");
			view.stage.nativeWindow.close();
		}

	}
}