const query = require("./../models/query.model");
const responseList = require("./../models/response.model");

// Obtenemos los roles de los empleados
exports.getRoles = (req, res) => {
    console.log('Got body:', req.body);
    query.executeQuery(`CALL rinku.getRoles()`, (error, rows) => {
        if(rows.rows[0].length >= 1){
            res.json(rows.rows[0]);
        }else{
            res.json(responseList.responseList("0001", "Error"));
        }
    });

};