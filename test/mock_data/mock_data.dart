import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/data/data.vos/genre_vo.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';

List<MovieVO> getMockMoviesForTest(){

  return [
      MovieVO(
        false, 
        "/fOy2Jurz9k6RnJnMUMRDAgBwru2.jpg",
         [
           16,
           10751,
            35,
            14,
            ],
          508947, 
          "en",
           "Turning Red", 
          "Thirteen-year-old Mei is experiencing the awkwardness of being a teenager with a twist – when she gets too excited, she transforms into a giant red panda.",
           5329.202,
           "/qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ.jpg",
           "2022-03-01",
           "Turning Red", 
           false,
           7.5,
           1433,
           null,
           null,
           null,
           null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null, 
            true,
            false,
            false,
        ),

        MovieVO(
        false, 
        "/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
         [
                28,
                12,
                878 
            ],
          634649, 
          "en",
           "Spider-Man: No Way Home", 
          "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
           6064.019,
           "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
           "2021-12-15",
           "Spider-Man: No Way Home", 
           false,
           8.2,
           11022,
           null,
           null,
           null,
           null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null, 
            false,
            true,
            false,
        ),

        MovieVO(
        false, 
        "/wPU78OPN4BYEgWYdXyg0phMee64.jpg",
         [
                18,
                80
            ],
          278, 
          "en",
          "The Shawshank Redemption", 
          "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
           78.147,
           "/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg",
           "1994-09-23",
           "The Shawshank Redemption", 
           false,
           8.7,
           21091,
           null,
           null,
           null,
           null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null, 
            false,
            false,
            true,
        ),

  ];
}

List<ActorVO> getMockActors(){
  
  return [
    ActorVO(
      false,
      224513,
      [],
      129.227,
      "Ana de Armas",
      "/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg",
      "Acting",
      null,
      null,
      null,
      null,
      null,
   ),

     ActorVO(
      false,
      2958961,
      [],
      122.259,
      "Ana Jalandoni",
      "/6kOWtxVxaPMzxJ1jamuSzzTIkY2.jpg",
      "Acting",
      null,
      null,
      null,
      null,
      null,
   ),

     ActorVO(
      false,
      1136406,
      [],
      105.135,
      "Tom Holland",
      "/bBRlrpJm9XkNSg0YT5LCaxqoFMX.jpg",
      "Acting",
      null,
      null,
      null,
      null,
      null,
   ),
   
  ];
}


List<GenreVO> getMockGenres(){
  
  return [
    GenreVO(1, "Action"),
    GenreVO(2, "Adventure"),
    GenreVO(3, "Comedy"),
  ];
}

List<List<ActorVO>> getMockCredits(){

  return [

    [
      ActorVO(
        false,
         90633,
          null,
           68.643,
            "Gal Gadot",
             "/plLfB60M5cJrnog8KvAKhI4UJuk.jpg",
              "Acting",
               "Gal Gadot",
                0,
                 "Diana Prince / Wonder Woman",
                 "595686e4c3a368382e050da4",
                   0,
                   ),

        ActorVO(
        false,
         62064,
          null,
           28.074,
            "Chris Pine",
             "/ipG3BMO8Ckv9xVeEY27lzq975Qm.jpg",
              "Acting",
               "Chris Pine",
                15,
                 "Steve Trevor",
                 "5b0b4526c3a3684adc0097a5",
                   1,
                   ),

   ActorVO(
        false,
         41091,
          null,
           16.234,
            "Kristen Wiig",
             "/N517EQh7j4mNl3BStMmjMN6hId.jpg",
              "Acting",
               "Kristen Wiig",
                12,
                 "Barbara Minerva / Cheetah",
                 "5a975236c3a36861510077f1",
                   2,
                   ),
    ],

    [
      ActorVO(
        false,
         1113,
          null,
           3.908,
            "Lucinda Syson",
             null,
              "Production",
               "Lucinda Syson",
                null,
                 null,
                 "5c726ac6c3a3685a32151706",
                   null,
                   ), 

      ActorVO(
        false,
         947,
          null,
           5.193,
            "Hans Zimmer",
             "/tpQnDeHY15szIXvpnhlprufz4d.jpg",
              "Sound",
               "Hans Zimmer",
                null,
                 null,
                 "5b7dcdd70e0a2615ba005fa8",
                   null,
                   ),

         ActorVO(
        false,
         282,
          null,
           1.958,
            "Charles Roven",
             "/4uJLoVstC1CBcArXFOe53N2fDr1.jpg",
              "Production",
               "Charles Roven",
                null,
                 null,
                "5b212459c3a368149000ed97",
                   null,
                   ),           
    ],

  ];

}

