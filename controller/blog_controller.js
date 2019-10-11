var express = require('express'),
    router = express.Router(),
    AuthControle = require('../authControlle').AuthControle,
    authControle = new AuthControle(),
    BlogModel = require('../model/blog_model').BlogModel,
    blog = new BlogModel();



router.get('/blogs', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    blog.getBlogEntries(cb);
});

router.get('/blogs/:blogID', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body[0]);
        }else{
            res.status(200).send(result.body[0]);
        }
    };
    let data = {'blogID': req.params['blogID']};
    blog.getBlogEntry(data, cb);
});

router.post('/blogs', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            console.log(result);
            res.status(201).send(result.body[0]);
        }
    };
    let data = {
        'title': req.body.title,
        'text': req.body.text,
        'userID': req.payload.id,
        'visable': req.body.visable
    };
    blog.createBlogEntry(data, cb);
});

router.put('/blogs/:blogID', authControle.auth, (req, res) =>{
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(204).send(result.body);
        }
    };
    let data = {
        'blogID': req.params['blogID'],
        'title': req.body.title,
        'text': req.body.text,
        'userID': req.payload.id,
        'visable': req.body.visable
    };
    blog.updateBlogEntry(data, cb);
});

router.delete('/blogs/:blogID', authControle.auth, (req, res) =>{
    if(authControle.allow('ADMIN', req.payload )){
        var cb = function(result){
            if(!result.type){
                res.status(400).send(result.body);
            }else{
                res.status(204).send(result.body);
            }
        };
        let data = {'blogID': req.params['blogID']};
        blog.deleteBlogEntry(data, cb);
    }else{
        res.status(401).send();
    }
});


module.exports.router = router;