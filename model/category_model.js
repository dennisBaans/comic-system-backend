var DB = require('./../db').DB;

module.exports.CategoryModel = class CategoryModel{

  constructor(){
    this.db = new DB();
  }

  getLatestContent(user_role, cb){
    var query = `SELECT id, name, author, description, year, content_folder_status_id, visable, alter_name, cover
                  FROM content_folder 
                  WHERE 
                    visable <= ${user_role}
                  ORDER BY content_folder.published DESC 
                  LIMIT 30`;
    this.db.query(query, cb);
  }

  getGenre(data, cb){
    var query = `SELECT content_folder.id, content_folder.name, content_folder.author, content_folder.description, content_folder.year, 
	                      content_folder.content_folder_status_id, content_folder.visable, content_folder.alter_name, content_folder.cover
                 FROM content_folder
	                    INNER JOIN content_folder_genre ON content_folder.id = content_folder_genre.content_folder_id
	                    INNER JOIN genre ON genre.id = content_folder_genre.genre_id
                 WHERE 
	                  genre.name = '${data.catID}' AND
                    visable <= ${data.roleID}              
                 ORDER BY name`;
    this.db.query(query, cb);
  }

  getGoingOn(data, cb){
    let query = `SELECT content_folder.id, content_folder.name, content_folder.author, content_folder.description, content_folder.year, 
	                      content_folder.content_folder_status_id, content_folder.visable, content_folder.alter_name, content_folder.cover
                 FROM content_folder
	                    INNER JOIN user_read_content_folder ON content_folder.id = user_read_content_folder.content_folder_id
                 WHERE 
                    read_status = 'laufend' AND
                    user_read_content_folder.user_account_id = ${data.userID} AND
                    visable <= ${data.roleID}              
                 ORDER BY COALESCE(user_read_content_folder.edited, user_read_content_folder.published) DESC`;
    this.db.query(query, cb);
  }

}
