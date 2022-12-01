const express             = require('express');
const app                 = express();
const port                = 3000;
const bodyParser          = require('body-parser');
const config              = require('./controllers/config');
const employeedController = require('./controllers/employeed');
const rolesController     = require('./controllers/roles');

// Configurar bodyparser para obtener el body de la petición de tipo POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(bodyParser.raw());

// Empleados API
app.get("/list/employeed", employeedController.listOfEmployeed);
app.get("/last/id/employeed", employeedController.getNumberIdEmployeedNext);
app.post("/add/employeed", employeedController.createEmployeed);
app.post("/payment/employeed", employeedController.payment)

// Roles API
app.get("/list/roles", rolesController.getRoles);

//Config API
app.get("/config", config.configuration);

app.listen(port, () => {
  console.log(`Example RINKU listening on port ${port}`);
})