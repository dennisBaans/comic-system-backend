var DB = require('./../db').DB;

module.exports.ContentFolderStatusModel = class ContentFolderStatusModel{

  constructor(){
    this.db = new DB();
  }

  getStatus(cb){
    var query = `SELECT id, name FROM content_folder_status`;
    this.db.query(query, cb); 
  }

}