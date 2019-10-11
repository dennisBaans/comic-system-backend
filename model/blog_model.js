var DB = require('../db').DB;

module.exports.BlogModel = class BlogModel{

  constructor(){
    this.db = new DB();
  }

  getBlogEntries(cb){
    var query = `SELECT blog.id, blog.title, blog.text, user_login.username, blog.published, blog.edited, blog.visable 
                  FROM blog
                   LEFT JOIN user_login on user_login.id = blog.user_id
                  ORDER BY published DESC`;
    this.db.query(query, cb);
  }

  getBlogEntry(data, cb){
    var query = `SELECT blog.id, blog.title, blog.text, user_login.username, blog.published, blog.edited, blog.visable
                  FROM blog
                   LEFT JOIN user_login on user_login.id = blog.user_id
                  WHERE blog.id = ${data.blogID}`;
    this.db.query(query, cb);
  }

  createBlogEntry(data, cb){
    console.log(data);
    console.log(`INSERT INTO blog (title, text, user_id, published, visable) 
    VALUES ('${data.title}', '${data.text}', ${data.userID}, NOW(), ${data.visable} )`);
    var query = `INSERT INTO blog (title, text, user_id, published, visable) 
                  VALUES ('${data.title}', '${data.text}', ${data.userID}, NOW(), ${data.visable} ) RETURNING id`;
    this.db.query(query, cb);
  }

  updateBlogEntry(data, cb){
    console.log(`UPDATE blog SET
    title = '${data.title}',
    text = '${data.text}',
    user_id = ${data.userID},
    edited = NOW(),
    visable = ${data.visable}`);
    var query = `UPDATE blog SET
                  title = '${data.title}',
                  text = '${data.text}',
                  user_id = ${data.userID},
                  edited = NOW(),
                  visable = ${data.visable}
                  WHERE id = ${data.blogID}`;
    this.db.query(query, cb);
  }

  deleteBlogEntry(data, cb){
    var query = `DELETE FROM blog WHERE id = ${data.blogID}`;
    this.db.query(query, cb);
  }


}