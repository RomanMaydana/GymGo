class CheckIn {
  final String idSubscription;
  final String gymId;
  final String userId;
  final String nameUser;
  final String nameGym;
  final DateTime creationDate;
  final bool stateCheckIn;

  CheckIn(
      {this.idSubscription,
      this.gymId,
      this.userId,
      this.nameUser,
      this.nameGym,
      this.creationDate,
      this.stateCheckIn = false});
  factory CheckIn.fromMap(Map doc) {
    CheckIn checkIn = CheckIn(
        idSubscription: doc['idSubscription'],
        gymId: doc['gymId'],
        userId: doc['userId'],
        nameUser: doc['nameUser'],
        nameGym: doc['nameGym'],
        creationDate: doc['creationDate'].toDate(),
        stateCheckIn: doc['stateCheckIn']);
    return checkIn;
  }

  Map<String,dynamic> toMap() {
   
    return {
      'idSubscription': this.idSubscription,
      'gymId': this.gymId,
      'userId': this.userId,
      'nameUser': this.nameUser,
      'nameGym': this.nameGym,
      'creationDate': DateTime.now(),
      'stateCheckIn': this.stateCheckIn
    };
  }
}
