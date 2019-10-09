import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong/latlong.dart';

class Picture {
  final String name;
  final String url;

  Picture({this.name, this.url});
  get getName {
    return name;
  }

  Map<String, dynamic> toMap() {
    return {'name': this.name, 'url': this.url};
  }

  factory Picture.fromMap(Map doc) {
    Picture picture = Picture(name: doc['name'], url: doc['url']);
    return picture;
  }
}

class Schedule {
  Set<String> day;
  TimeOfDay hourIn;
  TimeOfDay hourOut;
  Schedule() {
    day = Set();
    final date = DateTime.now();
    this.hourIn = TimeOfDay(minute: date.minute, hour: date.hour);
    this.hourOut = TimeOfDay(minute: date.minute, hour: date.hour + 1);
  }

  Map<String, dynamic> toMap() {
    return {
      'day': this.day.toList(),
      'minIn': this.hourIn.minute,
      'hourIn': this.hourIn.hour,
      'minOut': this.hourOut.minute,
      'hourOut': this.hourOut.hour,
    };
  }

  factory Schedule.fromMap(Map doc) {
    Schedule schedule = Schedule();
    schedule.day = doc['day'].cast<String>().toSet();
    schedule.hourIn = TimeOfDay(minute: doc['minIn'], hour: doc['hourIn']);
    schedule.hourOut = TimeOfDay(minute: doc['minOut'], hour: doc['hourOut']);
    return schedule;
  }
}

class Gym {
  String _name;
  List<Picture> _picture;
  String _phone;
  double _rating;
  bool _state;

  String _pais;
  String _city;
  String _internationalCode;
  String _zone;
  String _streetOrAvenue;
  // String _typeDirection;
  LatLng _location;

  Set<String> _service;
  Set<String> _classes;
  List<Schedule> _schedule;
  // aux of schefdule
  Set<String> _auxDaySet = Set();
  //end aux of schedule

  double _price;
  String _plan;
  bool _statePlan;
  DateTime _creationTime;
  String _gymId;
  String _userId;
  Gym(
      {String name = '',
      List<Picture> picture,
      String phone = '',
      double rating = 4,
      bool state = true,
      String pais = 'Bolivia',
      String city = 'La Paz',
      String internationalCode = '+591',
      String zone = '',
      String streetOrAvenue = '',
      LatLng location,
      Set<String> service,
      Set<String> classes,
      List<Schedule> schedule,
      double price = 0,
      String plan = 'Basic',
      bool statePlan = true,
      DateTime creationTime,
      String gymId = '',
      String userId = ''}) {
    this._name = name;
    this._picture = picture ?? [];
    this._phone = phone;
    this._rating = rating;
    this._state = state;

    this._pais = pais;
    this._city = city;
    this._internationalCode = internationalCode;
    this._zone = zone;
    this._streetOrAvenue = streetOrAvenue;
    // this._typeDirection = typeDirection;
    this._location = location ?? LatLng(0, 0);

    this._service = service ?? Set();
    this._classes = classes ?? Set();
    this._schedule = schedule ?? [];

    this._price = price;
    this._plan = plan;
    this._statePlan = statePlan;

    this._creationTime = creationTime;
    this._gymId = gymId;
    this._userId = userId;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this._name,
      'picture': this._picture.map((picture) => picture.toMap()).toList(),
      'phone': this._phone,
      'rating': this._rating,
      'state': this._state,
      'pais': this._pais,
      'city': this._city,
      'internationalCode': this._internationalCode,
      'zone': this._zone,
      'streetOrAvenue': this._streetOrAvenue,
      'location': GeoPoint(this._location.latitude, this._location.longitude),
      'service': this._service.toList(),
      'classes': this._classes.toList(),
      'schedule': this._schedule.map((schedule) => schedule.toMap()).toList(),
      'price': this._price,
      'plan': this._plan,
      'statePlan': this._statePlan,
      'creationTime': DateTime.now(),
      'userId': this._userId,
    };
  }

  factory Gym.fromMap(Map doc) {
    
    Gym gym = Gym(
        name: doc['name'],
        picture: (doc['picture'] as List)
            .map((picture) => Picture.fromMap(picture))
            .toList(),
        phone: doc['phone'],
        rating: doc['rating'].toDouble(),
        state: doc['state'],
        pais: doc['pais'],
        city: doc['city'],
        internationalCode: doc['internationalCode'],
        zone: doc['zone'],
        streetOrAvenue: doc['streetOrAvenue'],
        location: LatLng(doc['location'].latitude,doc['location'].longitude),
        service: doc['service'].cast<String>().toSet(),
        classes: doc['classes'].cast<String>().toSet(),
        schedule: (doc['schedule'] as List)
            .map((schedule) => Schedule.fromMap(schedule))
            .toList(),
        price: doc['price'],
        plan: doc['plan'],
        statePlan: doc['statePlan'],
        creationTime: doc['creationTime'].toDate(),
        gymId: doc['gymId'],
        userId: doc['userId']);

    return gym;
  }
  String get userId => _userId;
  set userId(String userId) {
    _userId = userId;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  void set setName(String name) {
    this._name = name;
  }

  String get getName {
    return this._name;
  }

  List<Picture> get picture => _picture;

  set picture(List<Picture> value) {
    _picture = value;
  }

  String getIndexPicture(int i) {
    return _picture[i].name;
  }

  void addPicture(Picture picture) {
    _picture.add(picture);
  }

  void deletePicture(int i) {
    _picture.removeAt(i);
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  double get rating => _rating;

  set rating(double value) {
    _rating = value;
  }

  bool get state => _state;

  set state(bool value) {
    _state = value;
  }

  String get pais => _pais;

  set pais(String value) {
    _pais = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get internationalCode => _internationalCode;

  set internationalCode(String value) {
    _internationalCode = value;
  }

  String get zone => _zone;

  set zone(String value) {
    _zone = value;
  }

  String get streetOrAvenue => _streetOrAvenue;

  set streetOrAvenue(String value) {
    _streetOrAvenue = value;
  }

  // String get typeDirection => _typeDirection;

  // set typeDirection(String value) {
  //   _typeDirection = value;
  // }

  LatLng get location => _location;

  set location(LatLng value) {
   
    _location = value;
  }

  Set<String> get service => _service;

  set service(Set<String> value) {
    _service = value;
  }

  Set<String> get classes => _classes;

  set classes(Set<String> value) {
    _classes = value;
  }

  List<Schedule> get schedule => _schedule;

  set schedule(List<Schedule> value) {
    _schedule = value;
  }

  Schedule getScheduleOfIndex(int index) {
    return _schedule[index];
  }

  void addDayInSchedule(String day, int index) {
    if (this._auxDaySet.contains(day)) {
      for (var i in _schedule) {
        i.day.remove(day);
      }
    } else {
      this._auxDaySet.add(day);
    }
    this._schedule[index].day.add(day);
  }

  void removeDayInSchedule(String day, int index) {
    this._auxDaySet.remove(day);
    this._schedule[index].day.remove(day);
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  String get plan => _plan;

  set plan(String value) {
    _plan = value;
  }

  bool get statePlan => _statePlan;

  set statePlan(bool value) {
    _statePlan = value;
  }
}

class Service {
  final String title;
  final IconData iconData;

  Service({this.title, this.iconData});
}
