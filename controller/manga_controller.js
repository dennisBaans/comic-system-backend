var express = require('express'),
    router = express.Router(),
    bodyParser = require('body-parser'),
    multer  = require('multer'),
    MangaModel = require('./../model/manga_model').MangaModel,
    CoverModel = require('./../model/cover_model').CoverModel,
    AuthControle = require('../authControlle').AuthControle,
    authControle = new AuthControle(),
    manga = new MangaModel(),
    cover = new CoverModel();


    const upload = multer({ dest: 'cover/' });

// GET all Mangas
router.get('/mangas', authControle.auth,(req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    manga.getMangas(cb);
});

// GET all accesable Mangas
router.get('/mangas/accessible', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    const roleID = req.payload.role_id;
    manga.getAccessibleMangas(roleID, cb);
});

// obsolete
// GET all Mangas for Frontend
router.get('/frontendmangas', authControle.auth,(req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    manga.getFrontendMangas(cb);
});

// GET one Manga
router.get('/mangas/:id', authControle.auth,(req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };
    const mangaID = req.params['id'];
    manga.getManga(mangaID,cb);
});

router.get('/mangas/:id/accessible', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };
    const mangaID = req.params['id'];
    const userID = req.payload.id;
    const roleID = req.payload.role_id;
    console.log("get accessible manga");
    manga.getAccessibleManga({mangaID, userID, roleID}, cb);
});

// GET one Manga for Frontend
router.get('/mangafrontend/:id', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };
    const mangaID = req.params['id'];
    const userID = req.payload.id;
    const roleID = req.payload.role_id;
    manga.getFrontendManga(mangaID, roleID, userID, cb);
});

//PUT one Content-for-Frontend-Rating
router.put('/mangafrontend/:id/ratings', authControle.auth, (req, res) => {
    var cbPOST = function(result){
            if(!result.type){
                res.status(400).send(result.body);
            }else{
                res.status(201).send(result.body[0]);
            }
        }; 
    const mangaID = req.params['id'];
    const userID = req.payload.id;
    var tmp = req.body.rating;

    if(tmp !== null){
        manga.changeRating(mangaID, userID, tmp, cbPOST);
    }else{
        manga.deleteRating(mangaID, userID, cbPOST);
    }
});



// CREATE one Manga
router.post('/mangas', authControle.auth, upload.single('cover'), (req, res) => {
    if(authControle.allow('TEAM', req.payload)){
        var cbPOST = function(result){
            if(!result.type){
                res.status(400).send(result.body);
            }else{
                res.status(201).send(result.body);
            }
        }; 

        // Manga anlegen, dann Cover hochladen und dann updaten...
        manga.postManga(JSON.parse(req.body.json), (result) => {
            console.log("Result: ");
            console.log(result);
            var mangaID = result.body.id;
            if(req.file){
                // Cover wird hochgeladen und URL zu manga hinzugefügt
                cover.uploadCover(mangaID, {'image': req.file, 'manga': JSON.parse(req.body.json)}, (mangaID, data) => {
                    console.log("Cover geuploaded");
                    manga.putManga(mangaID, data, cbPOST);
                });
            }else{
                manga.postManga(mangaID, JSON.parse(req.body.json), cbPOST);
            }
        });

    }

});


// UPDATE one Manga
router.put('/mangas/:id', authControle.auth, upload.single('cover'), (req, res) => {
    if(authControle.allow('TEAM', req.payload)){
        console.log("We are here...");
        console.log(req.file);
        var cb = function(result){
            if(!result.type){
                res.status(400).send(result.body);
            }else{
                res.status(200).send(result.body);
            }
        };
        const mangaID = req.params['id'];

        // Wenn neues Cover, dann uploaden und URL in DB speichern. Und altes Cover löschen...
        if(req.file){
            // Cover wird hochgeladen und URL zu manga hinzugefügt
            cover.uploadCover(mangaID, {'image': req.file, 'manga': JSON.parse(req.body.json)}, (mangaID, data) => {
                manga.putManga(mangaID, data, cb);
            });
        }else{
            // Kein neues Cover
            manga.putManga(mangaID, JSON.parse(req.body.json), cb);
        }

    }else{
        res.status(401).send();
    }
});

// DELETE one Manga
router.delete('/mangas/:id', authControle.auth, (req, res) => {

    if(authControle.allow('ADMIN', req.payload )){
        var cbDEL = function(result){
            if(!result.type){
                res.status(400).send(result.body);
            }else{
                res.status(204).send(result.body);
            }
        };
        const mangaID = req.params['id'];
        manga.deleteManga(mangaID, cbDEL)

    }else{
        res.status(401).send();
    }


});



module.exports.router = router;