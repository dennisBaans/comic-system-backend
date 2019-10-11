var DB = require('./../db').DB;

module.exports.VisableModel = class VisableModel{

  constructor(){
    this.db = new DB();
  }

  getVisables(cb){
    var query = `SELECT id, name FROM visable`;
    this.db.query(query, cb); 
  }

}