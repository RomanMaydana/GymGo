import 'package:flutter/material.dart';
import 'package:gym_go/class/detail_gym_page_arguments.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/model/gym_model.dart';
import 'package:gym_go/style/text.dart';
import 'package:provider/provider.dart';

class MyGymsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GymModel gymModel = Provider.of(context);
    final linearBlack = Container(
      height: 0.9,
      color: Colors.black12,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Gimnasios'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 16),
                child: Material(
                  color: Color(0xffEBEBF0),
                  borderRadius: BorderRadius.circular(25),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/gymregistration');
                    },
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 10,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Agregar',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 16),
                child: linearBlack,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Mis Gimnasios',
                style: StylesText.textBlack20w700,
              ),
              SizedBox(
                height: 16,
              ),
              for (Gym gym in gymModel.myListGyms)
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/detailgym',
                        arguments: DetailGymPageArguments(gym, false));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(gym.picture[0].url),
                                fit: BoxFit.cover,
                                repeat: ImageRepeat.noRepeat,
                                alignment: Alignment.center,
                              ),
                              borderRadius: BorderRadius.circular(50),
                              border:
                                  Border.all(width: 1, color: Colors.black26)),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          gym.name,
                          style: StylesText.textBlack16w700,
                        )
                      ],
                    ),
                  ),
                ),
              SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
