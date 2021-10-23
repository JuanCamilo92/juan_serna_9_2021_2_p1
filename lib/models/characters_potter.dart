class CharactersHP {
  String name = '';
  //List<String> alternateNames = [];
  String species ='';
  String gender ='';
  String house ='';
  String dateOfBirth ='';
  int yearOfBirth =0;
  bool wizard = false;
  String ancestry ='';
  String eyeColour ='';
  String hairColour ='';
  //Wand wand;
  String patronus ='';
  bool hogwartsStudent = false;
  bool hogwartsStaff = false;
  String actor ='';
  List<String> alternateActors = [];
  bool alive = false;
  String image ='';

  CharactersHP(
      {required this.name,
      //required this.alternateNames,
      required this.species,
      required this.gender,
      required this.house,
      required this.dateOfBirth,
      required this.yearOfBirth,
      required this.wizard,
      required this.ancestry,
      required this.eyeColour,
      required this.hairColour,
      //this.wand,
      required this.patronus,
      required this.hogwartsStudent,
      required this.hogwartsStaff,
      required this.actor,
      required this.alternateActors,
      required this.alive,
      required this.image});

  CharactersHP.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    //alternateNames = json['alternate_names'].cast<String>();
    species = json['species'];
    gender = json['gender'];
    house = json['house'];
    dateOfBirth = json['dateOfBirth'];
    if (json['yearOfBirth'] != '') {
      yearOfBirth = json['yearOfBirth'];
    } else {
      yearOfBirth = 0;
    }
    //yearOfBirth = json['yearOfBirth'].cast<String>();
    wizard = json['wizard'];
    ancestry = json['ancestry'];
    eyeColour = json['eyeColour'];
    hairColour = json['hairColour'];
    //wand = json['wand'] != null ? new Wand.fromJson(json['wand']) : null;
    patronus = json['patronus'];
    hogwartsStudent = json['hogwartsStudent'];
    hogwartsStaff = json['hogwartsStaff'];
    actor = json['actor'];
    alternateActors = json['alternate_actors'].cast<String>();
    alive = json['alive'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    //data['alternate_names'] = this.alternateNames;
    data['species'] = this.species;
    data['gender'] = this.gender;
    data['house'] = this.house;
    data['dateOfBirth'] = this.dateOfBirth;
    data['yearOfBirth'] = this.yearOfBirth;
    data['wizard'] = this.wizard;
    data['ancestry'] = this.ancestry;
    data['eyeColour'] = this.eyeColour;
    data['hairColour'] = this.hairColour;
    /*if (this.wand != null) {
      data['wand'] = this.wand.toJson();
    }*/
    data['patronus'] = this.patronus;
    data['hogwartsStudent'] = this.hogwartsStudent;
    data['hogwartsStaff'] = this.hogwartsStaff;
    data['actor'] = this.actor;
    data['alternate_actors'] = this.alternateActors;
    data['alive'] = this.alive;
    data['image'] = this.image;
    
    return data;
  }
}