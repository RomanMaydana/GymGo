import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:gym_go/class/var_globales.dart';
import 'package:gym_go/model/gym.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:gym_go/pages/detail_gym/information.dart';
import 'package:gym_go/pages/detail_gym/reviews.dart';
import 'package:gym_go/style/text.dart';
import 'package:gym_go/widget/stars.dart';

final double sizeIconStar = 16;
final Color colorIconStar = Color(0xffFFDB5C);

class DetailGym extends StatefulWidget {
  final Gym gym;

  const DetailGym({Key key, this.gym}) : super(key: key);

  @override
  _DetailGymState createState() => _DetailGymState();
}

class _DetailGymState extends State<DetailGym> with TickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController; // To control switching tabs
  ScrollController _scrollViewController; // To control scrolling

  List<String> items = [];
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.blue,
    Colors.amber,
    Colors.cyan,
    Colors.pink
  ];
  Random random = new Random();

  Color getRandomColor() {
    return colors.elementAt(random.nextInt(colors.length));
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
    // ..addListener(() {
    //   setState(() {});
    // });

    super.initState();
  }

  bool get _changecolor {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 100; i++) {
      items.add('Item $i');
    }
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            title: Text(
              widget.gym.name,
              style: TextStyle(
                color: _changecolor ? Colors.black : Colors.transparent,
              ),
            ),
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: SizedBox(
                child: Carousel(
                    // boxFit: BoxFit.fill,
                    // animationDuration: Duration(milliseconds: 1500),
                    autoplay: false,
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.white,
                    indicatorBgPadding: 20.0,
                    dotBgColor: Colors.transparent,
                    borderRadius: true,
                    images: widget.gym.picture
                        .map((pic) => Image.network(
                              pic.url,
                              fit: BoxFit.cover,
                            ))
                        .toList()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.gym.name,
                        style: StylesText.textBlack20w500,
                      ),
                      Text(
                        '${widget.gym.price.toString()} Bs',
                        style: StylesText.textBlue20w600,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        widget.gym.rating.toString(),
                        style: StylesText.textSubtitleRegGym,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      _buildStar(widget.gym.rating),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${widget.gym.zone}, ${widget.gym.streetOrAvenue}',
                          style: StylesText.textSubtitleRegGym,
                        ),
                      ),
                      widget.gym.statePlan
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '${widget.gym.plan}',
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
                              '${widget.gym.plan}',
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
                        )                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  for (Schedule schedule in widget.gym.schedule)
              _buildScheduleConfig(schedule),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            // floating: true,
            pinned: true,
            delegate: SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: 'Información',
                  ),
                  Tab(
                    text: 'Reseñas',
                  ),
                ],
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Information(
            gym: widget.gym,
          ),
          Reviews(
            gym: widget.gym
          )
        ],
      ),
    );

    CustomScrollView(
      slivers: <Widget>[
        SliverList(delegate: new SliverChildListDelegate(_buildList(50))),
      ],
    );
  }

  List _buildList(int count) {
    List<Widget> listItems = List();

    for (int i = 0; i < count; i++) {
      listItems.add(new Padding(
          padding: new EdgeInsets.all(20.0),
          child: new Text('Item ${i.toString()}',
              style: new TextStyle(fontSize: 25.0))));
    }

    return listItems;
  }

  _buildStar(double rating) {
    return Stars(
      color: colorIconStar,
      rating: rating,
      sizeIcon: sizeIconStar,
    );
  }
  
  Widget _buildScheduleConfig(Schedule schedule) {
    int index = widget.gym.schedule.indexOf(schedule);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            for (var day in VarGlobales.day) _buildCheckDay(day, index),
            SizedBox(
              width: 8,
            ),
            Text(
                '${schedule.hourIn.hour.toString().padLeft(2, '0')}:${schedule.hourIn.minute.toString().padLeft(2, '0')} - ${schedule.hourOut.hour.toString().padLeft(2, '0')}:${schedule.hourOut.minute.toString().padLeft(2, '0')}'),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        
        
      ],
    );
  }

  Widget _buildCheckDay(String day, int index) {
    final alreadySaved = widget.gym.schedule[index].day.contains(day);

    return Tooltip(
      message: day,
      verticalOffset: 30,
      height: 24,
      child: Material(
        color: Colors.white,
        child: Container(
            padding: const EdgeInsets.all(4.0),
            height: 25,
            alignment: Alignment.center,
            child: Center(
              child: Text(
                '${day[0].toUpperCase()}',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: alreadySaved ? Colors.green : Colors.black26),
              ),
            )),
      ),
    );
  }

}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  SliverAppBarDelegate(this._tabBar);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
