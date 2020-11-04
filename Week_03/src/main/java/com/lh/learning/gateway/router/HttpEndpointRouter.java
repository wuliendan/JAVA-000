package com.lh.learning.gateway.router;

import java.util.List;

public interface HttpEndpointRouter {

    String route(List<String> endpoint);
}
