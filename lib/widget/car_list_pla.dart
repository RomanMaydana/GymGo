import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_go/model/plan.dart';
import 'package:gym_go/style/plan_style.dart';

class CardListPlan extends StatelessWidget {
  final double height;
  final Plan plan;
  final VoidCallback seeGyms;
  final VoidCallback toBuy;

  const CardListPlan(
      {Key key, this.height = 300, this.plan, this.seeGyms, this.toBuy})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final planStyle = PlanStyle();
    Map type = planStyle.stylePlan(plan.plan);
    return Container(
      height: height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: height,
              width: height,
              padding: EdgeInsets.only(right: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: type['color'],
              ),
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(
                type['direction'],
                height: 50,
                width: 50,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 220,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(5, 5),
                      spreadRadius: 2,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Plan\n${plan.plan}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      IconButton(
                        onPressed: toBuy,
                          icon: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.green,
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text('Accede a ${plan.qty} Gimnasios'),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '${plan.price.toString()} Bs',
                        style: TextStyle(
                            color: Color(0xff4f8acf),
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          'Ver Gyms',
                          style: TextStyle(color: Colors.black26),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                        onPressed: seeGyms,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
