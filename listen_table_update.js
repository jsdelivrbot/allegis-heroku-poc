var pg = require ('pg');

const Pool = require('pg-pool');
const url = require('url')

const params = url.parse(process.env.DATABASE_URLi||'postgres://nknlrletfhmijy:d38ecdcb9263124d05829c1a52e6df1c7f5d6eba5654dbf3abbaa7be7887810c@ec2-54-221-220-82.compute-1.amazonaws.com:5432/d7fq31b9ftkanl');
const auth = params.auth.split(':');

const config = {
  user: auth[0],
  password: auth[1],
  host: params.hostname,
  port: params.port,
  database: params.pathname.split('/')[1],
  ssl: true
};

const pool = new Pool(config);

pool.connect( function(err, client) {
    if(err) {
        console.log(err);
    }
    client.on('notification', function(msg) {
        if (msg.name === 'notification' && msg.channel === 'table_update') {
            var pl = JSON.parse(msg.payload);
            console.log("*========*");
            Object.keys(pl).forEach(function (key) {
                console.log(key, pl[key]);
            });
            console.log("-========-");
        }
    });
    client.query("LISTEN table_update");
});
