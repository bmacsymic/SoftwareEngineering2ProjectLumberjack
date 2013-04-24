var page_num = 1;
var end = false;
function lastAddedLiveFunc(loadingImg, url) 
{
	$(document).ready(function() {
	load_users() ;
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
    });
}
 
function load_users() 
{
	  $('#user-table').jtable({
	    title: 'Following',
	    selecting: true,
	    multiselect: true,
	    selectOnRowClick: true,
	    defaultSorting: 'Name ASC',
	    loadingAnimationDelay: 0,
	    actions: {
	      listAction: '/followers/get_followers',
	    },
	    fields: {
	      id:  {
	        key: true,
	        list: false
	      },
	      username: {
	        title: 'Name',
	        width: '40%'
	      }
	    }});
      //Load student list from server
      $('#user-table').jtable('load'); 
}

function delete_button(loadingImg, url) 
{
	$(document).ready(function() {
		$('#DeleteAllButton').button().click(function () {
			var $selectedRows = $('#user-table').jtable('selectedRows');
			if ($selectedRows.length > 0) {
	            $selectedRows.each(function () {
	                var record = $(this).data('record');
	                $.getJSON($SCRIPT_ROOT + '/follow_btn', {
	      				followee: record.id,
	      				state: "Unfollow"
	      			});
	            });
	           //refresh tables and vars 
	           load_users() ; 
	           $('.items').empty() ;
	           page_num = 1;
			   end = false;
			   //call the server for new data 
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
			return true;
		});
	});	
}

function isLastPage() {
	return end;
}