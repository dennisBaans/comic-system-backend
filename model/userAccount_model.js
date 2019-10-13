var DB = require('./../db').DB;
var crypto = require('crypto');
var jwt = require('jsonwebtoken');



module.exports.UserAccount = class UserAccount{

  constructor(){
    this.db = new DB();
  }

  getUsers(cb){
    var query = `SELECT user_account.id, email, username, user_role_id, published, birth, profile_pic
                 FROM user_account, user_login
                 WHERE
                    user_account.id = user_login.user_account_id
                 ORDER BY username`;
    this.db.query(query, cb);
  }

  getUser(id, cb){
    var query = `SELECT user_account.id, user_account.email, user_account.birth, user_account.published, 
                  user_account.profile_pic, user_account.user_role_id, user_login.username
                 FROM user_account INNER JOIN user_login on user_login.user_account_id = user_account.id
                 WHERE user_account.id = ${id}`;
    this.db.query(query, cb);
  }

  putUser(id, user, cb){
    console.log("Put (Save) User: ");
    user.birth = new Date(user.birth);
    
    if(this._validateUser(user)){
      var query = `UPDATE user_account
                    SET
                    user_role_id = ${user.user_role_id} ,
                    email = '${user.email}',
                    birth = to_timestamp(${user.birth.getTime()} / 1000.0),
                    profile_pic = '${user.profile_pic}'
                  WHERE id = ${id}`;
      this.db.query(query, cb);
    }else{
      cb({type: false, body: 'Eingaben ungültig'});
    }
 }

 validateUserLogin(credentials, cb){
  console.log(credentials);

  // search Username
  var query = `SELECT user_account.id, username, user_account.user_role_id, password_hash, password_salt 
              FROM user_login, user_account 
              WHERE username = '${credentials.username}' AND user_account_id = user_account.id`;
  this.db.query(query, (result) => {
    if(result.body.length > 0){
      // Hash Password
      var user = result.body[0];
      var hash = crypto.pbkdf2Sync(credentials.password, user.password_salt, 1000, 64, 'sha512').toString('hex');

      // compare Passwords
      if(user.password_hash === hash){
        console.log("User einloggen");
        var jwt = this._generateJWT(user);
        result.body = {token: jwt};
        cb(result);
      }else{
        console.log("Falsches PW");
        result.body = {token: null};
        cb(result);
      }
    }else{
      console.log("User nicht gefunden");
      result.body = {token: null};
      cb(result);
    }
  });
 }


  postUser(data, cb){

    if(this._validateUser(data.user) && this._validateCredentials(data.credentials)){
      var user = data.user;
      user.birth = new Date(user.birth);

      // user_account INSERT
      var query = `INSERT INTO user_account(
        user_role_id, published, email, birth
      ) VALUES (
        ${user.user_role_id}, NOW(), '${user.email}',to_timestamp(${user.birth.getTime()} / 1000.0)
      ) RETURNING id`;

      this.db.query(query, (result) => {

        if(result.type){
          var id = result.body[0].id;
          var credentials = this._generateLogin(data.credentials, id);

          var query = `INSERT INTO user_login(
            username, password_salt, password_hash, hash_algorythmus, user_account_id
          ) VALUES (
            '${credentials.username}', '${credentials.password_salt}','${credentials.password_hash}','${credentials.hash_algorythmus}',${id}
          )`;
          this.db.query(query, (result) => {
            result.body.done = true;
            console.log(result);
            cb(result);
          });

        }else{
          cb({type: false, body: 'Etwas ist schief gegangen'});
        }
      });
    }else{
      cb({type: false, body: 'Eingaben ungültig'});
    }


  }

  deleteUser(id, cb){
    var query = `DELETE FROM user_account WHERE id = ${id}`;
    this.db.query(query, (result) => {
      if(result.type){
        query = `DELETE FROM user_login WHERE user_account_id = ${id}`;
        this.db.query(query, cb);
      }else{
        cb(result);
      }
    });


  }

  usernameUnique(username, cb){
    var query = `SELECT CAST(CASE WHEN COUNT(1) > 0 THEN 0 ELSE 1 END AS bit) as uniqueness
                  FROM user_login WHERE username = '${username}'`;
    this.db.query(query, cb);
  }

  emailUnique(email, cb){
    var query = `SELECT CAST(CASE WHEN COUNT(1) > 0 THEN 0 ELSE 1 END AS bit) as uniqueness
                  FROM user_acount WHERE email = '${email}'`;
    this.db.query(query, cb);
  }


  _generateLogin(credentials, userAccoundID){
    var login = {};

    login.username = credentials.username;
    login.password_salt = crypto.randomBytes(16).toString('hex');
    login.password_hash = crypto.pbkdf2Sync(credentials.password, login.password_salt, 1000, 64, 'sha512').toString('hex');
    login.hash_algorythmus = userAccoundID;

    return login;  
  }

  _validateUser(user){
    if(user.email.match(/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/)){
      return true;
    }
    return false;
  }
  _validateCredentials(credentials){
    if(credentials.username.match(/^[a-zA-Z0-9]{4,16}$/)){
      return true;
    }
    return false; 
  }

  _generateJWT(user){
    console.log(user);
    var expiry = new Date();
    expiry.setDate(expiry.getDate() + 7);
  
    return jwt.sign({
      id: user.id,
      username: user.username,
      role_id: user.user_role_id,
      exp: parseInt(expiry.getTime() / 1000),
    }, process.env.MY_SECRET); // DO NOT KEEP YOUR SECRET IN THE CODE! 
  }

}





