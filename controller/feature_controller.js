var express = require('express'),
    router = express.Router(),
    AuthControle = require('../authControlle').AuthControle,
    authControle = new AuthControle(),
    multer  = require('multer'),
    FeatureModel = require('./../model/feature_model').FeatureModel,
    feature = new FeatureModel();


    const upload = multer({ dest: 'feature_background/' });

// GET all Features
router.get('/features', (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    feature.getFeatures(cb);
});

router.get('/features/:id', (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };

    const id = req.params['id'];
    feature.getFeature({id}, cb);
});


router.post('/features', authControle.auth, upload.single('featureBackground'), (req, res) => {

    var cb = function(result){
        console.log("in cb ========");
        console.log(result);
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(201).send(result.body[0]);
        }
    };

    let featureData = JSON.parse(req.body.json);
    if(req.file){
        feature.uploadFeatureBackground(featureData.id, {'image': req.file}, (uploadResult) => {
            featureData.background_url = uploadResult;
            feature.postFeature(featureData, cb);
        });
    }else{
        featureData.backgroundURL = '';
        feature.postFeature(featureData, cb);
    }

});

router.put('/features/:id', authControle.auth, upload.single('featureBackground'), (req, res) =>{
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body[0]);
        }
    };

    let featureData = JSON.parse(req.body.json);
    if(req.file){
        feature.uploadFeatureBackground(featureData.id, {'image': req.file}, (uploadResult) => {
            featureData.backgroundURL = uploadResult.featureBackgroundURL;
            feature.putFeature(featureData, cb);
        });
    }else{
        feature.putFeature(featureData, cb);
    }
});
router.put('/features/:firstID/switch/:secondID', authControle.auth, (req, res) => {
    var cb = function(result){
        if(!result.type){
            res.status(400).send(result.body);
        }else{
            res.status(200).send(result.body);
        }
    };
    const firstID = req.params['firstID'];
    const secondID = req.params['secondID'];

    feature.switchId({firstID, secondID}, cb);
});

router.delete('/features/:id', authControle.auth, (req, res) => {
    if(authControle.allow('ADMIN', req.payload )){
        var cbDEL = function(result){
            if(!result.type){
                res.status(400).send(result.body);
            }else{
                res.status(204).send(result.body);
            }
        };
        const featureID = req.params['id'];
        feature.deleteFeature({featureID}, cbDEL)

    }else{
        res.status(401).send();
    }
});

module.exports.router = router;