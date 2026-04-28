import 'dotenv/config';
import express from 'express';
import webhookRouter from './webhook-handler';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(webhookRouter);

app.listen(PORT, () => {
  console.log(`GHL webhook server running on port ${PORT}`);
});
