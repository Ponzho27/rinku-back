const query = require("./../models/query.model");

// Obtenemos la configuración de la tabla de RINKU
module.exports.configuration = (req, res) => {
    query.executeQuery("SELECT * FROM RINKU.CONFIG", function(a,b) {
        res.json(b.rows);
    });
};