const Reservation = require('../models/Reservation');
const movieCtrl = require('../controller/movieController')

const addReservation = (req,res)=>{
    console.log(req.body);
    let reservation = new Reservation(req.body)
    reservation.save()
    .then((result)=>{
        movieCtrl.updateMovieSeets(req.body.idMovie ,result.nbr,"dec" );
        console.log(result)
    })
    .catch((err)=>{
        console.log(err)
    })

}

const isReserved = (req,res)=>{
    Reservation.findOne({idUser:req.params.userId , idMovie:req.params.movieId})
    .then((result)=>{
        if(result){
            res.send(true)
        }
        else{
            res.send(false);
        }
    })
    .catch((err)=>{
        console.log(err);
    })
}

const getUserReservation = (req ,res)=>{
    Reservation.find({idUser:req.params.userId})
    .select('idMovie nbr')
    .populate("idMovie")
    .exec((err,data)=>{
        if(err) return handleError(err)
        res.send(data);
    })
    
}

const deleteReservation = (req ,res)=>{
    Reservation.findOneAndDelete({idUser:req.params.userId , idMovie:req.params.movieId})
    .then((result)=>{
        movieCtrl.updateMovieSeets(req.params.movieId , result.nbr ,"inc" );
        console.log("Reservation is deleted successfully")
    })
    .catch((err)=>{
        console.log(err)
    })
}

const getAllReservations = (req ,res )=>{
    Reservation.find()
    .populate("idMovie")
    .populate("idUser")
    .exec((err,data)=>{
        if(err) res.send(err)
        res.send(data);
    })
}


const getReservationByUserName = (req ,res)=>{
    console.log(req.params.idUser)
    Reservation.find({"idUser":req.params.idUser})
    .populate("idMovie")
    .populate("idUser")
    .exec((err,data)=>{
        if(err) return handleError(err)
        res.send(data);
    })
}
module.exports = {addReservation , isReserved , getUserReservation ,deleteReservation , getAllReservations , getReservationByUserName}