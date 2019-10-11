var DB = require('./../db').DB;
var readModel = require('./read_model').ReadModel;

module.exports.ChapterModel = class ChapterModel{

  constructor(){
    this.db = new DB();
  }

  getChapters(mangaID, cb){
    var query = `SELECT id, name, number, published, visable 
                 FROM content
                 WHERE 
                   content_folder_id = ${mangaID}
                  ORDER BY number`;
    this.db.query(query, cb); 
  }

  getChapter(id, cb){
    var query = `SELECT id, name, number, content_folder_id, user_account_id, published, visable
                 FROM content
                 WHERE id = ${id}`;
    this.db.query(query, (result) => {

      query = `SELECT url FROM page WHERE chapter_id = ${id}`;
      this.db.query(query, (pageResult) => {
        if(result.type){
          result.body[0].pages = pageResult.body.map(x => x.url);        
        }
        cb(result);
      })

    });
  }

  getCurrentChapter({userID, mangaID, userRole}, cb){
    var query = `SELECT content.id, content.name, content.number, content.visable, content.published, content.user_account_id, 
                  content.content_folder_id,  json_agg(json_build_object('number', page.number, 'url', page.url) ORDER BY page.number) as pages
                 FROM content INNER JOIN page on page.chapter_id = content.id
                 WHERE 
                  content.content_folder_id = ${mangaID} AND 
                  visable <= ${userRole} AND
                  content.id = COALESCE (
                    (SELECT content_id FROM user_read_content WHERE content_folder_id = ${mangaID} AND user_account_id = ${userID} ORDER BY COALESCE(edited, published) DESC LIMIT 1),
                    (SELECT id FROM content WHERE content_folder_id = ${mangaID} ORDER BY number LIMIT 1)
                  ) 
                 GROUP BY content.id`;
    this.db.query(query, cb);               
  }

  getChapterByNum(data, cb){
    var query = `SELECT content.id, content.name, json_agg(json_build_object('number', page.number, 'url', page.url) ORDER BY page.number) as pages
                  FROM content INNER JOIN page on page.chapter_id = content.id
                  WHERE content.content_folder_id = ${data.mangaID} AND content.number = ${data.chapterNum} AND content.visable = 1
                  GROUP BY content.id`;
             
    this.db.query(query, cb);
  }

  getFrontendChapterByNum(data, cb){
    var query = `SELECT content.id, content.name,
                    json_build_object('id', rc.id, 'readStatus', rc.read_status, 'pageNum', rc.page_number) as chapterRead,
                    json_build_object('id', rcf.id, 'readStatus', rcf.read_status) as mangaRead,
                    json_agg(json_build_object('number', page.number, 'url', page.url) ORDER BY page.number) as pages
                  FROM content
                    INNER JOIN page on page.chapter_id = content.id
                    LEFT JOIN user_read_content as rc on rc.content_folder_id = ${data.mangaID} AND rc.content_id = content.id AND rc.user_account_id = ${data.userID} 
                    LEFT JOIN user_read_content_folder as rcf on rcf.content_folder_id = ${data.mangaID} AND rcf.user_account_id = ${data.userID}
                  WHERE content.content_folder_id = ${data.mangaID} AND content.number = ${data.chapterNum} AND content.visable = 1
                  GROUP BY content.id, rc.id, rcf.id`;
                              
    this.db.query(query, cb);
  }

  putChapter(id, chapter, cb){
    console.log("Put (Save) Chapter: ");
    console.log(chapter);
    // content_folder Update
    var query = `UPDATE content
                  SET
                  name = '${chapter.name}' ,
                  number = '${chapter.number}', 
                  user_account_id = '${chapter.user_account_id}', 
                  visable = ${chapter.visable} 
                WHERE id = ${id}`;
    this.db.query(query, cb);
  }

  postChapter(chapter, cb){
    // update user_read_content_folder

    var query = `UPDATE user_read_content_folder SET read_status = 'laufend', edited = NOW() 
                 WHERE content_folder_id = ${chapter.content_folder_id} AND read_status = 'abgeschlossen'`;
 
    this.db.query(query, (result) => {

      // content Insert
      var query = `INSERT INTO content(
        name, number, user_account_id, visable, content_folder_id, content_type_id, published
      ) VALUES (
        '${chapter.name}',${chapter.number},${chapter.user_account_id},${chapter.visable},${chapter.content_folder_id}, 1, NOW()
      ) RETURNING id`;

      this.db.query(query, cb);
    });
  }

  deleteChapter(id, cb){
    var query = `DELETE FROM content WHERE id = ${id}`;
    this.db.query(query, cb);
  } 

}
