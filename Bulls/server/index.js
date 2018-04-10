var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var userList = [];
var player1 = [];
var player2 = [];
var currentPlayer = [];
var counter = 0;
var playerFirst = "true";

app.get('/', function(req, res){
    res.sendFile(__dirname + '/index.html');
});

http.listen(8080, function(){
   console.log('listening on *:8080');
});

io.on('connection', function(clientSocket){
  
  clientSocket.on('setPlayers', function(msg){
    if (counter == 0){
      player1[0] = msg[0];
      player1[1] = msg[1];
      console.log("Player 1 made"); 
    } else if (counter == 1) {
      player2[0] = msg[0];
      player2[1] = msg[1];
      var starGame = true;
      console.log("Player 2 made");
      currentPlayer = player1;
    } else { }
    counter++;
    clientSocket.broadcast.emit('setPlayers', starGame);
  });

  console.log('a user connected');

  clientSocket.on('rounds', function(nextRound){
    console.log("chaning turn " + nextRound );
    clientSocket.broadcast.emit('rounds', nextRound);
  });

  clientSocket.on('getSuggestion', function(msgSuggest){
    var suggetion = msgSuggest.split('');
    var bulls = 0;
    var cows = 0;
    if (currentPlayer == player1) {
    console.log("player1 turn");
    var playerNumber = player2[1].split('');
    
    for (var i=0; i<suggetion.length; i++) {
      for (var j=0; j<suggetion.length; j++) {
        if (playerNumber[i] == suggetion[j]){
          if (i == j) {
            bulls++;
          }
          else {
            cows++;
          }
        }
      }
    }
    var msg = currentPlayer[0] + " suggested " + msgSuggest+'\n'+"Has 🐂 (Bulls): " +bulls+ " 🐄 (Cows): " + cows+'\n';
    if (bulls == 4) {
      msg = currentPlayer[0]+" you win Yay!";
    }
    currentPlayer = player2;
  }
  else {
    var playerNumber = player1[1].split('');
    console.log("player2 turn");
    for (var i=0; i<suggetion.length; i++) {
      for (var j=0; j<suggetion.length; j++) {
        if (playerNumber[i] == suggetion[j]){
          if (i == j) {
            bulls++;
          }
          else {
            cows++;
          }
        }
      }
    }
    var msg = currentPlayer[0] + " suggested " + msgSuggest+'\n'+"Has 🐂 (Bulls): " +bulls+ " 🐄 (Cows): " + cows+'\n';
    if (bulls == 4) {
      msg = currentPlayer[0]+" you win Yay!";
    }
    currentPlayer = player1;
  }
    io.emit('getSuggestion', msg);
  });

  clientSocket.on('disconnect', function(){
    console.log('user disconnected');

    /*var info;
    for (var i=0; i<userList.length; i++) {
      if (userList[i]["id"] == clientSocket.id) {
        userList[i]["isConnected"] = false;
        info[0] = userList[i]["name"];
        info[1] = userList[i]["number"];
        break;
      }
    }*/
  });


  /*clientSocket.on("exitUser", function(clientNickname){
    for (var i=0; i<userList.length; i++) {
      if (userList[i]["id"] == clientSocket.id) {
        userList.splice(i, 1);
        break;
      }
    }
    io.emit("userExitUpdate", clientNickname);
  });*/

  /*clientSocket.on("getOtherPlayer", function(clientNickname){
    
    io.emit("getOtherPlayer", clientNickname);
  });*/

  clientSocket.on('connectUser', function(info) {
    var message = "Player " + info[0] + " was connected with number: "+ info[1];
    console.log(message);

    var userInfo = {};
    var foundUser = false;
    for (var i=0; i<userList.length; i++) {
      if (userList[i]["name"] == info[0]) {
        userList[i]["number"] = info[1];
        userList[i]["isConnected"] = true;
        userList[i]["id"] = clientSocket.id;
        userInfo = userList[i];
        foundUser = true;
        break;
      }
    }

    if (!foundUser) {
      userInfo["id"] = clientSocket.id;
      userInfo["name"] = info[0];
      userInfo["number"] = info[1];
      userInfo["isConnected"] = true;
      userList.push(userInfo);
    }

    io.emit("userList", userList);
    //io.emit("userConnectUpdate", userInfo);
    console.log("Connected");
  });

});