var pgPubsub = require("pg-pubsub");

var psInstance = new pgPubsub('postgres://mguse@localhost/mguse');

var i = 1;

psInstance.publish('topic', { Message: i });

// psInstance.publish('topic', { hello: "world"});
