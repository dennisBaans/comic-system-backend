var DB = require('../db').DB;

module.exports.ReadModel = class ReadModel{

  constructor(){
    this.db = new DB();
  }

  getUserRead(data, cb){
    let query = `SELECT id, content_folder_id, content_id, page_number, published, edited, read_status, user_account_id
                 FROM user_read_content
                 WHERE 
                   user_account_id = ${data.userID} AND
                   content_id = ${data.chapterID}`;
    this.db.query(query, cb);
  }

  saveReadContentFolderStatus(data, cb){
    var query = `INSERT INTO user_read_content_folder  (published, content_folder_id, user_account_id, read_status) 
                 VALUES (NOW(), ${data.contentFolderID}, ${data.userID}, '${data.readStatus}')
                 RETURNING id, read_status`;
    this.db.query(query, cb); 
  }

  saveReadContentStatus(data, cb){
    var query = `INSERT INTO user_read_content (published, content_folder_id, content_id, user_account_id, read_status, page_number)
                 Values (NOW(), ${data.contentFolderID}, ${data.contentID}, ${data.userID}, '${data.readStatus}', ${data.pageNum})
                 RETURNING id, read_status, page_number`;
    this.db.query(query, cb);
  }

  updateReadContentFolderStatus(data, cb){
    var query = `UPDATE user_read_content_folder SET read_status = '${data.readStatus}', edited = NOW() WHERE id = ${data.readID}
                 RETURNING id, read_status`;
    this.db.query(query, cb);
  }

  updateReadContentStatus(data, cb){
    var query = `UPDATE user_read_content SET read_status = '${data.readStatus}', page_number = ${data.pageNum}, edited = NOW() WHERE id = ${data.readID}
                 RETURNING id, read_status, page_number`;
    this.db.query(query, cb);
  }

}