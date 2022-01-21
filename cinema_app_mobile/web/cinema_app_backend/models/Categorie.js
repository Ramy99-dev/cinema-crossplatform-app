const mongoose = require('mongoose');
const Movie = require('./Movie');

let categorieSchema = mongoose.Schema(
    {
      nom:{type:String , required:true},
      description:{type:String },
})

categorieSchema.post('findOneAndRemove',function (doc){
   Movie.findOneAndDelete({category:doc._id})
   .then((result)=>{
     console.log("Movies successfully deleted")
   })
   .catch((err)=>{
     console.log(err)
   })
})

let Categorie = mongoose.model('Categorie',categorieSchema)




module.exports = Categorie
