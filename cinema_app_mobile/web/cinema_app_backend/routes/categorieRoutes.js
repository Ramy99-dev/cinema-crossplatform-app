const express = require('express')
const router = express.Router();
const categorieController = require('../controller/CategorieController')
const authController = require('../controller/authContoller')
const adminController = require('../controller/adminController')

/**
* Get All Categories
*/
router.get('/all',authController.verify,categorieController.getAllCategories)
/**
* Get Number of categories
*/
router.get('/number',adminController.verify,categorieController.getNumberCategory);
/**
* Add Categorie 
**/
router.post('/',adminController.verify,categorieController.addCategorie)


/**
* Get Categorie
*/
router.get('/:id',authController.verify,categorieController.getCategorie)

/**
* Delete Categorie  
*/
router.delete('/:id',adminController.verify,categorieController.deleteCategorie)

/**
* Put Categorie 
*/
router.put('/:id',adminController.verify,categorieController.updateCategorie)





module.exports = router;