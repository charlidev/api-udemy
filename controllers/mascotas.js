import mascotasModel from '../models/mascotas.js'

class mascotasController{
    constructor(){

    }

    //post
    async create(req,res){
        try{
            const data = await mascotasModel.create(req.body);
            res.status(201).json(data)
        }catch(e){
            res.status(500).send(e);
        }
    }

    //GetAll
    async getAll(req,res){
        try{
            res.status(201).json({status: 'getAll-ok'})
        }catch(e){
            res.status(500).send(e);
        }
    }

    //GetOne
    async getOne(req,res){
        try{
            res.status(201).json({status: 'getOne-ok'})
        }catch(e){
            res.status(500).send(e);
        }
    }

    //PUT
    async put(req,res){
        try{
            res.status(201).json({status: 'update-ok'})
        }catch(e){
            res.status(500).send(e);
        }
    }

    //delete
    async delete(req,res){
        try{
            res.status(201).json({status: 'delete-ok'})
        }catch(e){
            res.status(500).send(e);
        }
    }

}

export default new mascotasController();