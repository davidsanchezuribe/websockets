import app from './server/app';
import websockets from './websockets/wsTest';

const server = app.listen(5000, () => {
  // eslint-disable-next-line
  console.log('listen on port 5000');
});

websockets(server);
