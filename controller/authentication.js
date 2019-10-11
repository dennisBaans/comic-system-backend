var express = require('express'),
    router = express.Router(),
    UserAccount= require('./../model/userAccount_model').UserAccount,
    userAccount = new UserAccount();



// GET all User
router.get('/users', (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    userAccount.getUsers(cb);
});

