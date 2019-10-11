var express = require('express'),
    router = express.Router(),
    VisableModel = require('./../model/visable_model').VisableModel,
    visable = new VisableModel();



// GET all Genres
router.get('/visables', (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    visable.getVisables(cb);
});



module.exports.router = router;