var express = require('express'),
    router = express.Router(),
    AuthControle = require('../authControlle').AuthControle,
    authControle = new AuthControle(),
    WatchListModel = require('../model/watchList_model').WatchListModel,
    watchList = new WatchListModel();


router.get('/users/watchlist', authControle.auth, (req, res) => {
    var cb = (result) => {
        if(!result.type){
            res.status(400).send(result.body)
        }else{
            res.status(200).send(result.body)
        }
    };

    const userID = req.payload.id;
    watchList.getWatchList({userID}, cb);
});

router.get('/users/watchlist/mangas/:id/contained', authControle.auth, (req, res) => {
    var cb = (result) => {
        if(!result.type){
            res.status(400).send(result.body)
        }else{
            res.status(200).send(result.body[0].exists)
        }
    };
    const mangaID = req.params['id'];
    const userID = req.payload.id;
    const roleID = req.payload.role_id;
    watchList.getIsInWatchlist({mangaID, userID, roleID}, cb);
});

router.post('/users/watchlist', authControle.auth, (req, res) => {
    var cb = (result) => {
        if(!result.type){
            res.status(400).send(result.body)
        }else{
            res.status(204).send(result.body)
        }
    };
    const userID = req.payload.id;
    const mangaID = req.body.mangaID;
    watchList.addItem({userID, mangaID}, cb);
});

router.delete('/users/watchlist/mangas/:id', authControle.auth, (req, res) => {
    var cb = (result) => {
        if(!result.type){
            res.status(400).send(result.body)
        }else{
            res.status(204).send(result.body)
        }
    };
    const userID = req.payload.id;
    const mangaID = req.params['id'];
    watchList.deleteItem({userID, mangaID}, cb);

});

module.exports.router = router;