import 'package:flutter/material.dart';
import 'package:gym_go/class/detail_gym_page_arguments.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/widget/stars.dart';

final double sizeIconStar = 16;
final Color colorIconStar = Color(0xffFFDB5C);

class CardListGym extends StatelessWidget {
  final Gym gym;

  const CardListGym({Key key, @required this.gym}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detailgym',
            arguments: DetailGymPageArguments(gym));
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                offset: Offset(5, 5),
                spreadRadius: 2,
              )
            ],
            color: Colors.white),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                            gym.picture[0].url,
                          ),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color:
                                Theme.of(context).accentColor.withOpacity(0.2)),
                        child: Text(
                          gym.name,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Stars(
                        color: colorIconStar,
                        rating: gym.rating,
                        sizeIcon: sizeIconStar,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  width: 0.5,
                  height: 60,
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  '\nBs ${gym.price.toString()}\nmes',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 1,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(50)),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${gym.zone}, ${gym.streetOrAvenue}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                gym.statePlan
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            gym.plan,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Theme.of(context).accentColor,
                            size: 20,
                          )
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Sin Plan',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.close,
                            color: Theme.of(context).accentColor,
                            size: 20,
                          )
                        ],
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
