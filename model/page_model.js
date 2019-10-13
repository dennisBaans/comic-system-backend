var DB = require('./../db').DB;
var cloudinary = require('cloudinary');
var fs = require('fs');

cloudinary.config({
    cloud_name: 'baka',
    api_key: '833616321385657',
    api_secret: 'MjmRmf1eqJzNrFjEJBGedyPqO0I'
});

module.exports.PageModel = class PageModel{

  constructor(){
    this.db = new DB();
  }

  upgradePages(mangaName, chapter, pages, cb){
    console.log("upgrade Pages");

    // Erst Deleten, dann uploadPages
    var query = `SELECT cloud_id FROM page WHERE chapter_id = ${chapter.id}`;
    this.db.query(query, (result) => {

      result.body.forEach( (page) => {
        cloudinary.v2.uploader.destroy(page, (error, result) => {
          if(error){
            console.log('Error: ' + error);
          }
        });
      });

      this.uploadPages(mangaName, chapter, pages, cb);

    });
  }

  uploadPages(mangaName, chapter, pages, cb){
    console.log("upload Pages");

    var done = 0;
    var pagesData = [];

    pages.forEach((page, index) => {
      console.log("Page + Index");
      console.log(index);
      console.log(page);

      cloudinary.v2.uploader.upload(page.path,
        {public_id: `${mangaName}/${chapter.number}/[Baka]_${mangaName}_${chapter.number}_${index}`}, (error, result) => {

        if(result){
          console.log(result);
          done++;
          pagesData[index] = {'url': result.secure_url, 'cloud_id': result.public_id};
          fs.unlinkSync(page.path);
          if(done >= pages.length){
            cb(pagesData);  
          }
        }else{
          console.log(error); 
        }
      });
    });
  }

  putPage(chapterID, pagesData, cb){
    //Alte Pages deleten und dann neue anlegen
    var query = `DELETE FROM page WHERE chapter_id = ${chapterID}`;
    this.db.query(query, (result) => {

      this.postPage(chapterID, pagesData, cb);

    });

  }

  deletePages(chapterID, cb){
    // Pages aus der Cloud löschen 
    var query = `SELECT cloud_id FROM page WHERE chapter_id = ${chapterID}`;
    this.db.query(query, (result) => {

      result.body.forEach( (page) => {
        cloudinary.v2.uploader.destroy(page, (error, result) => {
          if(error){
            console.log('Error: ' + error);
          }
        });
      });

    });

    //Alte Pages deleten 
    var query = `DELETE FROM page WHERE chapter_id = ${chapterID}`;
    this.db.query(query, cb);

  }

  postPage(chapterID, pagesData, cb){

    // content_folder_genre Insert
    var query = `INSERT INTO page (chapter_id, url, number, cloud_id) VALUES `;
    pagesData.forEach( (page, number) => {
      query += `(${chapterID}, '${page.url}', ${number}, '${page.cloud_id}'),`
    });
    query = query.slice(0,-1);
    this.db.query(query, cb); 
  }
}
