var express = require('express'),
    router = express.Router(),
    multer  = require('multer'),
    ChapterModel = require('./../model/chapter_model').ChapterModel,
    PageModel = require('./../model/page_model').PageModel,
    MangaModel = require('./../model/manga_model').MangaModel,
    AuthControle = require('../authControlle').AuthControle,
    authControle = new AuthControle(),
    page = new PageModel(),
    manga = new MangaModel(),
    chapter = new ChapterModel();

    var upload = multer({ dest: 'pages/' });

// GET all Chapters of a Manga
router.get('/mangas/:mangaID/chapters', authControle.auth,(req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    const mangaID = req.params['mangaID'];
    chapter.getChapters(mangaID, cb);
});

// GET one current Chapter
router.get('/mangas/:mangaID/chapters/current', authControle.auth,(req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };
    const data = {'mangaID': req.params['mangaID'], 'userID': req.payload.id, 'userRole': req.payload.role_id};
    chapter.getCurrentChapter(data,cb);
    
});

// GET one Chapter
router.get('/mangas/:mangaID/chapters/:chapterID', authControle.auth,(req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };
    const chapterID = req.params['chapterID'];
    chapter.getChapter(chapterID,cb);
});


//Get one Chapter By Num
router.get('/mangas/:mangaID/chapters/number/:chapterNum',authControle.auth, (req, res) =>{
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };
    const data = {'mangaID': req.params['mangaID'], 'chapterNum': req.params['chapterNum'], 'userID': req.payload.id};
    chapter.getChapterByNum(data, cb);
});

//Get one FrontendChapter By Num
router.get('/mangas/:mangaID/frontendchapters/number/:chapterNum', authControle.auth, (req, res) =>{
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };
    const data = {'mangaID': req.params['mangaID'], 'chapterNum': req.params['chapterNum'], 'userID': req.payload.id}
    chapter.getFrontendChapterByNum(data, cb);
});

// CREATE one Chapter
router.post('/mangas/:mangaID/chapters', authControle.auth, upload.array("pages[]", 200), (req, res) => {
    if(authControle.allow('TEAM', req.payload)){
        var cbPOST = function(result){
            if(!result.type){
                res.status(400).send(result.body);
            }else{
                res.status(201).send(result.body);
            }
        }; 
        var chapterData = JSON.parse(req.body.json);
        chapterData.user_account_id = req.payload.id;

        if(req.files){
            var pages = req.files;
            //Chapter anlegen, Pages uploaden, Pages anlegen
            chapter.postChapter(chapterData, (resultChapter) => {
                chapterData.id = resultChapter.body[0].id;
                // Manga Namen ermitteln
                manga.getManga(chapterData.content_folder_id, (resultManga) => {
                    var mangaName = resultManga.body[0].name;
                    // Comic Seiten hochladen
                    page.uploadPages(mangaName, chapterData, pages, (pageUrls) => {
                        // Page anlegen
                        page.postPage(chapterData.id, pageUrls, (result) => {
                            result.body[0] = {'id': chapterData.id};
                            cbPOST(result);
                        });
                    } );
                });
            });
        }else{
            //Wenn keine Datein mitgesendet wurden
            chapter.postChapter(chapterData, cbPOST);
        }
   }else{
        res.status(401).send();
    }
});

// UPDATE one Chapter
router.put('/mangas/:mangaID/chapters/:chapterID', authControle.auth, upload.array("pages[]", 200), (req, res) => {
    if(authControle.allow('TEAM', req.payload)){
        var cb = function(result){
            if(!result.type){
                res.status(400).send(result.body);
            }else{
                res.status(200).send(result.body);
            }
        };
        console.log(req.files);
        const chapterID = req.params['chapterID'];
        var chapterData = JSON.parse(req.body.json);
        chapterData.user_account_id = req.payload.id;

        if(req.files){
            var pages = req.files;
            //Chapter anlegen, Pages uploaden, Pages anlegen
            chapter.putChapter(chapterID, chapterData, (resultChapter) => {
                chapterData.id = chapterID;
                // Manga Namen ermitteln
                manga.getManga(chapterData.content_folder_id, (resultManga) => {
                    var mangaName = resultManga.body[0].name;
                    // Pages löschen 
                    page.deletePages(chapterData.id, (result) => {
                        // neue Pages hochladen
                        page.uploadPages(mangaName, chapterData, pages, (pagesData) => {
                            //neue Pages anlegen in DB
                            page.putPage(chapterID, pagesData, (result) => {
                                result.body[0] = {'id': chapterData.id};
                                cb(result);
                            });
                        })
                    });
                });
            });
        }else{
            chapter.putChapter(chapterID, req.body, cb);
        }

    }else{
        res.status(401).send();
    }
});

// DELETE one Chapter
router.delete('/mangas/:mangaID/chapters/:chapterID', authControle.auth, (req, res) => {
    if(authControle.allow('ADMIN', req.payload)){
        var cbDEL = function(result){
            if(!result.type){
                res.status(400).send(result.body);
            }else{
                res.status(204).send(result.body);
            }
        };
        const chapterID = req.params['chapterID'];
        page.deletePages(chapterID, (result) => {
            chapter.deleteChapter(chapterID, cbDEL)
        });
    }else{
        res.status(401).send();
    }
});





module.exports.router = router;