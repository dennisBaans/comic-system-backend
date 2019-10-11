var DB = require('./../db').DB;

module.exports.MangaModel = class MangaModel{

  constructor(){
    this.db = new DB();
  }

  getMangas(cb){
    var query = `SELECT id, name, author, description, year, content_folder_status_id, visable, alter_name, cover
                 FROM content_folder 
                 WHERE 
                   content_folder_type_id = (SELECT id FROM content_folder_type WHERE name = 'manga-serie')
                 ORDER BY name ASC`;
    this.db.query(query, cb); 
  }

  getAccessibleMangas(user_role, cb){
    var query = `SELECT content_folder.id, content_folder.name, content_folder.author, content_folder.description, 
                  content_folder.year, content_folder.content_folder_status_id, content_folder.visable, content_folder.alter_name, 
                  content_folder.cover
                FROM content_folder INNER JOIN content on content.content_folder_id = content_folder.id 
                WHERE
                  content_folder.content_folder_type_id = (SELECT id FROM content_folder_type WHERE name = 'manga-serie') AND
                  content_folder.visable <= (SELECT visable_id FROM user_role WHERE id = ${user_role})
                GROUP BY content_folder.id
                ORDER BY name ASC`;
    this.db.query(query, cb); 
  }

  getFrontendMangas(cb){
    var query = `SELECT id, name, author, description, year, content_folder_status_id, visable, alter_name, cover
                 FROM content_folder 
                 WHERE 
                   content_folder_type_id = (SELECT id FROM content_folder_type WHERE name = 'manga-serie') AND
                    visable = 1               
                 ORDER BY name`;
    this.db.query(query, cb);  
  }

  getManga(id, cb){
    var query = `SELECT content_folder.id, content_folder.name, content_folder.author, content_folder.description, content_folder.year, 
                        content_folder.content_folder_status_id, content_folder.visable, content_folder.alter_name, content_folder.cover
                 FROM content_folder 
                 WHERE content_folder.id = ${id}`;
    this.db.query(query, (result) => {
      if(!result.type || result.body.length < 1){
        cb(result);
      }else{
        var manga = result.body;
        var id = manga[0].id;

        var query = `SELECT COALESCE(array_to_json(array_agg(row_to_json(g))), '[]') as genre
                     FROM (SELECT genre.id, genre.name  
                          FROM content_folder_genre, genre 
                          WHERE content_folder_genre.genre_id = genre.id AND content_folder_genre.content_folder_id = ${id}) g`;

        this.db.query(query, (result) => {

          manga[0].genre = result.body[0].genre;  
          result.body = manga;
          
          cb(result);
        }, result.body);
      }
    });
  }

  getAccessibleManga(data, cb){
    var query = `SELECT content_folder.id, content_folder.name, content_folder.author, content_folder.description, content_folder.year, 
                        content_folder.content_folder_status_id, content_folder.visable, content_folder.alter_name, content_folder.cover
                 FROM content_folder 
                 WHERE content_folder.id = ${data.mangaID} AND
                       content_folder.visable <= ${data.roleID}`;
    this.db.query(query, (result) => {
      if(!result.type || result.body.length < 1){
        cb(result);
      }else{
        var manga = result.body;
        var id = manga[0].id;

        var query = `SELECT COALESCE(array_to_json(array_agg(row_to_json(g))), '[]') as genre
                     FROM (SELECT genre.id, genre.name  
                          FROM content_folder_genre, genre 
                          WHERE content_folder_genre.genre_id = genre.id AND content_folder_genre.content_folder_id = ${id}) g`;

        this.db.query(query, (result) => {

          manga[0].genre = result.body[0].genre;  
          result.body = manga;
          
          cb(result);
        }, result.body);
      }
    });
  }

  getFrontendManga(id, role_id, user_id, cb){
    var query = `SELECT content_folder.id, content_folder.name, content_folder.alter_name, content_folder.description, 
                  content_folder.year, content_folder.visable, content_folder.cover, content_folder_status.name as content_folder_status, 
                  page.url as page_background, rating.value as user_rating_choice,
                  json_build_object('id', rcf.id, 'readStatus', rcf.read_status) as mangaRead, 
                  exists(select 1 from watchlist where user_account_id = ${user_id} AND content_folder_id = ${id}) as watchlist
                 FROM content_folder, content_folder_status, page, content
                  LEFT JOIN user_read_content_folder as rcf
                    on rcf.content_folder_id = ${id} 
                    AND rcf.user_account_id = ${user_id}
                  LEFT JOIN rating 
                    on rating.user_account_id = ${user_id}
                    AND rating.content_folder_id = ${id}
                 WHERE content_folder.content_folder_status_id = content_folder_status.id 
                  AND content_folder.id = ${id}
                  AND page.chapter_id = (SELECT content.id FROM content WHERE content.content_folder_id = ${id} ORDER BY content.published DESC LIMIT 1)
                  AND page.number = 4
                 GROUP BY content_folder_status.name, content_folder.id, page_background, rcf.id , user_rating_choice`;
    this.db.query(query, (result) => {
      // rating
      if(result.type){
      if(result.body[0].visable < role_id){
        delete result.body[0].visable;
        result.body[0].page_background = `url('${result.body[0].page_background}')`;

        query = `SELECT count(nullif(value, true))::integer as bad, count(nullif(value, false))::integer as good 
                 FROM rating WHERE content_folder_id = ${id}`
        
        this.db.query(query, (rating_result) => {
          result.body[0].rating = rating_result.body[0]; 

          // chapterList 
          query = `SELECT content.id, content.name, content.visable, content.number, count(page.number)::integer as page_count,
                    json_build_object('id', rc.id, 'readStatus', rc.read_status, 'pageNum', rc.page_number) as chapterRead
                   FROM content
                    LEFT JOIN user_read_content as rc on rc.user_account_id = ${user_id} AND rc.content_id = content.id
                    LEFT JOIN page on page.chapter_id = content.id
                   WHERE content.content_folder_id = ${id}
                   GROUP BY content.id, rc.id, rc.page_number
                   ORDER BY content.number DESC`;
          this.db.query(query, (chapterList_result) => {
            result.body[0].chapter_list = chapterList_result.body;
            cb(result);
          });

        });
      }else{
        result.type = false;
        cb(result);
      }
      }else{
        result.type = false;
        cb(result);
      }
    });
  }

  deleteRating(id, user, cb){
    // Alte Wertung löschen
    var query = `DELETE FROM rating WHERE user_account_id = ${user} AND content_folder_id = ${id}`;
    this.db.query(query,cb); 
  }

  changeRating(id, user, value, cb){
    // Alte Wertung löschen
    var query = `DELETE FROM rating WHERE user_account_id = ${user} AND content_folder_id = ${id}`;
    this.db.query(query, (result) => {
      query = `INSERT INTO rating (user_account_id, content_folder_id, value, published) 
               VALUES (${user}, ${id}, ${value}, NOW())`;
      this.db.query(query, () => {
        query = `SELECT count(nullif(value, true))::integer as bad, count(nullif(value, false))::integer as good 
                 FROM rating WHERE content_folder_id = ${id}`
        this.db.query(query, cb);        
      });
    });
  }

  putManga(id, manga, cb){
    console.log("Put (Save) Manga: ");
    // content_folder Update
    var query = `UPDATE content_folder
                  SET name = '${manga.name}' ,
                  author = '${manga.author}', 
                  description = '${manga.description}', 
                  year = ${manga.year}, 
                  content_folder_status_id = ${manga.content_folder_status_id},
                  visable = ${manga.visable}, 
                  alter_name = '${manga.alter_name}',
                  cover = '${manga.cover}'
                WHERE id = ${id}`;
    this.db.query(query, (result) => {

      // content_folder_genre Update
      query = `DELETE FROM content_folder_genre WHERE content_folder_id = ${id}`;
      this.db.query(query, (result) => {

        query = `INSERT INTO content_folder_genre (content_folder_id, genre_id) VALUES `;
        manga.genre.forEach( (genre) => {
          query += `(${id}, ${genre.id}),`
        });
        query = query.slice(0,-1);
        this.db.query(query, (result) => {
          result.body.id = id;
          cb(result);
        });
      });

    });


  }

  postManga(manga, cb){

    // content_folder Insert
    var query = `INSERT INTO content_folder (
      name, author, description, year, content_folder_status_id, visable, alter_name, content_folder_type_id, published, cover
    ) VALUES (
      '${manga.name}','${manga.author}','${manga.description}',${manga.year},${manga.content_folder_status_id},
      ${manga.visable},'${manga.alter_name}', 1, NOW(), '${manga.cover}'
    ) RETURNING id`;
    console.log("insert manga query: ");
    console.log(query);
    this.db.query(query, (result) => {
      console.log("insert manga result: ");
      console.log(result);
      console.log("Update the gernres...");
      // content_folder_genre Insert
      var id = result.body[0].id;
      query = `INSERT INTO content_folder_genre (content_folder_id, genre_id) VALUES `;
      manga.genre.forEach( (genre) => {
        query += `(${id}, ${genre.id}),`
      });
      query = query.slice(0,-1);
      this.db.query(query, (result) => {
        result.body.id = id;
        cb(result);
      });

    } ); 


  }

  deleteManga(id, cb){
    var query = `DELETE FROM content_folder WHERE id = ${id}`;
    this.db.query(query, (result) => {
      var query = `DELETE FROM content_folder_genre WHERE content_folder_id = ${id}`;
      this.db.query(query, cb);
    });
  } 

}
