var express = require('express'),
    router = express.Router(),
    UserRoleModel = require('./../model/userRole_model').UserRoleModel,
    userRole = new UserRoleModel();



// GET all UserRoles
router.get('/userRole', (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    userRole.getUserRoles(cb);
});



module.exports.router = router;