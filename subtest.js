var pgPubsub = require("pg-pubsub");

var psInstance = new pgPubsub('postgres://mguse@localhost/mguse');

psInstance.addChannel('topic', function (channelPayload) {
    console.log('Payload: ', channelPayload);
});
