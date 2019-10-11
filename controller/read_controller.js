var express = require('express'),
    router = express.Router(),
    ReadModel = require('../model/read_model').ReadModel,
    AuthControle = require('../authControlle').AuthControle,
    authControle = new AuthControle(),
    read = new ReadModel();


router.get('/users/reads/chapters/:id', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };

    const chapterID = req.params['id'];
    const userID = req.payload.id;
    const roleID = req.payload.role_id;
    read.getUserRead({chapterID, userID, roleID}, cb);
});

// create read_contentFolder
router.post('/users/:userID/reads/mangas/:mangaID', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };
    const data = {'contentFolderID': req.params['mangaID'], 'userID': req.payload.id, 'readStatus': req.body.readStatus}
    read.saveReadContentFolderStatus(data, cb);
});

// create read_content
router.post('/users/:userID/reads/mangas/:mangaID/chapters/:chapterID', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };
    const data = {
        'contentFolderID': +req.params['mangaID'],
        'contentID': +req.params['chapterID'], 
        'userID': req.payload.id, 
        'readStatus': req.body.readStatus,
        'pageNum': req.body.pageNum
    }
    read.saveReadContentStatus(data, cb);
});

// update read_contentFolder
router.put('/users/:userID/reads/:readID/mangas/:mangaID', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };
    const data = {'readID': req.params['readID'],'readStatus': req.body.readStatus}
    read.updateReadContentFolderStatus(data, cb);
});

// update read_content
router.put('/users/:userID/reads/:readID/mangas/:mangaID/chapters/:chapterID', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };
    const data = {'readID': req.params['readID'],'readStatus': req.body.readStatus, 'pageNum': req.body.pageNum}
    read.updateReadContentStatus(data, cb);
});


module.exports.router = router;