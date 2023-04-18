package websocket;

import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.websocket.CloseReason;
import javax.websocket.Endpoint;
import javax.websocket.EndpointConfig;
import javax.websocket.MessageHandler;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint;
import javax.websocket.Session;

@ServerEndpoint("/websocket/chat")
public class ChatEndpoint {

    static List<ChatEndpoint> clients = new CopyOnWriteArrayList<ChatEndpoint>(); 
    Session session;

    @OnOpen
    public void onOpen(Session session, EndpointConfig endpointConfig){
        this.session = session;
        clients.add(this);
    }

    @OnClose
    public void OnClose(Session session, CloseReason reason){
        System.out.println("Socked Closed: "+ reason.getReasonPhrase());
        clients.remove(this);
    }

    @OnMessage
    public void onMessage(String message){
        broadcast(message);
    }

    private void broadcast(String message){
        for(ChatEndpoint client : clients){
            try{
                client.session.getBasicRemote().sendText(message);
            }catch(IOException e){
                clients.remove(this);
                try{
                    client.session.close();
                }catch(IOException e1){
                    //do nothing
                }
            }
        }
    }
}
