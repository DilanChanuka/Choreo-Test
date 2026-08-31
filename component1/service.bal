import ballerina/http;
import ballerina/log;

// Points at component2. For local testing this defaults to localhost.
// When deployed to Choreo, override via Config.toml / environment config
// with component2's internal project-scoped URL, e.g.
// http://component2-<hash>:9090
configurable string component2Url = "http://localhost:9091";

final http:Client component2Client = check new (component2Url);

service / on new http:Listener(9090) {

    // Calls component2 before responding, mirroring Updates Manager -> Updates Creator.
    resource function get .() returns string|error {
        log:printInfo("component 1");

        log:printInfo("component 1 calling component 2", targetUrl = component2Url);
        string response = check component2Client->/.get();
        log:printInfo("component 1 received response from component 2", response = response);

        return string `component 1, component2 response: ${response}`;
    }
}
