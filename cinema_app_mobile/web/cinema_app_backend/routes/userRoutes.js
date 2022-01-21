const express = require('express')
const router = express.Router();
const userController = require('../controller/userController')
const authController = require('../controller/authContoller')
const adminController = require('../controller/adminController')

/**
* Get Number of users
*/
router.get('/number',adminController.verify,userController.getNumberUsers);
/**
* Get Number of users based on the gender
*/
router.get('/pct',adminController.verify,userController.statsUserByGender);
/**
* Add user 
**/
router.post('/',userController.addUser)
/**
* Get All Users
*/
router.get('/all',adminController.verify,userController.getAllUsers)

/**
* Get user
*/
router.get('/:id',authController.verify,userController.getUser)

/**
* Delete user  
*/
router.delete('/:id',adminController.verify,userController.deleteUser)

/**
* Put User 
*/
router.put('/:id',adminController.verify,userController.updateUser)

/**
* Login user 
*/
router.post('/login',authController.generateToken)





module.exports = router;