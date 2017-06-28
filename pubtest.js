var pgPubsub = require("pg-pubsub");

var psInstance = new pgPubsub('postgres://mguse@localhost/mguse');

var msgNum = 0;

for (var i = 0; i < 100; i++) {

	console.log('msgNum: ', i);

	psInstance.publish('topic', { Message: i});

}