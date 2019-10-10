class Subscripcion {
  DateTime initSubscription;
  DateTime finalSubscription;
  DateTime creationDate;
  String idSubscription;
  String igGym;
  String nameGym;
  String idUser;
  String nameUser;
  double price;
  int months;
  String plan;
  bool stateSubscription;

  Subscripcion(
      {DateTime initSubscription,
      DateTime finalSubscription,
      this.creationDate,
      this.idSubscription = '',
      this.igGym = '',
      this.nameGym = '',
      this.idUser = '',
      this.nameUser = '',
      this.price = 0,
      this.months = 1,
      this.plan = '',
      this.stateSubscription = true}) {
    this.initSubscription = initSubscription ?? DateTime.now();
    this.finalSubscription =
        finalSubscription ?? DateTime.now().add(Duration(hours: 30 * 24));
    this.initSubscription = initSubscription ?? DateTime.now();
  }

  Map<String,dynamic> toMap() {
    return {
      'initSubscription': this.initSubscription,
      'finalSubscription': this.finalSubscription,
      'creationDate': DateTime.now(),
      'idSubscription': this.idSubscription,
      'igGym': this.igGym,
      'nameGym': this.nameGym,
      'idUser': this.idUser,
      'nameUser': this.nameUser,
      'price': this.price,
      'months': this.months,
      'plan': this.plan,
      'stateSubscription': this.stateSubscription
    };
  }

  factory Subscripcion.fromMap(Map doc) {
    Subscripcion subscripcion = Subscripcion(
        initSubscription: doc['initSubscription'].toDate(),
        finalSubscription: doc['finalSubscription'].toDate(),
        creationDate: doc['creationDate'].toDate(),
        idSubscription: doc['idSubscription'],
        igGym: doc['igGym'],
        nameGym: doc['nameGym'],
        idUser: doc['idUser'],
        nameUser: doc['nameUser'],
        price: doc['price'],
        months: doc['months'],
        plan: doc['plan'],
        stateSubscription: doc['stateSubscription']);
    return subscripcion;
  }
}
