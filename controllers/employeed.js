const query = require("./../models/query.model");
const responseList = require("./../models/response.model");

// Creamos un empleado en la tabla de empleados
exports.createEmployeed = (req, res) => {
    console.log('Got body:', req.body);
    query.executeQuery(`CALL rinku.addEmployeed('${req.body.name}', ${req.body.role}, ${req.body.numberEmployeed})`, (error, rows) => {
        if(rows.rows.affectedRows >= 1){
            res.json(responseList.responseList("0000", "Ok"));
        }else{
            res.json(responseList.responseList("0001", "Error"));
        }
    });

};

// Obtiene el numero de empleado mas alto
exports.getNumberIdEmployeedNext = (req,res) => {
    query.executeQuery(`CALL rinku.getNumberId();`, (error, rows) => {
        res.json({ id: rows.rows[0][0]['MAX(E_NUMBER_ID)'] });
    });
};

// Obtener la lista de los empleados
exports.listOfEmployeed = (req, res) => {
    query.executeQuery("CALL rinku.listEmployeeds()", (error, rows) => {
        res.json(rows.rows[0]);
    });
}

// Obtiene el pago que se le hara al empleado
exports.payment = (req, res) => {
    let config = req.body.config;
    let employeed = req.body.employeed;
    let date = req.body.date;
    let deliverys = req.body.deliverys;

    let days        = getConfigValue(config, "DIAS");
    let hours       = getConfigValue(config, "HORAS");
    let weeks       = getConfigValue(config, "SEMANAS");
    let dPayment    = getConfigValue(config, "PAGO_ENTREGA");
    let taxes       = getConfigValue(config, "ISR");
    let saldTop     = getConfigValue(config, "SALDO_TOPE");
    let extraTaxes  = getConfigValue(config, "ISR_TOPE");
    let valesExtra  = getConfigValue(config, "VALES");

    let paymentHo = (employeed.ROLE_ID == 1 || employeed.ROLE_ID == 2) ? parseFloat(getConfigValue(config, "PAGO_HORA")) + parseFloat(employeed.R_ADDITIONAL.toString()) : getConfigValue(config, "PAGO_HORA");
    let payment   = (((parseFloat(hours) * parseFloat(paymentHo.toString())) * parseFloat(days)) * parseFloat(weeks)) + (parseInt(deliverys) * parseInt(dPayment));
    let vales     = parseFloat(valesExtra) / 100 * payment;
    payment       = payment + vales;
    let isr       = (payment >= parseFloat(saldTop)) ?  ((parseFloat(taxes) + parseFloat(extraTaxes))/100) * payment : (parseFloat(taxes)/100) * payment;

    res.json( {
      payment: payment,
      hours: (parseFloat(hours) * parseFloat(days)) * parseFloat(weeks),
      paymentDelivery: (parseInt(deliverys) * parseInt(dPayment)),
      paymentBonds: (employeed.ROLE_ID == 1 || employeed.ROLE_ID == 2) ? ((parseFloat(hours) * parseFloat(days)) * parseFloat(weeks)) *  parseFloat(employeed.R_ADDITIONAL.toString()) : 0,
      isr: isr,
      vouchers: vales,
      totalPayment: payment - isr,
      nameEmployeed: employeed.E_NAME,
      numberEmployeed: employeed.E_NUMBER_ID,
      rolEmployeed: employeed.R_NAME,
      dateResumen: date
    } );
}


// Obtiene el valor de la variable que necesitamos para obtener la configuracion
function getConfigValue(config, variableSearch){
    return config.filter( value => { return value.CFG_CONFIG_VAR == variableSearch })[0].CFG_CONFIG_VALOR.toString();
}