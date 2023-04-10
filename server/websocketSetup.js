import { WebSocketServer } from 'ws';
import { Worker } from 'worker_threads';
import http from 'http';
import { type } from 'os';
import trapstarBot from './Bots/Trapstar/trapstar.js';
import get_releases_data from './Data/releasesData.js';
import runTrapstarBotInNewThread from './threadmanager.js';
import { SemanticAnalysis } from './Data/SemanticAnalysisData.js';
const wrongTypeError = TypeError("Wrong type found, expected ");

async function connection_websockets() {
  const wss = new WebSocketServer({ port: 679 });

  wss.on('connection', async (ws) => {
    console.log('New WebSocket connection');

    ws.on('message', async (data) => {
      console.log('data: %s', data);
      const requestData = JSON.parse(data);

      switch (requestData.eventType) {
        case 'Task Creation':
          await handleTaskCreation(ws, requestData);
          break;
        case 'Release Data Request':
          await handleReleaseDataRequest(ws);
          break;
        case 'Semantic Analysis Request':
          await handlesSemanticAnalysisRequest(ws,requestData);
          break;
        default:
          console.log('Unsupported event type');
      }
    });
  });

  wss.on('close', () => {
    console.log('Connection closed');
  });
}

async function handleTaskCreation(ws, task_data) {
  const website = task_data.store;
  switch (website) {
    case 'Trapstar':
      runTrapstarBotInNewThread(task_data, ws);
      break;
    case 'End-Clothing':
      break;
    default:
      console.log('Website not supported');
  }
}

async function handleReleaseDataRequest(ws) {
  get_releases_data(ws);
}
async function handlesSemanticAnalysisRequest(ws, data){
  SemanticAnalysis(data.product,data.keywords,data.sentimentNumber,ws);
}

connection_websockets();
