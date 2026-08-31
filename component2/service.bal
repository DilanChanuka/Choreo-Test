import ballerina/http;
import ballerina/log;

service / on new http:Listener(9090) {

    resource function get .() returns string {
        log:printInfo("component 2");
        return "component 2";
    }
}
