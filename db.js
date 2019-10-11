var pg = require('pg');

const config = {
    user: 'itachidhdr',
    database: 'comic-system',
    password: 'narutodhdr',
    port: '5432',
    max: 100,
    idleTimeoutMillis: 30000
}

module.exports.DB = class DB{

    constructor(){

        this.pool = new pg.Pool(config);

    }

    query(query,cb){
        this.pool.connect((err, client, done) => {
            if(err){
                console.log("not able to get connection "+ err);
                cb({type: false, body: err});
            } 
            client.query(query ,function(err,result) {
                //call `done()` to release the client back to the pool
                done(); 
                if(err){
                    console.log(err);
                    cb({type: false, body: err});
                }else{
                    cb({type: true, body: result.rows});
                }
            });
        });
    };
} 
