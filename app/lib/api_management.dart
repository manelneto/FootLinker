class ApiManagement {
  Map<String, String> headers = {};
  String url = "";

  ApiManagement() {
    bool rapid = true; // FLAG

    Map<String, String> headersRapidAPI = {
      'X-RapidAPI-Key': 'f98943d9bamshd4cccfea72196b8p106219jsnd303daf9b388',
      'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
    };

    String urlRapidAPI = "https://api-football-v1.p.rapidapi.com/v3/";

    Map<String, String> headersFootballAPI = {
      'x-rapidapi-key': 'ee1436cf7c3f62f5287fee99a014da15',
      'x-rapidapi-host': 'v3.football.api-sports.io',
    };

    String urlFootballAPI = "https://v3.football.api-sports.io/";

    if (true) {
      headers = headersRapidAPI;
      url = urlRapidAPI;
    } else {
      headers = headersFootballAPI;
      url = urlFootballAPI;
    }
  }
}
