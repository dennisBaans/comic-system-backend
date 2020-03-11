var pg = require('pg');

const configDev = {
    user: 'itachidhdr',
    database: 'comicsystem',
    password: process.env.DB_PW,
    port: '5432',
    max: 100,
    idleTimeoutMillis: 30000
}

const configProd = {
    connectionString: process.env.DATABASE_URL,
        ssl: true
}

module.exports.DB = class DB{

    constructor(){
        let config = process.env.DATABASE_URL ? configProd : configDev;
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
