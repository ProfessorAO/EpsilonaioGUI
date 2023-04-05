import axios from "axios";

const options = {
  method: 'GET',
  url: 'https://sneaker-database-stockx.p.rapidapi.com/mostpopular',
  //params: {keywords: 'yeezy', limit: '20'},
  headers: {
    'X-RapidAPI-Key': '6f3e91ea75msh7fe7a628ac745d6p1fdf6fjsn22fd7b9b9ac4',
    'X-RapidAPI-Host': 'sneaker-database-stockx.p.rapidapi.com'
  }
};

axios.request(options).then(function (response) {
	console.log(response.data);
}).catch(function (error) {
	console.error(error);
});