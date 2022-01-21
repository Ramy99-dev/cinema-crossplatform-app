require('dotenv').config();
const jwt = require('jsonwebtoken');
const User = require('../models/User');


const generateToken = (req,res) =>{
   User.findOne({'username':req.body.username})
   .then((result)=>{
       if(result)
       {
    
           if(req.body.password == result.password)
           {
            let token =jwt.sign({"id": result._id},process.env.TOKEN_KEY)
            res.send(token)
           }
           else{
                 res.sendStatus(404);
           }
       }
       else{
           res.sendStatus(404);
       }
   })

}

const verify = (req,res,next)=>{

    

    let token = req.headers.authorization ;
    console.log("TOKEN");
    console.log(token) 
    jwt.verify(token,process.env.TOKEN_KEY,(err,user)=>{
        if(err)
        return res.sendStatus(403)

    })
    next();
}

module.exports =  {generateToken , verify}