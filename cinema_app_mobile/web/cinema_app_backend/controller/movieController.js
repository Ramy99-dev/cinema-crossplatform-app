const Movie = require('../models/Movie');
const multer = require('multer');
const path = require('path');


const notification = require('../controller/firebaseNotification');
var storage = multer.diskStorage({
    destination: '../cinema-app-frontend/src/assets/uploads',
    filename: function (req, file, cb) {
        cb(null, file.originalname)
    }
})
var upload = multer({ storage: storage })


const addMovie = (req, res) => {
    console.log(req.body)

    let filename = req.body.img;
    let extension = path.extname(filename);
    let file = path.basename(filename, extension) + extension;
    req.body.img = file;
    
    let movie = new Movie(req.body)
    movie.save()
        .then((result) => {
            console.log(result);
            notification.sendNotification(result.titre);
            res.send(result)
        })
        .catch((err) => {
            console.log(err)
        })

}
const getMovie = (req, res) => {
    let id = req.params.id;
    console.log(id)
    Movie.findById(id).populate("categorie")
        .then((result) => {
            res.json(result)
        })
        .catch((err) => {
            console.log(err)
        })

}
const getAllMovies = (req, res) => {

    Movie.find()
        .populate("categorie", 'nom')
        .exec((err, data) => {
            if (err) throw "Error"
            res.send(data);
        })

}
const deleteMovie = (req, res) => {

    Movie.findOneAndRemove({_id:req.params.id})
        .then((result) => {
            res.json({ msg: "Deleted Succesfully" })
        })
        .catch((err) => {
            console.log(err)
        })
}

const updateMovie = (req, res) => {
    delete req.body.id;
    console.log(req.body)
    Movie.findByIdAndUpdate(req.params.id, { $set: req.body })
        .then((result) => {
            console.log(result)
            res.json({ msg: "Updated Successfully" })
        })
        .catch(err => console.log(err))
}

const statsMovieByCategories = (req, res) => {
    Movie.aggregate([



        {
            $lookup:
            {
                from: "categories",
                localField: "categorie",
                foreignField: "_id",
                as: "categorie_details"
            },
        },

        { $unwind: "$categorie_details" },

        {
            $group: {
                _id: "$categorie_details.nom",
                nbr: { $sum: 1 }
            }
        },


    ]).exec((err, data) => {
        if (err) throw err;
        res.send(data)
    })
}

const getNumberMovies = (req, res) => {
    Movie.count()
        .then((result) => {
            res.send({ "number": result })
        })
        .catch((err) => {
            console.log(err)
        })
}

const getMoviesCategories = (req, res) => {
    Movie.find().populate("categorie").select({"categorie:":1,"_id":0}).exec((err, data) => {
        if (err) throw Error;
        res.send(data);
    })
}

const getMovieByCategorieId = (req,res)=>{
    Movie.find({categorie:req.params.id})
    .populate("categorie", 'nom')
    .exec((err, data) => {
        if (err) throw "Error"
        res.send(data);
    })
}


const getRandomMovies = async(req ,res) =>{

    let categories  = await Movie.find().populate("categorie","nom").distinct("categorie");
    let randomValue =  Math.floor(Math.random() * categories.length);
    Movie.find({categorie:categories[randomValue]})
    .populate("categorie", 'nom')
    .exec((err, data) => {
        if (err) throw "Error"
        res.send(data);
    })
}

updateMovieSeets = (id ,seets , opr)=>
{

    if(opr == "dec")
    {
        setOperation ={$inc : {nbr:- seets}}
    }
    else{
        setOperation ={$inc : {nbr:seets}}
    }
  Movie.findOneAndUpdate({_id:id},setOperation)
  .then((result)=>{
      console.log(result)
    console.log("Movie seates updated successfully")
  })
  .catch((err)=>{
    console.log(err)
  })
}
module.exports = { getMovie, addMovie, getAllMovies, deleteMovie, updateMovie, upload, statsMovieByCategories, getNumberMovies, getMoviesCategories ,getMovieByCategorieId , getRandomMovies ,updateMovieSeets }