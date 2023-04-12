
import { Worker } from 'worker_threads';
import { parentPort, workerData } from 'worker_threads';
import PalaceBot from './palace.js';

const { task_data } = workerData;
const ws = {
    send: (data) => {
      parentPort.postMessage({ type: 'ws', data });
    },
  };

PalaceBot(task_data, ws);

