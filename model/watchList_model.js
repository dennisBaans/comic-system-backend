var DB = require('../db').DB;

module.exports.WatchListModel = class WatchListModel{

  constructor(){
    this.db = new DB();
  }

  getWatchList(data, cb){

    var query = `SELECT content_folder.id, content_folder.name, content_folder.author, content_folder.description, content_folder.year, 
                  content_folder.content_folder_status_id, content_folder.visable, content_folder.alter_name, content_folder.cover
                 FROM content_folder
                 INNER JOIN watchlist ON watchlist.content_folder_id = content_folder.id
                 WHERE 
                   watchlist.user_account_id = ${data.userID} AND
                    visable <= ${data.roleID}               
                 ORDER BY name`;
    this.db.query(query, cb);
  }

  getIsInWatchlist(data, cb){
    let query = `select exists(select 1 from watchlist where content_folder_id = ${data.mangaID} AND user_account_id = ${data.userID})`
    this.db.query(query, cb);
  }

  addItem(data, cb){
    var query = `INSERT INTO watchlist (user_account_id, content_folder_id, published) VALUES (${data.userID}, ${data.mangaID}, NOW())`
    this.db.query(query, cb);
  }

  deleteItem(data, cb){
    console.log(data);
    var query = `DELETE FROM watchlist WHERE user_account_id = ${data.userID} AND content_folder_id = ${data.mangaID}`; 
    this.db.query(query, cb);
  }

}