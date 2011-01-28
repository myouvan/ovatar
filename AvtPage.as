package  {
	
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.FileReference;
	import flash.net.FileFilter;
	import fl.controls.Button;
	import flash.utils.ByteArray;
	import com.adobe.images.*;
	import flash.events.*;
	import Avt;
	
	public class AvtPage extends MovieClip {
		
		// UI Elements:
		public var useAvt:MovieClip;
			public var avt:Avt;
			public var readAvt:MovieClip;
		
		public var db_cr:MovieClip;
		public var db_left:Button;
		public var db_right:Button;
		public var ebs_cr:MovieClip;
		public var ebs_left:Button;
		public var ebs_right:Button;
		public var iniBtn:Button;
		public var os_cr:MovieClip;
		public var os_left:Button;
		public var os_right:Button;
		public var readBtn:Button;
		public var sg_cr:MovieClip;
		public var sg_left:Button;
		public var sg_right:Button;
		public var thumbBtn:MovieClip;
		public var web_cr:MovieClip;
		public var web_left:Button;
		public var web_right:Button;
		
		var crMcArray:Array;
		var bmp:BitmapData;
		var jpg:Bitmap;
		var thumbBytearray:ByteArray;
		var file:FileReference;
		var imagesFilter:FileFilter;
		var loader:Loader;
		
		
		// Initialization:
		public function AvtPage() {
			file = new FileReference();
			imagesFilter = new FileFilter("Images(JPG,GIF,PNG)", "*.jpg;*.gif;*.png");
			loader = new Loader();
			useAvt = avt;
			readAvt = new MovieClip();
			readAvt.x = avt.x;
			readAvt.y = avt.y;
			
			// 対象スポット
			// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
			// 初期非表示
			crMcArray = new Array();
			crMcArray.push(web_cr);
			crMcArray.push(os_cr);
			crMcArray.push(sg_cr);
			crMcArray.push(ebs_cr);
			crMcArray.push(db_cr);
			var i:int;
			for(i=0;i<crMcArray.length;i++){
				crMcArray[i].visible = false;
			}
			
			// 帽子
			web_right.addEventListener(MouseEvent.ROLL_OVER, web_over, false, 0, true);
			web_left.addEventListener(MouseEvent.ROLL_OVER, web_over, false, 0, true);
			web_right.addEventListener(MouseEvent.ROLL_OUT, web_out, false, 0, true);
			web_left.addEventListener(MouseEvent.ROLL_OUT, web_out, false, 0, true);
			
			// 頭
			os_right.addEventListener(MouseEvent.ROLL_OVER, os_over, false, 0, true);
			os_left.addEventListener(MouseEvent.ROLL_OVER, os_over, false, 0, true);
			os_right.addEventListener(MouseEvent.ROLL_OUT, os_out, false, 0, true);
			os_left.addEventListener(MouseEvent.ROLL_OUT, os_out, false, 0, true);
			
			// 体
			sg_right.addEventListener(MouseEvent.ROLL_OVER, sg_over, false, 0, true);
			sg_left.addEventListener(MouseEvent.ROLL_OVER, sg_over, false, 0, true);
			sg_right.addEventListener(MouseEvent.ROLL_OUT, sg_out, false, 0, true);
			sg_left.addEventListener(MouseEvent.ROLL_OUT, sg_out, false, 0, true);
			
			// 尻尾
			ebs_right.addEventListener(MouseEvent.ROLL_OVER, ebs_over, false, 0, true);
			ebs_left.addEventListener(MouseEvent.ROLL_OVER, ebs_over, false, 0, true);
			ebs_right.addEventListener(MouseEvent.ROLL_OUT, ebs_out, false, 0, true);
			ebs_left.addEventListener(MouseEvent.ROLL_OUT, ebs_out, false, 0, true);
			
			// 鞄
			db_right.addEventListener(MouseEvent.ROLL_OVER, db_over, false, 0, true);
			db_left.addEventListener(MouseEvent.ROLL_OVER, db_over, false, 0, true);
			db_right.addEventListener(MouseEvent.ROLL_OUT, db_out, false, 0, true);
			db_left.addEventListener(MouseEvent.ROLL_OUT, db_out, false, 0, true);
			
			// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
			
			// アバターチェンジ
			// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
			// 帽子
			// →
			web_right.addEventListener(MouseEvent.CLICK, web_rightClick, false, 0, true);
			// ←
			web_left.addEventListener(MouseEvent.CLICK, web_leftClick, false, 0, true);
			
			// 頭
			// →
			os_right.addEventListener(MouseEvent.CLICK, os_rightClick, false, 0, true);
			// ←
			os_left.addEventListener(MouseEvent.CLICK, os_leftClick, false, 0, true);
			
			// 体
			// →
			sg_right.addEventListener(MouseEvent.CLICK, sg_rightClick, false, 0, true);
			// ←
			sg_left.addEventListener(MouseEvent.CLICK, sg_leftClick, false, 0, true);
			
			// 尻尾
			// →
			ebs_right.addEventListener(MouseEvent.CLICK, ebs_rightClick, false, 0, true);
			// ←
			ebs_left.addEventListener(MouseEvent.CLICK, ebs_leftClick, false, 0, true);
			
			// 鞄
			// →
			db_right.addEventListener(MouseEvent.CLICK, db_rightClick, false, 0, true);
			// ←
			db_left.addEventListener(MouseEvent.CLICK, db_leftClick, false, 0, true);
			// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
			
			// サムネイルを確定
			thumbBtn.addEventListener(MouseEvent.CLICK, thumbBtnClick, false, 0, true);
			
			// 読み込みボタン
			readBtn.addEventListener(MouseEvent.CLICK, readBtnClick, false, 0, true);
			file.addEventListener(Event.SELECT, readSeleced, false, 0, true);
			file.addEventListener(Event.COMPLETE, readLoaded, false, 0, true);
			loader.contentLoaderInfo.addEventListener(Event.INIT, readInit, false, 0, true);
			
			// 初期戻しボタン
			iniBtn.addEventListener(MouseEvent.CLICK, iniBtnClick, false, 0, true);

		}

		// サムネイルを確定
		private function thumbBtnClick(event:MouseEvent):void {
			bmp = new BitmapData(150, 150, true);
			bmp.draw(useAvt);
			thumbBytearray = PNGEncoder.encode(bmp);
			
			MovieClip(root).nextPage(thumbBytearray, bmp);
		}
		
		// 読み込みボタン
		// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
		private function readBtnClick(event:MouseEvent):void {
			// ローカルのJPGを選択
			file.browse([imagesFilter]);
		}
		// ローカルのJPGの選択が完了
		private function readSeleced(event:Event):void {
			// ローカルのJPGの読み込み
			var file:FileReference = FileReference(event.target);
			file.load();
		}
		// ローカルのJPGの読み込みが完了
		private function readLoaded(event:Event):void {
			var file:FileReference = FileReference(event.target);
			loader.loadBytes(file.data);
		}
		// ローダーのイニットが完了
		private function readInit(event:Event):void {
			// アバター切り替えボタンを非表示
			web_right.visible = false;
			web_left.visible = false;
			os_right.visible = false;
			os_left.visible = false;
			sg_right.visible = false;
			sg_left.visible = false;
			ebs_right.visible = false;
			ebs_left.visible = false;
			db_right.visible = false;
			db_left.visible = false;
			
			// アバターを非表示
			avt.visible = false;
			
			// readAvtを設置
			if(this.contains(readAvt)){
				this.removeChild(readAvt);
				readAvt = new MovieClip();
				readAvt.x = avt.x;
				readAvt.y = avt.y;
			}
			this.addChild(readAvt);
			
			// readAvtの中にローカルJPGを展開
			jpg = Bitmap(event.target.content);
			var jpgStage:MovieClip = new MovieClip();
			readAvt.addChild(jpgStage);
			jpgStage.addChild(jpg);
			
			// readAvt.jpgStageの各辺を150にする
			jpgStage.width = 150;
			jpgStage.height = 150;
			
			// readAvtの各辺を2倍にする
			readAvt.width *= 2;
			readAvt.height *= 2;
			
			// キャプチャ用のuseAvtにreadAvtを代入
			useAvt = readAvt;
		}
		// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
		
		// 初期戻しボタン
		private function iniBtnClick(event:MouseEvent):void {
			web_right.visible = true;
			web_left.visible = true;
			os_right.visible = true;
			os_left.visible = true;
			sg_right.visible = true;
			sg_left.visible = true;
			ebs_right.visible = true;
			ebs_left.visible = true;
			db_right.visible = true;
			db_left.visible = true;
			
			// アバターを表示
			avt.visible = true;
			readAvt.visible = false;
			
			// キャプチャ用のuseAvtにavtを代入
			useAvt = avt;
		}
		
		// 対象スポット
		// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
		private function web_over(event:MouseEvent):void {
			web_cr.visible = true;
		}
		private function web_out(event:MouseEvent):void {
			web_cr.visible = false;
		}
		private function os_over(event:MouseEvent):void {
			os_cr.visible = true;
		}
		private function os_out(event:MouseEvent):void {
			os_cr.visible = false;
		}
		private function sg_over(event:MouseEvent):void {
			sg_cr.visible = true;
		}
		private function sg_out(event:MouseEvent):void {
			sg_cr.visible = false;
		}
		private function ebs_over(event:MouseEvent):void {
			ebs_cr.visible = true;
		}
		private function ebs_out(event:MouseEvent):void {
			ebs_cr.visible = false;
		}
		private function db_over(event:MouseEvent):void {
			db_cr.visible = true;
		}
		private function db_out(event:MouseEvent):void {
			db_cr.visible = false;
		}
	// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

	// アバターチェンジ
	// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
		private function web_rightClick(event:MouseEvent):void {
			avt.changeDsp("web", "right");
		}
		private function web_leftClick(event:MouseEvent):void {
			avt.changeDsp("web", "left");
		}
		private function os_rightClick(event:MouseEvent):void {
			avt.changeDsp("os", "right");
		}
		private function os_leftClick(event:MouseEvent):void {
			avt.changeDsp("os", "left");
		}
		private function sg_rightClick(event:MouseEvent):void {
			avt.changeDsp("sg", "right");
		}
		private function sg_leftClick(event:MouseEvent):void {
			avt.changeDsp("sg", "left");
		}
		private function ebs_rightClick(event:MouseEvent):void {
			avt.changeDsp("ebs", "right");
		}
		private function ebs_leftClick(event:MouseEvent):void {
			avt.changeDsp("ebs", "left");
		}
		private function db_rightClick(event:MouseEvent):void {
			avt.changeDsp("db", "right");
		}
		private function db_leftClick(event:MouseEvent):void {
			avt.changeDsp("db", "left");
		}
	// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
	}
	
}