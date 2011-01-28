package processing {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class PosUI extends MovieClip {
		
		public var lineBase:MovieClip;
		public var lineBaseIniRec:Object;
		public var handle:MovieClip;
		public var handleIniPos:Object;
		
		// Initialization:
		public function PosUI() {
			
			// lineBase用
			lineBaseIniRec = {width:lineBase.width, height:lineBase.height};	// 初期サイズを覚えておく
			lineBase.addEventListener(MouseEvent.MOUSE_DOWN, lineBaseDown, false, 0, true);
			lineBase.addEventListener(MouseEvent.MOUSE_UP, lineBaseUp, false, 0, true);
			
			// handle用
			handleIniPos = {x:handle.x, y:handle.y};	// 初期位置を覚えておく
			handle.addEventListener(MouseEvent.MOUSE_DOWN, handleDown, false, 0, true);
			handle.addEventListener(MouseEvent.MOUSE_UP, handleUp, false, 0, true);
			
		}

		// lineBase用
		private function lineBaseDown(event:MouseEvent):void {
			this.startDrag(false);	// 後で範囲を写真の範囲だけに縛る
			
			// enterFrameを始める
			this.addEventListener(Event.ENTER_FRAME, lineBaseDrag, false, 0, true);
		}
		private function lineBaseUp(event:MouseEvent):void {
			this.stopDrag();
			this.removeEventListener(Event.ENTER_FRAME, lineBaseDrag);
		}
		private function lineBaseDrag(event:Event):void {
			MovieClip(parent).moveMask({x:this.x, y:this.y});
		}
		
		// handle用
		private function handleDown(event:MouseEvent):void {
			// enterFrameを始める
			this.addEventListener(Event.ENTER_FRAME, handleDrag, false, 0, true);
			handle.startDrag(true);
		}
		private function handleUp(event:MouseEvent):void {
			this.removeEventListener(Event.ENTER_FRAME, handleDrag);
			handle.stopDrag();
			// マウスの位置が最小値以下の場合
			if(this.mouseX <= handleIniPos.x || this.mouseY <= handleIniPos.y){
				// 最小値で固定
				// handleを初期位置に
				handle.x = handleIniPos.x;
				handle.y = handleIniPos.y;
				
				// lineBaseを初期サイズに
				lineBase.width = lineBaseIniRec.width;
				lineBase.height = lineBaseIniRec.height;
				
			}
			// マウスの位置が最小値よりも大きい場合
			else{
				// マウスのX位置のほうが大きい場合
				if(this.mouseX > this.mouseY){
					// handleの位置をX座標基準で変更
					handle.x = this.mouseX;
					handle.y = this.mouseX;
					
					// lineBaseの大きさをX座標基準で変更
					lineBase.width = this.mouseX;
					lineBase.height = this.mouseX;
					
				}
				// マウスのY位置のほうが大きい場合（厳密にはそれ以外）
				else{
					// handleの位置をY座標基準で変更
					handle.x = this.mouseY;
					handle.y = this.mouseY;
					
					// lineBaseの大きさをY座標基準で変更
					lineBase.width = this.mouseY;
					lineBase.height = this.mouseY;
				}
			}
			
			// マスクのサイズを変更
			MovieClip(parent).recMask({width:lineBase.width, height:lineBase.height});
		}
		private function handleDrag(event:Event):void {
			// マウスの位置が最小値以下の場合
			if(this.mouseX <= handleIniPos.x || this.mouseY <= handleIniPos.y){
				// lineBaseを初期サイズに
				lineBase.width = lineBaseIniRec.width;
				lineBase.height = lineBaseIniRec.height;
				
			}
			// マウスの位置が最小値よりも大きい場合
			else{
				// マウスのX位置のほうが大きい場合
				if(this.mouseX > this.mouseY){
					// lineBaseの大きさをX座標基準で変更
					lineBase.width = this.mouseX;
					lineBase.height = this.mouseX;
					
				}
				// マウスのY位置のほうが大きい場合（厳密にはそれ以外）
				else{
					// lineBaseの大きさをY座標基準で変更
					lineBase.width = this.mouseY;
					lineBase.height = this.mouseY;
				}
			}
		}
				
	}
	
}