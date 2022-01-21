const express = require('express')
const router = express.Router();
const adminController = require('../controller/adminController')


/**
* Admin Login
**/
router.post('/login',adminController.generateToken)


module.exports = router