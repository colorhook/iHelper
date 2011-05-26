package com.koubei.ihelper.controller
{
	import com.koubei.ihelper.services.ILogService;
	import com.koubei.ihelper.services.MemeryTalker;
	
	import org.robotlegs.mvcs.Command;
	
	public class FileUploadedCommand extends Command
	{
		[Inject]public var logService:ILogService;
		[Inject]public var response:String;
		[Inject]public var talker:MemeryTalker;
		
		public function FileUploadedCommand()
		{
			talker.sendMessage(response);
		}
	}
}