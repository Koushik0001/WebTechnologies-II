package websocket;

import java.util.HashSet;
import java.util.Set;
import javax.websocket.Endpoint;
import javax.websocket.server.ServerApplicationConfig;
import javax.websocket.server.ServerEndpointConfig;


public class EchoEndpointConfiguration implements ServerApplicationConfig{

    @Override
    public Set<ServerEndpointConfig> getEndpointConfigs(Set<Class<? extends Endpoint>> endpointClasses) {
        Set<ServerEndpointConfig> result = new HashSet<>();
        
        if(endpointClasses.contains(EchoEndpoint.class)){
            result.add(ServerEndpointConfig.Builder.create(EchoEndpoint.class, "/websocket/echo").build());
        }
        return result;
    }

    @Override
    public Set<Class<?>> getAnnotatedEndpointClasses(Set<Class<?>> scanned) {
        return null;
    }
    
}
