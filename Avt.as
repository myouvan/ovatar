package  {
	
	import flash.display.MovieClip;
	
	
	public class Avt extends MovieClip {
		var avtObj:Object = new Object();
		var flagObj:Object = new Object();
		
		// Initialization:
		public function Avt() {
			
			avtObj.web = new Array();
			avtObj.web.push(web1);
			avtObj.web.push(web2);
			avtObj.web.push(web3);
			avtObj.web.push(web4);
			avtObj.web.push(web5);
			
			avtObj.os = new Array();	// 必須
			avtObj.os.push(os1);
			avtObj.os.push(os2);
			avtObj.os.push(os3);
			avtObj.os.push(os4);
			avtObj.os.push(os5);
			avtObj.os.push(os6);
			
			avtObj.sg = new Array();	// 必須
			avtObj.sg.push(sg1);
			avtObj.sg.push(sg2);
			avtObj.sg.push(sg3);
			avtObj.sg.push(sg4);
			avtObj.sg.push(sg5);
			avtObj.sg.push(sg6);
			avtObj.sg.push(sg7);
			
			avtObj.ebs = new Array();
			avtObj.ebs.push(ebs1);
			avtObj.ebs.push(ebs2);
			
			avtObj.db = new Array();
			avtObj.db.push(db1);
			avtObj.db.push(db2);
			avtObj.db.push(db3);
			avtObj.db.push(db4);
			avtObj.db.push(db5);
			
			// 全消し
			disable();
			
			// ランダム表示
			rndDsp();
			
		}
		
		// 全消し
		public function disable():void {
			var str:String;
			var i:int;
			for(str in avtObj){
				for(i=0;i<avtObj[str].length;i++){
					avtObj[str][i].visible = false;
					flagObj[str] = -1;
				}
			}
		}
		
		// ランダム表示（全消し後）
		public function rndDsp():void {
			var str:String;
			var rndNum:int;
			for(str in avtObj){
				if(str != "os" && str != "sg"){
					if(Math.random() >= 0.5){
						rndNum = Math.floor(Math.random() * avtObj[str].length);
						avtObj[str][rndNum].visible = true;
						flagObj[str] = rndNum;
					}
				}
				else{
					rndNum = Math.floor(Math.random() * avtObj[str].length);
					avtObj[str][rndNum].visible = true;
					flagObj[str] = rndNum;
				}
			}
		}
		
		// アバター変更
		public function changeDsp(knd:String, dir:String):void {
			trace(knd, dir);
			if(dir == "right"){
				if(flagObj[knd] == -1){
					flagObj[knd] = 0;
					avtObj[knd][0].visible = true;
				}
				else if(flagObj[knd] == avtObj[knd].length - 1){
					if(knd != "os" && knd != "sg"){
						flagObj[knd] = -1;
						avtObj[knd][avtObj[knd].length - 1].visible = false;
					}
					else{
						flagObj[knd] = 0;
						avtObj[knd][avtObj[knd].length - 1].visible = false;
						avtObj[knd][0].visible = true;
					}
				}
				else{
					avtObj[knd][flagObj[knd]].visible = false;
					flagObj[knd]++;
					avtObj[knd][flagObj[knd]].visible = true;
				}
			}
			
			else{
				if(flagObj[knd] == -1){
					flagObj[knd] = avtObj[knd].length - 1;
					avtObj[knd][flagObj[knd]].visible = true;
				}
				else if(flagObj[knd] == 0){
					if(knd != "os" && knd != "sg"){
						flagObj[knd] = -1;
						avtObj[knd][0].visible = false;
					}
					else{
						avtObj[knd][0].visible = false;
						flagObj[knd] = avtObj[knd].length - 1;
						avtObj[knd][flagObj[knd]].visible = true;
					}
				}
				else{
					avtObj[knd][flagObj[knd]].visible = false;
					flagObj[knd]--;
					avtObj[knd][flagObj[knd]].visible = true;
				}
			}
			
		}
		
	}
	
}