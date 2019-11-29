import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_go/model/plan.dart';
import 'package:latlong/latlong.dart';

import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:path/path.dart' as Path;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'gym.dart';

class GymRegModel extends ChangeNotifier {
  Gym _gym;
  TabController _tabController;
  int _selectedPage;
  String _userId;
  bool _isLoading;
  Set _listClasses;
  List<Service> _listServices;
  List<String> _listDay = [
    'lunes',
    'martes',
    'miercoles',
    'jueves',
    'viernes',
    'sabado',
    'domingo'
  ];
  Set<String> _setDay;
  GymRegModel({TickerProvider vsync, String userId, Gym gym}) {
    this._gym = gym ?? Gym();
    /* list, what offers?*/
    this._listClasses = Set<String>();
    this._listServices = [];
    this._setDay = Set();
    // this._listDay = [];
    /* end list, what offers?*/
    this._intoDateInList();
    this._selectedPage = 0;
    this._tabController =
        TabController(initialIndex: 0, length: 4, vsync: vsync);
    this._userId = userId;
    this._isLoading = false;
    notifyListeners();
  }

  void _intoDateInList() {
    _listClasses.add('Gimnasia');
    _listClasses.add('Cardio');
    _listClasses.add('Crossfit');
    _listClasses.add('Esgrima');
    _listClasses.add('Yoga');
    _listClasses.add('Karate');
    _listClasses.add('Spinning');
    _listClasses.add('Aeróbicos');

    _listServices.add(Service(iconData: Icons.wifi, title: 'Wifi'));
    _listServices.add(Service(iconData: Icons.local_parking, title: 'Parqueo'));
    _listServices.add(Service(iconData: MdiIcons.showerHead, title: 'Ducha'));
    _listServices
        .add(Service(iconData: MdiIcons.paperRollOutline, title: 'Baño'));
    _listServices.add(Service(iconData: MdiIcons.food, title: 'Restaurant'));
    _listServices.add(Service(iconData: MdiIcons.hanger, title: 'Vestidor'));
    _listServices.add(Service(
        iconData: MdiIcons.wheelchairAccessibility,
        title: 'Acceso para Discapacitados'));
    _listServices
        .add(Service(iconData: MdiIcons.wardrobeOutline, title: 'Taquilla'));
    _listServices.add(Service(
        iconData: MdiIcons.airConditioner, title: 'Aire Acondicionado'));
    _listServices.add(Service(iconData: MdiIcons.hotTub, title: 'Sauna'));

    // _listDay = [
    //   'lunes',
    //   'martes',
    //   'miercoles',
    //   'jueves',
    //   'viernes',
    //   'sabado',
    //   'domingo'
    // ];
  }

  List<String> get listDay {
    return this._listDay;
  }

  List<Service> get listServices {
    return this._listServices;
  }

  void removeServices(String value) {
    this._gym.service.remove(value);
    notifyListeners();
  }

  void addServices(String value) {
    this._gym.service.add(value);
    notifyListeners();
  }

  void addClasses(String value) {
    this._gym.classes.add(value);
    notifyListeners();
  }

  Set<String> get listClasses {
    return this._listClasses;
  }

  void removeClasses(String value) {
    this._gym.classes.remove(value);
    notifyListeners();
  }

  void addToListClasses(String value) {
    this._listClasses.add(value);
    this._gym.classes.add(value);
    notifyListeners();
  }

  get isLoading {
    return this._isLoading;
  }

  get getTabController {
    return _tabController;
  }

  get selectIndex {
    return _tabController.index;
  }

  void nextPage() {
    _tabController.index = _tabController.index + 1;
    notifyListeners();
  }

  void previousPage() {
    _tabController.index = _tabController.index - 1;
    notifyListeners();
  }

  Gym get getGym {
    return _gym;
  }

  Future uploadImage(String type) async {
    var image;
    if (type == 'galery')
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    else
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      this._isLoading = !this._isLoading;
      notifyListeners();
      try {
        final StorageReference storageReference = FirebaseStorage.instance
            .ref()
            .child('gym')
            .child(this._userId)
            .child('${Path.basename(image.path)}');

        StorageUploadTask uploadTask = storageReference.putFile(image);
        await uploadTask.onComplete;

        final url = await storageReference.getDownloadURL();

        Picture picture = Picture(name: Path.basename(image.path), url: url);
        _gym.addPicture(picture);
      } catch (e) {
        print('error $e');
      } finally {
        this._isLoading = !this._isLoading;
        notifyListeners();
      }
    }
  }

  Future<Gym> editGym() async {
    this._gym.stateVerify = false;
    
    await Firestore.instance
        .collection('Gym')
        .document(this._gym.gymId)
        .setData(this._gym.toMap());
    return this._gym;
  }

  Future<Gym> addToGymCollection({String userId, List<Plan> list}) async {
    _gym.userId = userId;
    Firestore firestore = Firestore.instance;

    if (_gym.statePlan) {
      
      String planId = '';
      for (Plan plan in list) {
        if (plan.plan == _gym.plan) {
          planId = plan.planId;
        }
      }
      
      final result = await firestore.collection('Plan').document(planId).get();
      if (result.exists) {
        firestore.runTransaction((Transaction t) async {
          final sfDoc = await t.get(result.reference);
          if (sfDoc.exists) {
            final qty = sfDoc.data['qty'] + 1;
            await t.update(sfDoc.reference, {'qty': qty});
          }
        });
      }
    }
    DocumentReference resultAdd =
        await firestore.collection('Gym').add(_gym.toMap());
    await resultAdd.updateData({'gymId': resultAdd.documentID});
    return _gym;
  }

  Future deleteImage(
    int index,
  ) async {
    try {
      final StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('gym')
          .child(this._userId)
          .child(this._gym.getIndexPicture(index));
      await storageReference.delete();
      _gym.deletePicture(index);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  set name(String value) {
    this._gym.name = value;
    notifyListeners();
  }

  set picture(List<Picture> value) {
    this._gym.picture = value;
    notifyListeners();
  }

  set phone(String value) {
    this._gym.phone = value;
    notifyListeners();
  }

  set rating(double value) {
    this._gym.rating = value;
    notifyListeners();
  }

  set state(bool value) {
    this._gym.state = value;
    notifyListeners();
  }

  set pais(String value) {
    this._gym.pais = value;
    notifyListeners();
  }

  set city(String value) {
    this._gym.city = value;
    notifyListeners();
  }

  set internationalCode(String value) {
    this._gym.internationalCode = value;
    notifyListeners();
  }

  set zone(String value) {
    this._gym.zone = value;
    notifyListeners();
  }

  set streetOrAvenue(String value) {
    this._gym.streetOrAvenue = value;
    notifyListeners();
  }

  // set typeDirection(String value) {
  //   this._gym.typeDirection = value;
  //   notifyListeners();
  // }

  set location(LatLng value) {
    this._gym.location = value;

    notifyListeners();
  }

  set service(Set<String> value) {
    this._gym.service = value;
    notifyListeners();
  }

  set classes(Set<String> value) {
    this._gym.classes = value;
    notifyListeners();
  }

  set schedule(List<Schedule> value) {
    this._gym.schedule = value;
    notifyListeners();
  }

  set price(double value) {
    this._gym.price = value;
    notifyListeners();
  }

  set plan(String value) {
    this._gym.plan = value;
    notifyListeners();
  }

  set statePlan(bool value) {
    this._gym.statePlan = value;
    notifyListeners();
  }

  void addSchedule() {
    Schedule schedule = Schedule();
    _gym.schedule.add(schedule);
    notifyListeners();
  }

  void setScheduleHourIn(TimeOfDay time, int index) {
    this._gym.schedule[index].hourIn = time;
    notifyListeners();
  }

  void setScheduleHourOut(TimeOfDay time, int index) {
    this._gym.schedule[index].hourOut = time;
    notifyListeners();
  }

  void removeDayInSchedule(String day, int index) {
    this._gym.removeDayInSchedule(day, index);
    notifyListeners();
  }

  void addDayInSchedule(String day, int index) {
    this._gym.addDayInSchedule(day, index);
    notifyListeners();
  }
}
