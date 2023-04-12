import { Worker } from 'worker_threads';
export function runTrapstarBotInNewThread(task_data, ws) {
    const worker = new Worker('./Bots/Trapstar/trapstarWorker.js', {
      workerData: { task_data }
    });
  
    worker.on('message', (message) => {
        if (message.type === 'ws') {
          ws.send(message.data);
        } else {
          console.log('Message from worker: ', message);
        }
      });
    worker.on('error', (error) => {
      console.error('Error in worker: ', error);
    });
  
    worker.on('exit', (code) => {
      if (code !== 0) {
        console.error(`Worker stopped with exit code ${code}`);
      }
    });
  }
  export function runPalaceBotInNewThread(task_data, ws) {
    const worker = new Worker('./Bots/Palace/palaceWorker.js', {
      workerData: { task_data }
    });
  
    worker.on('message', (message) => {
        if (message.type === 'ws') {
          ws.send(message.data);
        } else {
          console.log('Message from worker: ', message);
        }
      });
    worker.on('error', (error) => {
      console.error('Error in worker: ', error);
    });
  
    worker.on('exit', (code) => {
      if (code !== 0) {
        console.error(`Worker stopped with exit code ${code}`);
      }
    });
  }