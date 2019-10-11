var DB = require('../db').DB;

module.exports.CounterModel = class CounterModel{

  constructor(){
    this.db = new DB();
  }

  increaseCounter(data, cb){
    var query = `INSERT INTO content_folder_counter (published, content_folder_id, user_account_id) 
                 VALUES (NOW(), ${data.mangaID}, ${data.userID})`;
    this.db.query(query, cb); 
  }

}