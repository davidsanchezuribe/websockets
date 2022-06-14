import express, { Request, Response } from 'express';

const clientAPI = express.Router();

clientAPI.get('/test', (req: Request, res: Response) => {
  res.send('Hello World');
});

export default clientAPI;
