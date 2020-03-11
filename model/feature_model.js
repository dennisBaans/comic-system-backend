var DB = require('../db').DB;
var cloudinary = require('cloudinary');
var fs = require('fs');

cloudinary.config({
    cloud_name: 'baka',
    api_key: '833616321385657',
    api_secret: 'MjmRmf1eqJzNrFjEJBGedyPqO0I'
});

module.exports.FeatureModel = class FeatureModel{

  constructor(){
    this.db = new DB();
  }

  getFeatures(cb){
    let query = `SELECT id, content_folder_id, background_url FROM feature ORDER BY id`;
    this.db.query(query, cb); 
  }

  getFeature(data, cb){
    let query = `SELECT id, content_folder_id, background_url FROM feature WHERE id = ${data.id} ORDER BY id`;
    this.db.query(query, cb); 
  }

  postFeature(data, cb){
    let query = `INSERT INTO feature (id, content_folder_id, background_url) VALUES (${data.id}, ${data.content_folder_id}, '${data.background_url}') RETURNING id`;
    console.log(query);
    this.db.query(query, cb);
  }

  putFeature(data, cb){
    let query = `UPDATE feature SET content_folder_id = ${data.mangaID}, background_url = '${data.featureBackgroundURL}' WHERE id = ${data.id}`;
    this.db.query(query, cb);
  }

  switchId(data, cb){
    let query = `UPDATE feature SET id = 0 WHERE id = ${data.secondID}`;
    this.db.query(query, result1 => {
      query = `UPDATE feature SET id = ${data.secondID} WHERE id = ${data.firstID}`;
      this.db.query(query, result2 => {
        query = `UPDATE feature SET id = ${data.firstID} WHERE id = 0`;
        this.db.query(query, cb);
      });
    });
  }

  uploadFeatureBackground(featureID, data, cb){
    cloudinary.v2.uploader.upload(data.image.path, {public_id: `feature/feature_background_${featureID}`}, (error, result) => {
      if(result){
        let featureBackgroundURL = result.secure_url;
        fs.unlinkSync(data.image.path);
        cb(featureBackgroundURL);  
      }else{
        console.log(error); 
      }
    });
  }

  deleteFeature(data, cb){
    let query = `DELETE FROM feature WHERE id = ${data.featureID}`;
    this.db.query(query, result => {

      query = `SELECT id FROM feature WHERE id > ${data.featureID} ORDER BY id ASC`;
      this.db.query(query, resultSelect => {
        console.log(resultSelect);
        for(let index in resultSelect.body){
          let fQuery = `UPDATE feature SET id = id-1 WHERE id = ${resultSelect.body[index].id}`;
          this.db.query(fQuery, ()=>{});
        }
      });
      cb({'type': true, 'body': true});
    });
  }

}
