var express = require('express'),
    router = express.Router(),
    CategoryModel = require('./../model/category_model').CategoryModel,
    MangaModel = require( './../model/manga_model').MangaModel,
    WatchlistModel = require('./../model/watchList_model').WatchListModel,
    GenreModel = require('./../model/genre_model').GenreModel,
    AuthControle = require('../authControlle').AuthControle,
    authControle = new AuthControle(),
    manga = new MangaModel(),
    watchlist = new WatchlistModel(),
    genre = new GenreModel(),
    category = new CategoryModel();


// GET Category
router.get('/category/:catID', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    const roleID = req.payload.role_id;
    const userID = req.payload.id;
    const catID = req.params['catID'];

    console.log("/category/"+ catID);

    
    switch (catID){
        case "LATESTCONTENT":
            category.getLatestContent(roleID, (result) => {
                result.body = {'title': 'Neuste Mangas', 'content': result.body};
                cb(result);
            });
            break;
        case "ACCESSIBLEMANGAS":
            console.log("in Cat");
                manga.getAccessibleMangas(roleID, result => {
                    result.body = {'title': 'Alle Mangas', 'content': result.body};
                    cb(result);
                });
            break;
        case "MYLIST":
            if(userID){
                console.log("MYLIST");
                watchlist.getWatchList({userID,roleID}, result => {
                    result.body = {'title': 'Meine Watchlist', 'content': result.body};
                    cb(result);
                });
            }else{
                result.body = false;
                cb(result);
            }
            break;
        case "ONGOING":
            category.getGoingOn({userID,roleID}, result => {
                result.body = {'title': 'Weiter lesen', 'content': result.body};
                cb(result);
            })
        default:
            genre.getGenres( genres => {
                if(!!genres.body.find( value => value.name === catID)){ 
                    category.getGenre({catID, roleID}, result => {
                        result.body = {'title': `Genre: ${catID}`, 'content': result.body};
                        cb(result);
                    });
                }
            });
            break;
    }
    
});


module.exports.router = router;