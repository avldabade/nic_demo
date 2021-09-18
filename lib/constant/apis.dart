class Apis {
  /// base url
  static const String baseUrl = "";
  /// end points with base url
  static const login = baseUrl+"api/LoginApi/login_post";


   /// end points with base url
   //static const CURRENT_WEATHER_API_BY_CITY = "https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}";
   static const CURRENT_WEATHER_API_BY_CITY = "https://api.openweathermap.org/data/2.5/weather?q=";//{city name}&appid={API key}";

  //by LAT LANG CURRENT DATA
  static const CURRENT_WEATHER_API_BY_LAT_LANG = "https://api.openweathermap.org/data/2.5/weather?lat=";
  //https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid={API key}
  //https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=ab0106af5a0a5ed5e56f92a803045e87


  //BY ZIP CODE CURRENT DATA
  static const CURRENT_WEATHER_API_BY_ZIPCODE = "https://api.openweathermap.org/data/2.5/weather?zip={zip code},{country code}&appid={API key}";
  //https://api.openweathermap.org/data/2.5/weather?zip=94040,us&appid={API key}

  //BY LAT LANG CODE LAST 5DAY DATA
  static const FIVE_DAY_WEATHER_API_BY_LAT_LANG = "https://api.openweathermap.org/data/2.5/forecast?lat=";
//https://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&appid={API key}

  //BY ZIP CODE LAST 5DAY DATA
  static const FIVE_DAY_WEATHER_API_BY_ZIPCODE = "https://api.openweathermap.org/data/2.5/forecast?zip={zip code},{country code}&appid={API key}";
//https://api.openweathermap.org/data/2.5/forecast?zip=94040,us&appid={API key}

}