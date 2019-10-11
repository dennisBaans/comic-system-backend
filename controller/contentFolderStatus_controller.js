var express = require('express'),
    router = express.Router(),
    ContentFolderStatus = require('./../model/cotentFolderStatus_model').ContentFolderStatusModel,
    contentFolderStatus = new ContentFolderStatus();



// GET all ContentFolderStatus
router.get('/contentFolderStatus', (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    contentFolderStatus.getStatus(cb);
});



module.exports.router = router;