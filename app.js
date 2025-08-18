import 'dotenv/config';
import express from 'express';
import routesMascotas from './routes/mascotas.js';

const app = express();

app.use('/mascotas', routesMascotas)

try{
    const PORT = process.env.PORT || 3000;
    app.listen(PORT, ()=>console.log('Servidor levantado en el puerto '+PORT));
}catch(e){
    console.log(e);
}