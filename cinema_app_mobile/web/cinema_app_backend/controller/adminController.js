require('dotenv').config();
const jwt = require('jsonwebtoken');

const generateToken = (req,res) =>{
    
        if(req.body.username=="admin" && req.body.password=="admin")
        {
             let token =jwt.sign({"id":"admin"},process.env.TOKEN_KEY)
             res.json({"token":token})
        }
        else{
            res.sendStatus(403);
        }
    
 
 }

 const verify = (req,res,next)=>{

    

    let token = req.headers.authorization ;
    console.log(token) 
    jwt.verify(token,process.env.TOKEN_KEY,(err,user)=>{
        
        if(err || user.id!='admin')
        return res.sendStatus(403)

    })
    next();
}

module.exports = {generateToken , verify}    