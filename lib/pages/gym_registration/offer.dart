import 'package:flutter/material.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/model/gym_reg_model.dart';

import 'package:gym_go/style/text.dart';
import 'package:gym_go/widget/button/button_add_gym.dart';
import 'package:gym_go/widget/button/button_next_gym.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Offer extends StatefulWidget {
  @override
  _OfferState createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  final _formKey = GlobalKey<FormState>();
  final text = TextEditingController();
  bool _listValidateClasses = false;
  bool _listValidateServices = false;
  bool _listValidateSchedules = false;

  @override
  Widget build(BuildContext context) {
    GymRegModel gymRegModel = Provider.of(context);

    Widget _buildCheck(String cl) {
      final alreadySaved = gymRegModel.getGym.classes.contains(cl);
      return InkWell(
        onTap: () {
          if (alreadySaved) {
            gymRegModel.removeClasses(cl);
          } else {
            gymRegModel.addClasses(cl);
          }
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 0.5,
                      color: alreadySaved ? Colors.green : Colors.black26,
                    )),
                child: alreadySaved
                    ? Icon(
                        Icons.check,
                        size: 20,
                        color: Colors.green,
                      )
                    : Container(),
              ),
              SizedBox(
                width: 16,
              ),
              Text(cl),
            ],
          ),
        ),
      );
    }

    _builCheckServices(Service service) {
      final alreadySaved = gymRegModel.getGym.service.contains(service.title);
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Tooltip(
          message: service.title,
          verticalOffset: 30,
          height: 24,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                if (alreadySaved) {
                  gymRegModel.removeServices(service.title);
                } else {
                  gymRegModel.addServices(service.title);
                }
              },
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 0.5,
                      color: alreadySaved ? Colors.green : Colors.black26,
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      service.iconData,
                      color: alreadySaved ? Colors.green : Colors.black26,
                    ),
                    // Text(service.title, )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildCheckDay(String day, int index) {
      final alreadySaved = gymRegModel.getGym.schedule[index].day.contains(day);

      return Expanded(
        child: Tooltip(
          message: day,
          verticalOffset: 30,
          height: 24,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                if (alreadySaved) {
                  gymRegModel.removeDayInSchedule(day, index);
                } else {
                  gymRegModel.addDayInSchedule(day, index);
                }
              },
              child: Container(
                  // padding: const EdgeInsets.all(4.0),

                  height: 25,
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      '${day[0].toUpperCase()}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: alreadySaved ? Colors.green : Colors.black26),
                    ),
                  )),
            ),
          ),
        ),
      );
    }

    Widget _buidlTime(TimeOfDay time, VoidCallback onTap) {
      print(time);
      return InkWell(
        onTap: onTap,
        child: Container(
          height: 30,
          width: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 0.4, color: Colors.black26),
              borderRadius: BorderRadius.circular(5)),
          child: Text(time.hour.toString().padLeft(2, '0') +
              ':' +
              time.minute.toString().padLeft(2, '0')),
        ),
      );
    }

    Future<TimeOfDay> showTimePick(TimeOfDay time) {
      Future<TimeOfDay> selectedTime24Hour = showTimePicker(
        context: context,
        initialTime: time,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        },
      );
      return selectedTime24Hour;
    }

    Widget _buildScheduleConfig(Schedule schedule) {
      int index = gymRegModel.getGym.schedule.indexOf(schedule);
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (var day in gymRegModel.listDay) _buildCheckDay(day, index),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Abierto:'),
              _buidlTime(schedule.hourIn, () async {
                TimeOfDay hourIn = await showTimePick(schedule.hourIn);
                if (hourIn != null) {
                  gymRegModel.setScheduleHourIn(hourIn, index);
                }
              }),
              Text('Cerrado:'),
              _buidlTime(schedule.hourOut, () async {
                TimeOfDay hourOut = await showTimePick(schedule.hourOut);
                if (hourOut != null) {
                  gymRegModel.setScheduleHourOut(hourOut, index);
                }
              })
            ],
          ),
          Container(
            margin: EdgeInsets.all(8),
            height: 0.5,
            color: Colors.black26,
          )
        ],
      );
    }

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '¿Qué clases imparte?',
                  style: StylesText.textTitleRegGym,
                ),
                SizedBox(
                  height: 28,
                ),
                for (var text in gymRegModel.listClasses) _buildCheck(text),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: text,
                        decoration: InputDecoration(
                          labelText: 'Otro',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ButtonAddGym(
                      color: Colors.blue,
                      onPressed: () {
                        print(text.text);
                        if (text.text.trim() != '') {
                          gymRegModel.addToListClasses(text.text.trim());
                          text.clear();
                        }
                      },
                      size: 45,
                    ),
                  ],
                ),
                _listValidateClasses
                    ? Container(
                        margin: EdgeInsets.only(top: 8, left: 16),
                        child: Text(
                          'Selecciona al menos una clase.',
                          style: TextStyle(
                              color: Theme.of(context).errorColor,
                              fontSize: 12),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 32,
                ),
                Text(
                  '¿Qué servicios están disponibles?',
                  style: StylesText.textTitleRegGym,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Para mas información, manten presionado por 2 segundos.',
                  style: StylesText.textSubtitleRegGym,
                ),
                SizedBox(
                  height: 24,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    for (var service in gymRegModel.listServices)
                      _builCheckServices(service),
                  ],
                ),
                _listValidateServices
                    ? Container(
                        margin: EdgeInsets.only(top: 8, left: 16),
                        child: Text(
                          'Selecciona al menos un servicio.',
                          style: TextStyle(
                              color: Theme.of(context).errorColor,
                              fontSize: 12),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 32,
                ),
                Text(
                  '¿En qué horarios atenderá?',
                  style: StylesText.textTitleRegGym,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Puedes seleccionar varios días con un mismo horario. Nota: Los horarios que no tengan ningún dia seleccionado, serán eliminados.',
                  style: StylesText.textSubtitleRegGym,
                ),
                SizedBox(
                  height: 24,
                ),
                for (Schedule schedule in gymRegModel.getGym.schedule)
                  _buildScheduleConfig(schedule),
                SizedBox(
                  height: 4,
                ),
                ButtonAddGym(
                  color: Colors.blue,
                  onPressed: () {
                    gymRegModel.addSchedule();
                  },
                  size: 45,
                ),
                _listValidateSchedules
                    ? Container(
                        margin: EdgeInsets.only(top: 8, left: 16),
                        child: Text(
                          'Elige al menos un horario.',
                          style: TextStyle(
                              color: Theme.of(context).errorColor,
                              fontSize: 12),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ButtonNextGym(
                      color: Colors.white,
                      splashColor: Colors.blue,
                      radius: 30,
                      onTap: () {
                        _formKey.currentState.save();
                        gymRegModel.previousPage();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.black26,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Anterior',
                            style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          SizedBox(
                            width: 4,
                          )
                        ],
                      ),
                    ),
                    ButtonNextGym(
                      color: Colors.blue,
                      splashColor: Colors.white10,
                      radius: 30,
                      onTap: () {
                        if (gymRegModel.getGym.classes.length == 0)
                          setState(() {
                            _listValidateClasses = true;
                          });
                        else if(_listValidateClasses)
                              setState(() {
                            _listValidateClasses = false;
                          });

                        if (gymRegModel.getGym.service.length == 0)
                          setState(() {
                            _listValidateServices = true;
                          });
                        else if(_listValidateServices)
                              setState(() {
                            _listValidateServices = false;
                          });
                        if (gymRegModel.getGym.schedule.length == 0)
                          setState(() {
                            _listValidateSchedules = true;
                          });
                        else if(_listValidateSchedules)
                              setState(() {
                            _listValidateSchedules = false;
                          });
                        if(!_listValidateClasses && !_listValidateServices && !_listValidateSchedules)
                          gymRegModel.nextPage();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Siguiente',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
