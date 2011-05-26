package com.koubei.ihelper.model
{
	import com.koubei.ihelper.services.ILogService;
	import com.koubei.ihelper.signals.ImageModelChangeSignal;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	import mx.core.IDataRenderer;
	import mx.utils.ObjectProxy;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ImageModel extends Actor{
		
		
		[Inject]public var logService:ILogService;
		[Inject]public var imageModelChangeSignal:ImageModelChangeSignal;
		
		private var data:ArrayCollection;
		private var dp:Array;

		public function ImageModel()
		{
			super();
			data = new ArrayCollection();
			data.disableAutoUpdate();
		}
		
		public function addItems(items:Array):void{
			if(items.length == 0){
				return;
			}
			for(var i:int = 0, l:uint = items.length; i < l; i++){
				data.addItem(items[i]);
			}
			imageModelChangeSignal.dispatch();
		}
		
		public function getItemAt(index:int):*{
			return data.getItemAt(index);
		}
		
		public function getBitmapDataAt(index:int):BitmapData{
			return getItemAt(index).bitmapData as BitmapData;
		}
		
		public function removeItems(items:Array):void{
			var dirty:Boolean = false;
			for(var i:int = 0, l:uint = items.length; i < l; i++){
				var index:int = data.getItemIndex(items[i]);
				if(index>=0){
					dirty = true;
					data.removeItemAt(index);
				}
				
			}
			if(dirty){
				imageModelChangeSignal.dispatch();
			}
		}
		
		public function getImageList():Array{
			dp = [];
			for(var i:uint = 0, l:uint = data.length; i < l; i++){
				var bitmap:Bitmap = new Bitmap(BitmapData(data[i].bitmapData));
				var s:Sprite = new Sprite();
				s.addChild(bitmap);
				var proxy:ObjectProxy = new ObjectProxy();
				proxy.source = s;
				proxy.index= i;
				dp.push(proxy);
			}
			return dp;
		}

	}
}