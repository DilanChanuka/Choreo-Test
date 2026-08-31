import ballerina/http;
import ballerina/log;

configurable int listenPort = 9091;

service / on new http:Listener(listenPort) {

    resource function get .() returns string {
        log:printInfo("component 2");
        return "component 2";
    }
}
