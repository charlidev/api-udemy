import express from 'express';
const route = express.Router();
import mascotaController from '../controllers/mascotas.js'

route.post('/', mascotaController.create);
route.get('/', mascotaController.getAll);
route.get('/:id', mascotaController.getOne);
route.put('/:id', mascotaController.put);
route.delete('/:id', mascotaController.delete);

export default route;