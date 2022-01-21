const express = require('express')
const router = express.Router();
const ReservationController = require('../controller/reservationController');
const adminController = require('../controller/adminController');
const authController = require('../controller/authContoller')

/**
* Add Reservation
**/
router.post('/',authController.verify,ReservationController.addReservation)


/**
* get All reservations 
*/
router.get('/all',ReservationController.getAllReservations)
/**
 * Check user if he's already reserved the movie
 */

router.get('/checkReservation/:userId/:movieId',authController.verify,ReservationController.isReserved)

/**
* get user reservations 
*/

router.get('/userReservations/:userId',authController.verify,ReservationController.getUserReservation)


/**
* Delete reservation  
*/
router.delete('/deleteReservation/:userId/:movieId',authController.verify,ReservationController.deleteReservation)

/**
* Get user reservation using his username 
*/
router.get('/userReservationByUsername/:idUser',ReservationController.getReservationByUserName);

module.exports = router;