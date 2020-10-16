const { response, request } = require('express');
const SerialPort = require('serialport');

function iniciarPortas(pathPortaUSB, portaLocalHost = 3333, delimitadorString = '\n') {
  
  const port = new SerialPort(pathPortaUSB);
  const Delimiter = require('@serialport/parser-delimiter');
  
  const app = require('express')();
  const cors = require('cors');
  app.use(cors())
  
  const localPort = portaLocalHost;
  let valorAEnviar = '';

  const parser = port.pipe(new Delimiter({ delimiter: delimitadorString }))
  parser.on('data', data => valorAEnviar = data.toString().replace('\r', ''))
  
  app.get('/api-online', (request, response) => {
    return response.json({ 
      response: 'true',
      JSON: 'JavaScript Object Notation',
    });
  })

  app.get('/leitura-ad', (request, response) => response.json( { leitura: valorAEnviar, } ))

  app.listen(localPort, () => console.log(`Rodando na porta ${portaLocalHost}`))
}

function listarPortas() {
  SerialPort.list().then(console.log)
}

module.exports = { iniciarPortas, listarPortas }
