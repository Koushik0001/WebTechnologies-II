"use strict";

var Echo = Echo || {};

Echo.sendMessage = function(){
    var echo = document.querySelector("#echo");
    var message = echo.val();
    if(message != ''){
        echo.socket.send(message);
        echo.val('');
    }
}

Echo.connect = function(host){
    if("WebSocket" in window)
        Echo.socket = new WebSocket(host);
    else
    {
        console.log("Error : WebSocket is not supported by this browser.");
    }

    Echo.socket.onopen = function(){
        console.log("Info : Connection opened.");
        document.querySelector("#echo").keydown(function (evt){
            if(evt.keyCode == 13)
            Echo.sendMessage();
        });
    };
    Echo.socket.onclose = function(){
        console.log("Info : Connection closed.");
    }
    Echo.socket.onmessage = function(){
        console.log("message : " + message.data)
        document.querySelector("#echoBack").text(message.data);
    }
};

Echo.initialize = function(){
    var ep = "/websocket/echo";
    if(window.location.protocol == "http"){
        Echo.connect("ws://" + window.location.host + ep);
    }
    else{
        Echo.connect("wss://" + window.location.host + ep);
    }
};

Echo.initialize();