var mysql = require('mysql2');

// Configurar el pool de conexiones a la aplicación
var pool  = mysql.createPool({
    connectionLimit: 5,
    host: 'localhost',
    user: 'admin',
    password: 'Pooncho92',
    database: 'rinku'
});

module.exports = pool;