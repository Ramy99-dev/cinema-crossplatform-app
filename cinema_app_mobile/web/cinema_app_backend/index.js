require('dotenv').config()
const express = require('express');
const mongoose = require('mongoose')
const cors = require('cors')
const userRoutes = require('./routes/userRoutes')
const movieRoutes = require('./routes/movieRoutes')
const categorieRoutes = require('./routes/categorieRoutes')
const adminRoutes = require('./routes/adminRoutes')
const ReservationRoutes = require('./routes/reservationRoute')

const app = express();

mongoose.connect(process.env.DATABASE_URL,{useNewUrlParser: true,useUnifiedTopology: true})
.then((res)=>{
    app.listen(3000,()=>{
        console.log("Listening to port 3000")
    })
})
.catch(err => console.log(err));
    


app.use(express.json());
app.use(cors())
app.use('/users/',userRoutes)
app.use('/movies/',movieRoutes)
app.use('/categorie/',categorieRoutes)
app.use('/admin/',adminRoutes)
app.use('/reservation/',ReservationRoutes)