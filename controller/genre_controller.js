var express = require('express'),
    router = express.Router(),
    GenreModel = require('./../model/genre_model').GenreModel,
    genre = new GenreModel();



// GET all Genres
router.get('/genres', (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    genre.getGenres(cb);
});



module.exports.router = router;