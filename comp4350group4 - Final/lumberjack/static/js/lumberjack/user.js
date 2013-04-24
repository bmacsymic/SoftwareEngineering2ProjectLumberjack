function limiting(obj, limit) {
	var cnt = $("#counter > span");
	var txt = $(obj).val(); 
	var len = txt.length;

   	// check if the current length is over the limit
	if(len > limit){
   		$(obj).val(txt.substr(0,limit));
   		$(cnt).html(len-1);
	} else { 
   		$(cnt).html(len);
	}
}

function followUnfollowUser(followeeId, currState, url) {
	$.getJSON($SCRIPT_ROOT + url, {
    	followee: followeeId,
      	state: currState
    }, function(data) {
    	if (data.result != "error") {
      		$("#follow_btn_result").text(data.result + " this user");
      		return true
      	 } else {
      		alert("A problem has occurred. Please try again later!")
      		return false;
      	 }
    });
    return false;
}

function postStatus(img, username, url) {
	$.post($SCRIPT_ROOT + url, {
      	body: document.getElementById("status-input").value
    }, function(data) {
    	if (data.result == "success") {
      		var user_feed = "<div class=\"user-feed\"><div class=\"feed-img\">" + "<img src=\"" + img + "\"></div>";
   			user_feed += "<div class=\"feed-right\"><div class=\"feed-username\">" + username + "</div>";
   			user_feed += "<div class=\"feed-time\">" + moment().fromNow() + "</div>";
   			user_feed += "<br/><div class=\"feed-body\">" + document.getElementById("status-input").value + "</div></div></div><div class=\"clear\"></div>"; 
      		$(".items").prepend(user_feed);
      		$("textarea#status-input").val("");      					
    		document.getElementById("counterspan").innerHTML = 0;
      	}
     });
     return false;
}

function generateFeedItem(username, avatar, post_body)
{
    var curr_user = "{{g.user.username}}" 
    return "<div class=\"user-feed\"><div class=\"feed-img\">" + "<img src=\"" + avatar + "\"></div>" +
     "<div class=\"feed-right\"><div class=\"feed-username\">" + username + "</div>" +
     "<div class=\"feed-time\">" + moment().fromNow() + "</div>" +
     "<br/><div class=\"feed-body\">" + post_body + "</div></div></div><div class=\"clear\"></div>"; 
}
function addItemToFeed(username, avatar, body)
{
    var feed_item = generateFeedItem(username, avatar, body);
    $(".items").prepend(feed_item);
}

var page_num = 1;
var end = false;
function lastAddedLiveFunc(loadingImg, url) {
	$('div#lastPostsLoader').html('<div class=\"user-feed\" style=\"text-align: center;\"><img src=\"' + loadingImg + '\"></div>');
    $.getJSON($SCRIPT_ROOT + url, {page:page_num++}, function(data) {        
    if (data.result != "") {
		var feeds = JSON.parse(data.result);
			
		for (var key in feeds) {
			var feed = feeds[key];
   			for (var key in feed) {
   				var post = feed[key];
   				var user_feed = "<div class=\"user-feed\"><div class=\"feed-img\">" + "<img src=\"" + post.avatar + "\"></div>";
   				user_feed += "<div class=\"feed-right\"><div class=\"feed-username\">" + post.username + "</div>";
   				user_feed += "<div class=\"feed-time\">" + moment(post.time, "YYYY-MM-DD HH:mm Z").fromNow() +  "</div>";
   				user_feed += "<br/><div class=\"feed-body\">" + post.body + "</div></div></div><div class=\"clear\"></div>"; 
      			$(".items").append(user_feed);
   			}
		}
    }
    $('div#lastPostsLoader').empty();
    if (data.result == "") {  
    	if (end != true) {
    		var user_feed = "<div class=\"end-feed\">" + "<h4>You have reached the end!</h4>" + "</div>";
    		$(".items").append(user_feed);            		
    		end = true;
    	}	
   	}   
   	});
}

function isLastPage() {
	return end;
}
