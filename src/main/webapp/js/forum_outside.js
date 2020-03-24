var imgs=new Array(" <img src='../images/bbs/images/upload.gif' width='45' height='25' alt=''/> "," <img src='../images/bbs/images/upload.gif' width='45' height='25' alt=''/> "," <img src='../images/bbs/images/upload.gif' width='45' height='25' alt=''/> "," <img src='../images/bbs/images/upload.gif' width='45' height='25' alt=''/> "," <img src='../images/bbs/images/upload.gif' width='45' height='25' alt=''/> "," <img src='../images/bbs/images/upload.gif' width='45' height='25' alt=''/> ");
var names=new Array("<span style='color:red;'>楼主<br/>javasun</span>","天勤","1","2","3","4");
var contents=new Array("1","2","2","2","2","2");
var nums=6;
var nowpage=1;
var pagecount=Math.ceil(nums/4);


function createceng(){
	str1="";
	str="";
	var i=(nowpage-1)*4;
	var j=i;
	for(;i<j+4 && i<nums;i++){
		str1="<div class='louzhu'><div class='louzhu_left_out'><div class='louzhu_left'>"+imgs[i]+"</div><div style='margin-right: 20px;margin-top: 50px;width: 60px;height: 50px;text-align: center;float: right;font-size: 14px;'>"+names[i]+"</div></div><div class='louzhu_right'>"+contents[i]+"<div class='order'>第"+(i+1)+"楼</div></div></div>";
		str=str+str1;
	}
	document.getElementById("forum_inside_container_center").innerHTML=str;
	document.getElementById("forum_inside_bottom_word").innerHTML="总记录数:"+nums+"条 共"+pagecount+"页 当前第"+nowpage+"页";
		
	
}
function first(){
	nowpage=1;
	document.getElementById("previous_page").style.display='none';
	if(pagecount>1) document.getElementById("next_page").style.display='inline';
	createceng();
}
function last(){
	nowpage=pagecount;
	document.getElementById("next_page").style.display='none';
	if(pagecount>1) document.getElementById("previous_page").style.display='inline';
	createceng();
}

function previous(){
	if(nowpage!=1) {nowpage=nowpage-1;document.getElementById("next_page").style.display='inline';
				   if(nowpage==1)document.getElementById("previous_page").style.display='none';}
		
	createceng();
	
}

function next(){
	if(nowpage!=pagecount) {nowpage=nowpage+1;document.getElementById("previous_page").style.display='inline';if(nowpage==pagecount)document.getElementById("next_page").style.display='none';}
		
	createceng();
}
function jump(){
	var obj=document.getElementById("page").value;
	var obj1=parseInt(obj);
	if(obj1<1 || obj1>pagecount ) alert("超过范围");
	else{
		nowpage=obj1;
		createceng();
	}
}