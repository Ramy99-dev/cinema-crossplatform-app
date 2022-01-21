const mongoose = require('mongoose');

let userSchema = mongoose.Schema(
    {
      email:{type:String , required:true},
      username:{type:String , required:true},
      password:{type:String , required:true},
      gender:{type:String},
      date:{type:Date},
      role:{type:String , required:true}
})

let User = mongoose.model('Users',userSchema)

module.exports = User


