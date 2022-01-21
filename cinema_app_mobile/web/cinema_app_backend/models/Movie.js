const mongoose = require('mongoose');
const Reservation = require('./Reservation');
let movieSchema = mongoose.Schema(
    {
      titre:{type:String , required:true},
      duree:{type:String , required:true},
      realisateur:{type:String , required:true},
      description:{type:String , required:true},
      categorie:{type: mongoose.Schema.Types.ObjectId,ref: "Categorie" },
      img:{type:String },
      nbr:{type:Number,required:true },
      date:{type:Date,required:true },
      prix:{type:Number,required:true}
})


movieSchema.post('findOneAndRemove',function (doc){
  Reservation.findOneAndDelete({idMovie:doc._id})
  .then((result)=>{
    console.log("Reservation successfully deleted")
  })
  .catch((err)=>{
    console.log(err)
  })
})
let Movie = mongoose.model('Movie',movieSchema)

module.exports = Movie
