var pusher = new Pusher('99b6cb58a1159ad76403', {
      encrypted: true,
      disableStats: true
    });
    var channel = pusher.subscribe('test_channel');
    channel.bind('my_event', function(data) {

    	var c = document.getElementById("myCanvas");
		var ctx = c.getContext("2d");
		ctx.clearRect(0, 0, c.width, c.height);
		ctx.font = "30px Arial";
		ctx.fillStyle = data.color;
		ctx.fillText(data.word,10,50);
		//alert(data.word);
    });