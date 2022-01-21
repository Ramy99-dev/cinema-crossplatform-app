const express = require('express')
const router = express.Router();
const movieController = require('../controller/MovieController')
const authController = require('../controller/authContoller')
const adminController = require('../controller/adminController')

/**
* Get Number of movies
*/
router.get('/number',adminController.verify,movieController.getNumberMovies);

/**
* Get random movies
*/
router.get('/random',authController.verify,movieController.getRandomMovies);
/**
* Get movies categories 
*/
router.get('/categories',authController.verify,movieController.getMoviesCategories);
/**
* Get movies by Categorie id
*/
router.get('/byCategorie/:id',authController.verify,movieController.getMovieByCategorieId)
/**
* Get number based of the movie name 
*/
router.get('/pct',adminController.verify,movieController.statsMovieByCategories);

/**
* Put Movie 
*/
router.put('/update/:id',adminController.verify,movieController.updateMovie)
/**
 * Add Movie
*/
router.post('/',adminController.verify,movieController.addMovie)
/**
* Add Movie Banner
**/
router.post('/upload',adminController.verify,movieController.upload.single("image"))



/**
* Get All Movies
*/
router.get('/all',authController.verify,movieController.getAllMovies)

/**
* Get Movie
*/
router.get('/:id',authController.verify,movieController.getMovie)

/**
* Delete Movie  
*/
router.delete('/:id',adminController.verify,movieController.deleteMovie)








module.exports = router;