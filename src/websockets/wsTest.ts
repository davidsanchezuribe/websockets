import WebSocket from 'ws';
import { Server } from 'http';
import queryString from 'query-string';

export default async (expressServer: Server) => {
  const websocketServer = new WebSocket.Server({
    // Normalmente ws configura un servidor al lado del servidor,
    // esta opción sirve para compartir el mismo servidor express,
    // a traves de diferentes sockets
    noServer: true,
    // Especifica el endpoint de acceso localhost:5000/websockets
    path: '/websockets',
  });
  // Listening for an upgrade event that says "we need
  // to upgrade this request to handle websockets"
  // Upgrade es como un oli estoy aki
  // Request: inbound HTTP request made from a websocket client
  // Socket: newtwork connection between the browser of the client and the server
  // Head: first packet/chunk of data for the inbound request
  expressServer.on('upgrade', (request, socket, head) => {
    // console.log('Handshake pedido');
    // We have been asked to upgrade this http request to a websocket
    // request so perform the upgrade and then return the upgraded
    // connection (websocket)
    websocketServer.handleUpgrade(request, socket, head, (websocket) => {
      // 'conection' es el hand off del hand shake y lo emitimos en el socket

      websocket.emit('connection', websocket, request);
       // console.log('1');
    });
    // console.log('2');
  });
  // console.log('3');
  websocketServer.on(
    'connection',
    // Igual que arriba es emit connection websocket request
    // aqui es on connection websocket request, resumen: las conexiones
    // se componen de websocket y request
    (websocketConnection, connectionRequest) => {
      console.log('Incoming Message');
      if (connectionRequest) {
        console.log('Incoming Message');
        const { url } = connectionRequest;
        if (url) {
          // underscore significa variable que no se va a utilizar
          const [,params] = url.split('?');
          const connectionParams = queryString.parse(params);
          console.log(connectionParams);
        }
      }
      console.log('Incoming Message');
      websocketConnection.on('message', (message) => {
        const parsedMessage = JSON.parse(message.toString());
        console.log(parsedMessage);
        console.log('5');
        websocketConnection.send(JSON.stringify({ message: 'Let there be love' }));
      });
    },
  );
  console.log('4');

  // return websocketServer;
};
