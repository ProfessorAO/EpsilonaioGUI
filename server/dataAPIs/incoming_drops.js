import axios from "axios";

const options = {
  method: 'GET',
  url: 'https://the-sneaker-database.p.rapidapi.com/sneakers',
  params: {limit: '100', releaseDate: 'gt:2023-04-08', sort: 'releaseDate:asc'},
  headers: {
    'X-RapidAPI-Key': '6f3e91ea75msh7fe7a628ac745d6p1fdf6fjsn22fd7b9b9ac4',
    'X-RapidAPI-Host': 'the-sneaker-database.p.rapidapi.com'
  }
};

axios.request(options).then(function (response) {
    //for (let index = 0; index < 9; index++) {
        console.log(response.data.results);
    //}
	
}).catch(function (error) {
	console.error(error);
});