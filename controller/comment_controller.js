var express = require('express'),
    router = express.Router(),
    AuthControle = require('../authControlle').AuthControle,
    authControle = new AuthControle(),
    CommentModel = require('../model/comment_model').CommentModel,
    comment = new CommentModel();



// GET comment for Parent 
router.get('/comments/:parentType/:parentID', (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    const parentType = req.params['parentType'];
    const parentID = req.params['parentID'];
    comment.getComments(parentType, parentID, cb);
});

router.post('/comments', authControle.auth, (req, res) => {
    var cbPost = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    }
    const userID = req.payload.id;
    const data = req.body;
    comment.saveComment(userID, data.parentType, data.parentID, data.text, cbPost);
});

router.put('/comments/:id', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(204).send(result.body);
        }
    }
    const data = req.body;
    comment.updateComment(data.commentID,data.text, cb);
});

router.delete('/comments/:id', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(204).send(result.body);
        }
    }
    const commentID = req.params['id'];
    comment.deleteComment(commentID, cb);
});

router.post('/comments/:id/reply', authControle.auth, (req, res) => {
    var cbPost = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    }
    const data = req.body;
    const userID = req.payload.id;
    comment.saveCommentReply(data.userID , data.commentID, data.text, cbPost);
});

router.put('/comments/:commentID/reply/:replyID', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(204).send(result.body);
        }
    }
    const data = req.body;
    comment.updateCommentReply(data.replyID,data.text, cb);
});

router.delete('/comments/:commentID/reply/:replyID', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(204).send(result.body);
        }
    }
    const replyID = req.params['replyID'];
    comment.deleteCommentReply(replyID, cb);
});




module.exports.router = router;