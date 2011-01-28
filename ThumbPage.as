package  {
	
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.*;
	import fl.controls.Button;
	import flash.net.*;
	import flash.utils.ByteArray;
	import com.adobe.images.*;
	
	public class ThumbPage extends MovieClip {
		
		public var bmp:BitmapData;
		public var bytearray:ByteArray;
		
		// UI Elements:
		public var sndBtn:MovieClip;
		public var bkBtn:Button;
		public var thumb:MovieClip;
		
		// Initialization:
		public function ThumbPage() {
			sndBtn.addEventListener(MouseEvent.CLICK, sndBtnClick, false, 0, true);
			bkBtn.addEventListener(MouseEvent.CLICK, bkBtnClick, false, 0, true);
		}
		
		
		private function bkBtnClick(event:MouseEvent):void {
			MovieClip(root).bkPage();
		}
		
		private function sndBtnClick(event:MouseEvent):void {
			// 位置やサイズを記録しておく
			var thumbPicSize:Object = {width:thumb.thumbPic.width, height:thumb.thumbPic.height};
			
			// 関係ないMCを消す
			thumb.thumbPic.posUI.visible = false;
			thumb.thumbPic.darkSheet.visible = false;
			thumb.thumbPic.jpgBase.visible = false;
			
			// thumb.thumbPicのマスクを決める
			thumb.thumbPic.mask = thumb.thumbPic.jMask;
			
			// マスクが32*32になるようにthumb.thumbPicを変形させる
			thumb.thumbPic.width = 32 / thumb.thumbPic.jMask.width * thumb.thumbPic.width;
			thumb.thumbPic.height = 32 / thumb.thumbPic.jMask.height * thumb.thumbPic.height;
			
			// マスクの左上がthumb.thumbPicの原点にくるようにthumb.thumbPicを動かす
			// →伸縮のせいで端数になっているので、中身を動かす
			thumb.thumbPic.jpgTrimming.x = thumb.thumbPic.jMask.x * -1;
			thumb.thumbPic.jpgTrimming.y = thumb.thumbPic.jMask.y * -1;
			thumb.thumbPic.jMask.x = 0;
			thumb.thumbPic.jMask.y = 0;
			
			// thumbをビットマップとしてキャプチャ
			bmp = new BitmapData(32, 32, true);
			bmp.draw(thumb);
			bytearray = PNGEncoder.encode(bmp);
			
			// とりあえずローカルに保存する画面を出す
			//var saver:FileReference = new FileReference();
			//saver.save(bytearray,"thumb.jpg");
			
			// 全部元に戻す
			thumb.thumbPic.jMask.x = thumb.thumbPic.jpgTrimming.x * -1;
			thumb.thumbPic.jMask.y = thumb.thumbPic.jpgTrimming.y * -1;
			thumb.thumbPic.jpgTrimming.x = 0;
			thumb.thumbPic.jpgTrimming.y = 0;
			
			thumb.thumbPic.width = thumbPicSize.width;
			thumb.thumbPic.height = thumbPicSize.height;
			
			thumb.thumbPic.mask = null;
			thumb.thumbPic.jpgTrimming.mask = thumb.thumbPic.jMask;
			
			thumb.thumbPic.posUI.visible = true;
			thumb.thumbPic.darkSheet.visible = true;
			thumb.thumbPic.jpgBase.visible = true;
			
			MovieClip(root).sendData(bytearray);
		}
		
	}
	
}

