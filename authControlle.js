var jwt = require('express-jwt');

module.exports.AuthControle = class AuthControle {

    constructor(){

        this.auth = jwt({
            secret: process.env.MY_SECRET,
            userProperty: 'payload'
        });

        this._roleGroups = {'ADMIN': [5], 'TEAM': [4,5], 'PREMIUM': [3,4,5], 'USER': [2,3,4,5], 'GAST': [1,2,3,4,5]};
    }
    

    allow(groupName, payload){
        console.log("authControlle.allow ->");
        console.log(payload);

        if(payload.exp > Date.now() / 1000){
            const expetedRoles = this._roleGroups[groupName];

            const roleInExpected = (expetedRoles.indexOf(payload.role_id) !== -1) ? true : false;
            if(!payload || !roleInExpected ){
                return false;
            }
            return true;
        }
        return false;
    }



}