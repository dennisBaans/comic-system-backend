var DB = require('../db').DB;

module.exports.CommentModel = class CommentModel{

  constructor(){
    this.db = new DB();
  }

  getComments(parentType, parentID, cb){
    var query = `SELECT comment.id, to_char(comment.published, 'DD. FMMonth YYYY') as published, to_char(comment.edited, 'DD. FMMonth YYYY') as edited, comment.text, 
                   user_login.username, user_account.profile_pic, user_account.id as user_account_id,
                   json_agg(reply)	as replys										   
                 FROM comment
                   LEFT JOIN (SELECT reply.id, to_char(reply.published, 'DD. FMMonth YYYY') as published, to_char(reply.edited, 'DD. FMMonth YYYY') as edited, reply.text, reply.comment_id, user_login.username, user_account.profile_pic, user_account.id as user_account_id 
                   FROM comment_reply reply
                     LEFT JOIN user_account on user_account.id = reply.user_account_id
                     LEFT JOIN user_login on user_login.user_account_id = user_account.id
                   ORDER BY reply.published
                   ) reply	on reply.comment_id = comment.id					   
                   INNER JOIN user_account on user_account.id = comment.user_account_id
                   INNER JOIN user_login on user_login.user_account_id = user_account.id									
                 WHERE parent_type = ${parentType} AND parent_id = ${parentID}
                 GROUP BY comment.id, user_login.username, user_account.profile_pic, user_account.id
                 ORDER BY comment.published`;
      this.db.query(query, cb); 
    }

    saveComment(user, parentType, parendID, text, cb){
      var query = `INSERT INTO comment (user_account_id, parent_type, parent_id, text, published) 
                  VALUES (${user}, ${parentType}, ${parendID}, '${text}', NOW()) RETURNING id`;   
      this.db.query(query, cb);
    }

    updateComment(id, text, cb){
      var query = `UPDATE comment SET text = '${text}', edited = NOW() WHERE id = ${id}`;
      console.log(query);
      this.db.query(query, cb);
    }

    deleteComment(id, cb){
      var query = `DELETE FROM comment WHERE id = ${id}`;
      this.db.query(query, () => {
        query = `DELETE FROM comment_reply WHERE comment_id = ${id}`;
        this.db.query(query, cb);
      });
    }

    saveCommentReply(user, commentID, text, cb){
      var query = `INSERT INTO comment_reply (user_account_id, comment_id, text, published) 
                  VALUES (${user}, ${commentID}, '${text}', NOW()) RETURNING id`;   
      this.db.query(query, cb);
    }

    updateCommentReply(id, text, cb){
      var query = `UPDATE comment_reply SET text = '${text}', edited = NOW() WHERE id = ${id}`;
      console.log(query);
      this.db.query(query, cb);
    }

    deleteCommentReply(id, cb){
      var query = `DELETE FROM comment_reply WHERE id = ${id}`;
      this.db.query(query, cb);
    }



  }