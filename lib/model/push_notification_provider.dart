import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajeStreamController = StreamController<dynamic>.broadcast();

  Stream<dynamic> get mensajes => _mensajeStreamController.stream;

  initNotificacion() {
    _firebaseMessaging.requestNotificationPermissions();

    

    _firebaseMessaging.configure(
      onMessage: (info) {
        print('============= on Message =============');
        print(info);

        _mensajeStreamController.sink.add(info['data']);
      },
      onLaunch: (info) {
        print('============= on Launch =============');
        print(info);
        _mensajeStreamController.sink.add(info['data']);
      },
      onResume: (info) {
        print('============= on Resume =============');
        print(info);
        // final noti = info['data']['comida'];
        // print(noti);
        _mensajeStreamController.sink.add(info['data']);
      },
    );
  }

  dispose() {
    _mensajeStreamController?.close();
  }
}
