package websocket;

import java.io.IOException;
import java.util.Calendar;
import javax.websocket.Endpoint;
import javax.websocket.EndpointConfig;
import javax.websocket.MessageHandler;
import javax.websocket.RemoteEndpoint;
import javax.websocket.Session;

public class EchoEndpoint extends Endpoint{

    @Override
    public void onOpen(Session session, EndpointConfig config) {
        RemoteEndpoint.Basic remoteEndpointBasic = session.getBasicRemote();
        session.addMessageHandler( new EchoMessageHandler(remoteEndpointBasic));
    }
    
    
    private static class EchoMessageHandler implements MessageHandler.Whole<String>{
        
        private final RemoteEndpoint.Basic remoteEndpointBasic;

        private EchoMessageHandler(RemoteEndpoint.Basic remoteEndpointBasic) {
            this.remoteEndpointBasic = remoteEndpointBasic;
        }
        
        

        @Override
        public void onMessage(String message) {
            try {
                if (remoteEndpointBasic != null) {
                    remoteEndpointBasic.sendText("Time: " + Calendar.getInstance() .getTime()+"\nServer Response : "+message + "\n\n");
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
    }
}

