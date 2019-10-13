var DB = require('./../db').DB;
var cloudinary = require('cloudinary');
var fs = require('fs');

cloudinary.config({
    cloud_name: 'baka',
    api_key: '833616321385657',
    api_secret: 'MjmRmf1eqJzNrFjEJBGedyPqO0I'
});

module.exports.CoverModel = class CoverModel{

  constructor(){
    this.db = new DB();
  }

  uploadCover(mangaID, data, cb){
    console.log("upload Cover " + data.image.path);
    console.log("================================");
    console.log(data);
    var manga = data.manga;
    console.log("manga: ");
    console.log(typeof(manga));
    console.log("name: ");
    console.log(manga.name);

    
    cloudinary.v2.uploader.upload(data.image.path, {public_id: `cover/${manga.name}_cover`}, (error, result) => {
      if(result){
        console.log(result);
        manga.cover = result.secure_url;
        fs.unlinkSync(data.image.path);
        cb(mangaID, manga);  
      }else{
        console.log(error); 
      }
    });

  }

  getCover(id, cb){
    var query = `SELECT id, url
                 FROM cover
                 WHERE content_folder_id = ${id}`;
    this.db.query(query, cb);
  }

  putCover(id, cover, cb){
    console.log(cover);
    
    // Bild upload to cloudinary
    var url = 'example.com';

    // content_folder Update
    var query = `UPDATE cover
                  SET
                  url = '${url}' 
                WHERE id = ${id}`;
    this.db.query(query, cb);
  }

  postCover(id, cover, cb){
    console.log("Cover hochladen")
    console.log(cover);

    // Bild upload to cloudinary
    var url = 'example.com';

    var query = `INSERT INTO cover(
      content_folder_id, url
    ) VALUES (
      ${id},'${url}'
    ) RETURNING id`;

    this.db.query(query, cb);
  }

  deleteCover(id, cb){
    var query = `DELETE FROM cover WHERE id = ${id}`;
    this.db.query(query, cb);
  } 

}
