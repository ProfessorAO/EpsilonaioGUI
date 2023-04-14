import fs from 'fs';
import request_data from '../dataAPIs/incoming_drops.js';

// Set the time interval for how often the function can be called (in milliseconds)
const CALL_INTERVAL = 86400000; // 1 day in milliseconds

// Define a variable to store the timestamp of the last function call
let lastCallTimestamp = 0;

// Read the last call timestamp from a file, if it exists
fs.readFile('Data/timestamp.txt', 'utf-8', (err, timestampFile) => {
    if (err) {
        console.log('Error reading timestamp file:', err.message);
    } else {
        lastCallTimestamp = parseInt(timestampFile, 10);
    }
});

async function saveDataToFile(data) {
    try {
        await fs.promises.writeFile('Data/Upcoming releases.txt', JSON.stringify(data), 'utf-8');
    } catch (err) {
        console.error('Error writing to file:', err.message);
    }
}

export default async function get_releases_data(socket) {
    const now = Date.now();

    // Check if the function was called less than a week ago
    if (now - lastCallTimestamp < CALL_INTERVAL) {
        console.log('Function called too soon. Skipping...');
        
    } else {
        try {
            const data = await request_data();
            await saveDataToFile(data);
            console.log('Data Saved');

            // If it's been a week or more since the last call, update the timestamp and continue with the
            lastCallTimestamp = now;

            // Write the new timestamp to the file
            await fs.promises.writeFile('Data/timestamp.txt', lastCallTimestamp.toString(), 'utf-8');
        } catch (err) {
            console.error('Error fetching data:', err.message);
        }
    }

    try {
        var docutext = (await fs.promises.readFile("Data/Upcoming releases.txt")).toString('utf-8');
        var text_parsed = JSON.parse(docutext);
        console.log('Data retrieved');
        socket.send(JSON.stringify(text_parsed));
        console.log('Data sent');
    } catch (err) {
        console.error('Error fetching data:', err.message);
    }
}
