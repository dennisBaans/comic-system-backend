var DB = require('./../db').DB;

module.exports.UserRoleModel = class UserRoleModel{

  constructor(){
    this.db = new DB();
  }

  getUserRoles(cb){
    var query = `SELECT id, name FROM user_role`;
    this.db.query(query, cb); 
  }

}