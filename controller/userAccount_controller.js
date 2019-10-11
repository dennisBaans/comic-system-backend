var express = require('express'),
    router = express.Router(),
    AuthControle = require('../authControlle').AuthControle,
    authControle = new AuthControle(),
    UserAccount= require('./../model/userAccount_model').UserAccount,
    userAccount = new UserAccount();



// GET all User
router.get('/users',authControle.auth, (req, res) => {
    if(authControle.allow('TEAM', req.payload)){
        var cb = function(result){
            if(!result.type){
                res.status(400).send(result.body);
            }else{
                res.status(200).send(result.body);
            }
        };
        userAccount.getUsers(cb);
    }else{
        res.status(401).send();
    }
});

// GET one User
router.get('/users/:userID', authControle.auth, (req, res) => {
    if(authControle.allow('USER', req.payload)){
        var cb = function(result){
            if(!result.type){
                res.status(400).send(result.body);
            }else{
                res.status(200).send(result.body[0]);
            }
        };
        const id = req.params['userID'];
        userAccount.getUser(id,cb);
    }else{
        res.status(401).send();
    }
});


// Get uniquness of Username
router.get('/users/username/:username/unique', (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    }
    const username = req.params['username'];
    userAccount.usernameUnique(username, cb);
})

// Get uniquness of Email
router.get('/users/email/:email/unique', (req, res) => {
    console.log("get email unique");
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    }
    const email = req.params['email'];
    userAccount.emailUnique(email, cb);
})

router.post('/users/login', (req, res) => {
    var cb = function(result){
        console.log("in cb");
        console.log(result);
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    userAccount.validateUserLogin(req.body, cb);
})

// CREATE one User
router.post('/users', (req, res) => {
    var cbPOST = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            console.log(result);
            res.status(201).send(result.body);
        }
    };
    console.log(req.body);
    userAccount.postUser(req.body, cbPOST);

});

// UPDATE one User
router.put('/users/:userID', authControle.auth, (req, res) => {
    if(authControle.allow('ADMIN', req.payload)){
        var cb = function(result){
            if(!result.type){
                res.status(400).send(result.body);
            }else{
                res.status(200).send(result.body);
            }
        };
        const id = req.params['userID'];
        userAccount.putUser(id, req.body, cb);
    }else{
        res.status(401).send();
    }
});

// DELETE one User
router.delete('/users/:userID', authControle.auth, (req, res) => {
    if(authControle.allow('ADMIN', req.payload)){
        var cbDEL = function(result){
            if(!result.type){
                res.status(400).send(result.body);
            }else{
                res.status(204).send(result.body);
            }
        };
        const id = req.params['userID'];
        userAccount.deleteUser(id, cbDEL)
    }else{
        res.status(401).send();
    }
});





module.exports.router = router;
