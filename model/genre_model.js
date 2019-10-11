var DB = require('./../db').DB;

module.exports.GenreModel = class GenreModel{

  constructor(){
    this.db = new DB();
  }

  getGenres(cb){
    var query = `SELECT id, name FROM genre ORDER BY name`;
    this.db.query(query, cb); 
  }

}
