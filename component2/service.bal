import ballerina/http;
import ballerina/log;

// 9090 is the Choreo-standard component port. Overridden to 9091
// via Config.toml for local side-by-side testing with component1.
configurable int listenPort = 9090;

service / on new http:Listener(listenPort) {

    resource function get .() returns string {
        log:printInfo("component 2");
        return "component 2";
    }
}
