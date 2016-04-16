var mqtt = require('mqtt');
var mqttclient = mqtt.connect('mqtt://15.1.4.50');
var dash_button = require('node-dash-button');
console.log("setting dash MAC and interface");
var dash = dash_button("74:c2:46:ff:ff:ff", "eth0");
console.log("starting detect loop...");
dash.on("detected", function (){
 console.log("dashbutton/peets pressed, mqtt sent");
 mqttclient.publish('dashbutton/peets', '1');
});
