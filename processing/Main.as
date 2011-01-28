package processing {
	
	import flash.display.MovieClip;
	//import processing.PosUI;
	
	public class Main extends MovieClip {
		
		public var jMask:MovieClip;
		public var jpgTrimming:MovieClip;
		public var posUI:PosUI;
		
		// Initialization:
		public function Main() {
			jpgTrimming.mask = jMask;
		}
		
		// マスクの位置
		public function moveMask(pos:Object):void {
			//trace(pos.x, pos.y);
			jMask.x = pos.x;
			jMask.y = pos.y;
		}
		
		// マスクのサイズ
		public function recMask(rec:Object):void {
			jMask.width = rec.width;
			jMask.height = rec.height;
		}
	}
	
}