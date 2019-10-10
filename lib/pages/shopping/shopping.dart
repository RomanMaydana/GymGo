import 'package:flutter/material.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/model/plan.dart';
import 'package:gym_go/model/suscription_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/style/text.dart';
import 'package:gym_go/widget/button/button_next_gym.dart';
import 'package:provider/provider.dart';

class ShoppingPage extends StatefulWidget {
  final Plan plan;
  final Gym gym;

  const ShoppingPage({Key key, this.plan, this.gym}) : super(key: key);
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  bool _isAdded = false;
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of(context);
    SubscriptionModel subscriptionModel = Provider.of(context);
    subscriptionModel.subscripcion.price =
        widget.plan != null ? widget.plan.price : widget.gym.price;
    subscriptionModel.subscripcion.plan =
        widget.plan != null ? widget.plan.plan : 'Sin Plan';
    subscriptionModel.subscripcion.idUser = userModel.getUser().userId;
    subscriptionModel.subscripcion.nameUser = userModel.getUser().fullName;
    subscriptionModel.subscripcion.igGym =
        widget.plan != null ? '' : widget.gym.gymId;
    subscriptionModel.subscripcion.nameGym =
        widget.plan != null ? '' : widget.gym.name;

    return Scaffold(
      appBar: AppBar(
        title: Text('Suscripción'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Pago',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(
                height: 32,
              ),
              Container(
                height: 0.5,
                color: Colors.black26,
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: StylesText.textBlack16w700,
                  ),
                  Text(
                    '${subscriptionModel.subscripcion.price} Bs',
                    style: StylesText.textBlack5416w700,
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.plan != null ? 'Plan' : 'Gimnasio',
                    style: StylesText.textBlack16w700,
                  ),
                  Text(
                    widget.plan != null
                        ? '${widget.plan.plan}'
                        : '${widget.gym.name}',
                    style: StylesText.textBlack5416w700,
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Tiempo de Suscripción',
                    style: StylesText.textBlack16w700,
                  ),
                  Text(
                    '1 mes',
                    style: StylesText.textBlack5416w700,
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Fecha de Inicio',
                    style: StylesText.textBlack16w700,
                  ),
                  GestureDetector(
                    onTap: () async {
                      DateTime selectedDate = await showDatePicker(
                        context: context,
                        initialDate:
                            subscriptionModel.subscripcion.initSubscription,
                        firstDate: DateTime(2018),
                        lastDate: DateTime(2030),
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.light(),
                            child: child,
                          );
                        },
                      );
                      if (selectedDate != null) {
                        subscriptionModel.initSubscription(selectedDate);
                        subscriptionModel.finalSubscription(
                            selectedDate.add(Duration(hours: 30 * 24)));
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 0.5,
                                color: Theme.of(context).accentColor)),
                        child: Text(
                            '${subscriptionModel.subscripcion.initSubscription.day.toString().padLeft(2, '0')}/${subscriptionModel.subscripcion.initSubscription.month.toString().padLeft(2, '0')}/${subscriptionModel.subscripcion.initSubscription.year.toString()}')),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Fecha de Conlusión',
                    style: StylesText.textBlack16w700,
                  ),
                  Container(
                      child: Text(
                          '${subscriptionModel.subscripcion.finalSubscription.day.toString().padLeft(2, '0')}/${subscriptionModel.subscripcion.finalSubscription.month.toString().padLeft(2, '0')}/${subscriptionModel.subscripcion.finalSubscription.year.toString()}')),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                height: 0.5,
                color: Colors.black26,
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 600),
                        curve: Curves.easeIn,
                        opacity: _isAdded ? 0.0 : 1.0,
                        child: ButtonNextGym(
                          color: Colors.blue,
                          splashColor: Colors.white10,
                          radius: 30,
                          onTap: () async {
                            try {
                              setState(() {
                                _isAdded = true;
                              });
                              await subscriptionModel.addSubscription();
                              Navigator.pop(context);
                            } catch (e) {
                              print('error $e');

                              setState(() {
                                _isAdded = false;
                              });
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Pagar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                            ],
                          ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 550),
                          opacity: _isAdded ? 1.0 : 0.0,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ],
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
