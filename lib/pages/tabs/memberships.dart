import 'package:flutter/material.dart';
import 'package:gym_go/class/shopping_page.dart';
import 'package:gym_go/model/plan.dart';
import 'package:gym_go/model/plan_model.dart';
import 'package:gym_go/pages/list_of_gym_by_plan.dart';
import 'package:gym_go/widget/car_list_pla.dart';
import 'package:provider/provider.dart';

class Memberships extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlanModel planModel = Provider.of(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Planes Disponibles',
              style: Theme.of(context).appBarTheme.textTheme.title,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
                'GymGo te ofrece los siguientes planes. Elige entre los planes que tiene a disposición y selecciona el que mejor se adapte a tus necesidades.'),
            SizedBox(
              height: 32,
            ),
            for (Plan plan in planModel.listPlan)
              Container(
                margin: EdgeInsets.only(bottom: 32),
                child: CardListPlan(
                  height: 300,
                  plan: plan,
                  toBuy: () {
                    Navigator.pushNamed(context, '/shopping',
                        arguments: ShoppingPageArguments(plan: plan));
                  },
                  seeGyms: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ListOfGymByPlan(
                              plan: plan.plan,
                            )));
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
