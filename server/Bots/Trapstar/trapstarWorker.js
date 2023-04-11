
import { Worker } from 'worker_threads';
import { parentPort, workerData } from 'worker_threads';
import trapstarBot from './trapstar.js';

const { task_data } = workerData;
const ws = {
    send: (data) => {
      parentPort.postMessage({ type: 'ws', data });
    },
  };

trapstarBot(task_data, ws);

