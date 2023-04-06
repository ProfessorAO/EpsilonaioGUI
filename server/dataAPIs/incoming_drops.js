import axios from "axios";

export default async function request_data() {
  let date = get_current_date();
  const options = {
    method: 'GET',
    url: 'https://the-sneaker-database.p.rapidapi.com/sneakers',
    params: { limit: '100', releaseDate: 'gt:' + date, sort: 'releaseDate:asc' },
    headers: {
      'X-RapidAPI-Key': '6f3e91ea75msh7fe7a628ac745d6p1fdf6fjsn22fd7b9b9ac4',
      'X-RapidAPI-Host': 'the-sneaker-database.p.rapidapi.com'
    }
  };

  return axios.request(options)
    .then(function (response) {
      console.log("SAVED");
      return response.data.results;
    })
    .catch(function (error) {
      console.error(error);
    });
}

function get_current_date() {
  const currentDate = new Date();
  const year = currentDate.getFullYear();
  const month = String(currentDate.getMonth() + 1).padStart(2, '0');
  const day = String(currentDate.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
}
