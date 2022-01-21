const User = require('../models/User');


const addUser = (req, res) => {

    let user = new User(req.body)
    User.findOne({ username: req.body.username })
        .then((result) => {
            if (result == null) {
          
                user.save()
                    .then((result) => {
                        res.json({ "err": false })
                    })
                    .catch((err) => {
                        console.log(err)
                    })
            }
            else{
                console.log("exist")
                res.json({"err":true})
            }
        })


}
const getUser = (req, res) => {
    let id = req.params.id;
    console.log(id)
    User.findOne({_id:id})
        .then((result) => {
            res.json(result)
        })
        .catch((err) => {
            console.log(err)
        })

}
const getAllUsers = (req, res) => {

    User.find()
        .then((result) => {
            res.json(result)
        })
        .catch((err) => {
            console.log(err)
        })
}
const deleteUser = (req, res) => {

    User.findByIdAndDelete(req.params.id)
        .then((result) => {
            res.json({ msg: "Deleted Succesfully" })
        })
        .catch((err) => {
            console.log(err)
        })
}

const updateUser = (req, res) => {

    User.findOneAndUpdate({ _id: req.param.id, $set: req.body })
        .then((result) => {
            res.json({ msg: "Updated Successfully" })
        })
        .catch(err => console.log(err))
}

const statsUserByGender = (req, res) => {
    User.aggregate([
        {
            $group: {
                _id: "$gender",
                nbr: { $sum: 1 }
            }
        }
    ]).exec((err, data) => {
        if (err) throw err;
        res.send(data)
    })
}

const getNumberUsers = (req,res)=>{
    User.count()
    .then((result)=>{
        res.send({"number":result})
    })
    .catch((err)=>{
        console.log(err)
    })
}

module.exports = { 
    getUser,
    addUser,
    getAllUsers,
    deleteUser,
    updateUser , 
    statsUserByGender,
    getNumberUsers
 }