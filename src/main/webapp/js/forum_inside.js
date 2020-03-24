var records=8;
var page_per_count=5;
var nowpage=1;
var page_count=Math.ceil(records/page_per_count);
var theme=new Array("安卓是最好的手机","linux是全球最安全的操作系统","asdf","啊","adfasdvbasd","java是全球最强的编程语言","阿斯顿发发呆","参数测试");
var post_author_time=new Array("javasun$2017-02-13$12:00:00","天勤$2017-02-26$12:00:00","梓晨$2017-02-13$12:00:00","天勤$2017-02-13$12:00:00","紫宸$2017-02-13$12:00:00","天勤$2017-02-13$12:00:00","天勤$2017-02-13$12:00:00","梓晨$2017-02-13$12:00:00");
var response_num=new Array("12","1","1","1","8","15","4","2");
var click_num=new Array("55","14","10","6","30","48","15","4");


	function create_tbody(){
		str1="";
		str="";
		var i=(nowpage-1)*page_per_count;
		var j=i;
		for(;i<j+5 && i<theme.length;i++){
			arr1=post_author_time[i].split("$");
			str1="<tr class='forum_inside_main_table_tr2'><td class='forum_inside_main_table_tr2_td1'><img src='../images/bbs/images/icon_jh.gif' width='15' height='15' alt=''/></td><td class='forum_inside_main_table_tr2_td2' id='forum_inside_main_table_tr2_td2'><a href='forum_outside.html'>"+theme[i]+"</a></td><td class='forum_inside_main_table_tr2_td3'>"+arr1[0]+"<br/>"+arr1[1]+"<br/>"+arr1[2]+"<br/>"+"</td> <td class='forum_inside_main_table_tr2_td4' id='forum_inside_main_table_tr2_td4'>"+response_num[i]+"</td><td class='forum_inside_main_table_tr2_td5'>"+click_num[i]+"</td></tr>"
			str=str+str1;
		}
	

	document.getElementById("forum_inside_main_table_tobdy").innerHTML=str;
		document.getElementById("forum_inside_bottom_word").innerHTML="总记录数:"+records+"条 每页显示"+page_per_count+"条 共"+page_count+"页 当前第"+nowpage+"页";
      
     
      
    
   
	
}
/*function change_color(){
	document.getElementById("forum_inside_main_table_tr2_td2").className='forum_inside_main_table_tr2_td2_1';
	document.getElementById("forum_inside_main_table_tr2_td4").className='forum_inside_main_table_tr2_td4_1';
}*/
function first(){
	nowpage=1;
	document.getElementById("previous_page").style.display='none';
	if(page_count>1) document.getElementById("next_page").style.display='inline';
	create_tbody();
}
function last(){
	nowpage=page_count;
	document.getElementById("next_page").style.display='none';
	if(page_count>1) document.getElementById("previous_page").style.display='inline';
	create_tbody();
}

function previous(){
	if(nowpage!=1) {nowpage=nowpage-1;document.getElementById("next_page").style.display='inline';
				   if(nowpage==1)document.getElementById("previous_page").style.display='none';}
		
	create_tbody();
	
}

function next(){
	if(nowpage!=page_count) {nowpage=nowpage+1;document.getElementById("previous_page").style.display='inline';if(nowpage==page_count)document.getElementById("next_page").style.display='none';}
		
	create_tbody();
}

function jump(){
	var obj=document.getElementById("page").value;
	var obj1=parseInt(obj);
	if(obj1<1 || obj1>page_count ) alert("超过范围");
	else{
		nowpage=obj1;
		create_tbody();
	}
}