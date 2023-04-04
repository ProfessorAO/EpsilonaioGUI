export default function get_releases_data(socket){
    var docutext = fs.readFileSync("./Upcoming releases.txt").toString('utf-8');
    var text_parsed = JSON.parse(docutext);
    console.log('Data retrieved');
    socket.send(JSON.stringify(text_parsed));
    console.log('Data sent');
    
}