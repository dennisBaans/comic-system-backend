var express = require('express'),
    router = express.Router(),
    CounterModel = require('../model/counter_model').CounterModel,
    AuthControle = require('../authControlle').AuthControle,
    authControle = new AuthControle(),
    counter = new CounterModel();



// Increase Counter
router.post('/mangas/:id/counter', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(204).send(result.body);
        }
    };
    const data = {'mangaID': req.params['id'], 'userID': req.payload.id}
    counter.increaseCounter(data, cb);
});



module.exports.router = router;