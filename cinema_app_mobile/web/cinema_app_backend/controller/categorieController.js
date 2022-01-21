const Categorie = require('../models/Categorie');


const addCategorie = (req,res)=>{

    let categorie = new Categorie(req.body)
    categorie.save()
    .then((result)=>{
        res.send(result)
    })
    .catch((err)=>{
        console.log(err)
    })

}
const getCategorie = (req,res)=>{
    let id = req.params.id;
    Categorie.findById(id)
    .then((result)=>{
        res.json(result)
    })
    .catch((err)=>{
        console.log(err)
    })

}
const getAllCategories = (req,res)=>{

    Categorie.find()
    .then((result)=>{
        res.json(result)
    })
    .catch((err)=>{
        console.log(err)
    })
}
const deleteCategorie = (req,res)=>{
    console.log(req.params)
    Categorie.findOneAndRemove({_id:req.params.id})
    .then((result)=>{
       res.json({msg:"Deleted Succesfully"})
    })
    .catch((err)=>{
        console.log(err)
    })
}

const updateCategorie = (req,res)=>{
    delete req.body._id;
    Categorie.findByIdAndUpdate(req.params.id,{$set:req.body})
    .then((result)=>{
        res.json({msg:"Updated Successfully"})
    })
    .catch(err=>console.log(err))
}

const getNumberCategory = (req,res)=>{
    Categorie.count()
    .then((result)=>{
        res.send({"number":result})
    })
    .catch((err)=>{
        console.log(err)
    })
}


module.exports = {
    getCategorie ,
    addCategorie ,
    getAllCategories ,
    deleteCategorie ,
    updateCategorie ,
    getNumberCategory
}