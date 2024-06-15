import 'wand.dart';

class Personage {
  String id;
  String name;
  List<String> alternateNames;
  String species;
  String gender;
  String house;
  String dateOfBirth;
  int yearOfBirth;
  bool wizard;
  String ancestry;
  String eyeColour;
  String hairColour;
  Wand wand;
  String patronus;
  bool hogwartsStudent;
  bool hogwartsStaff;
  String actor;
  List<dynamic> alternateActors;
  bool alive;
  String image;
  bool isGuessedCorrect;
  int attempts;

  Personage({
    required this.id,
    required this.name,
    required this.alternateNames,
    required this.species,
    required this.gender,
    required this.house,
    required this.dateOfBirth,
    required this.yearOfBirth,
    required this.wizard,
    required this.ancestry,
    required this.eyeColour,
    required this.hairColour,
    required this.wand,
    required this.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    required this.actor,
    required this.alternateActors,
    required this.alive,
    required this.image,
    this.isGuessedCorrect=true,
    this.attempts=0
  });
Personage.empty()
      : id = '',
        name = '',
        alternateNames = [],
        species = '',
        gender = '',
        house = '',
        dateOfBirth = '',
        yearOfBirth = 0,
        wizard = false,
        ancestry = '',
        eyeColour = '',
        hairColour = '',
        wand = Wand.empty(),
        patronus = '',
        hogwartsStudent = false,
        hogwartsStaff = false,
        actor = '',
        alternateActors = [],
        alive = false,
        image = '',
        isGuessedCorrect=false,
        attempts=0;


  factory Personage.fromJson(Map<String, dynamic> json) {
    return Personage(
      id: json['id'],
      name: json['name']??'',
      alternateNames: List<String>.from(json['alternate_names']),
      species: json['species']??'',
      gender: json['gender']??'',
      house: json['house']??'',
      dateOfBirth: json['dateOfBirth']??'',
      yearOfBirth: json['yearOfBirth']??0,
      wizard: json['wizard']??false,
      ancestry: json['ancestry']??'',
      eyeColour: json['eyeColour']??'',
      hairColour: json['hairColour']??'',
      wand: Wand.fromJson(json['wand']),
      patronus: json['patronus']??'',
      hogwartsStudent: json['hogwartsStudent']??false,
      hogwartsStaff: json['hogwartsStaff']??false,
      actor: json['actor'],
      alternateActors: List<dynamic>.from(json['alternate_actors']),
      alive: json['alive']??false,
      image: json['image']??"",
      isGuessedCorrect:json['isGuessedCorrect']??false,
      attempts: json['attempts']??0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'alternate_names': alternateNames,
      'species': species,
      'gender': gender,
      'house': house,
      'dateOfBirth': dateOfBirth,
      'yearOfBirth': yearOfBirth,
      'wizard': wizard,
      'ancestry': ancestry,
      'eyeColour': eyeColour,
      'hairColour': hairColour,
      'wand': wand.toJson(),
      'patronus': patronus,
      'hogwartsStudent': hogwartsStudent,
      'hogwartsStaff': hogwartsStaff,
      'actor': actor,
      'alternate_actors': alternateActors,
      'alive': alive,
      'image': image,
      'isGuessedCorrect':isGuessedCorrect,
      'attempts':attempts
    };
  }
}