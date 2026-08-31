import ballerina/http;
import ballerina/log;

// Points at component2's public URL.
configurable string component2Url = "https://e53fea87-942f-493a-9fa3-21d2bb1b4436-dev.e1-us-east-azure.choreoapis.dev/testproject02/component2/v1.0";

// OAuth2 access token generated from component2's Test Console in Choreo Console
// (component2 -> Test -> Console -> Generate/copy the token shown there).
// Sent as "Authorization: Bearer <token>" per Choreo Connect's www-authenticate response.
configurable string component2AccessToken = "";

final http:Client component2Client = check new (component2Url);

service / on new http:Listener(9090) {

    // Calls component2 before responding, mirroring Updates Manager -> Updates Creator.
    resource function get .() returns string {
        log:printInfo("component 1");

        log:printInfo("component 1 calling component 2", targetUrl = component2Url);
        string|http:ClientError result = component2Client->/.get(
                headers = {"Authorization": string `Bearer ${component2AccessToken}`});

        if result is http:ClientError {
            log:printError("component 1 failed to receive response from component 2",
                    result, targetUrl = component2Url);
            return string `component 1, component2 call failed: ${result.message()}`;
        }

        log:printInfo("component 1 received response from component 2", response = result);
        return string `component 1, component2 response: ${result}`;
    }
}
