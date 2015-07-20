var pusher = new Pusher('99b6cb58a1159ad76403', {
      encrypted: true
    });
    var channel = pusher.subscribe('test_channel');
    channel.bind('my_event', function(data) {
      alert(data.word);
    });