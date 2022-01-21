const mongoose = require('mongoose');
let reservationSchema = mongoose.Schema(
    {
      idUser:{type: mongoose.Schema.Types.ObjectId,ref: "Users"},
      idMovie:{type: mongoose.Schema.Types.ObjectId,ref: "Movie"},
      nbr:{type:Number ,required:true}
})




let Reservation = mongoose.model('Reservation',reservationSchema)

module.exports = Reservation

