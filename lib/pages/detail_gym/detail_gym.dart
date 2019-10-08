import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:gym_go/model/gym.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:gym_go/pages/detail_gym/information.dart';
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
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });

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
                    animationDuration: Duration(milliseconds: 1500),
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
                  Text(
                    widget.gym.name,
                    style: StylesText.textBlack20w500,
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
                  Text(
                    '${widget.gym.zone}, ${widget.gym.streetOrAvenue}',
                    style: StylesText.textSubtitleRegGym,
                  )
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
          ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: _changecolor ? 46 : 0),
                height: 50,
                child: Text('index1'),
              ),
              Container(
                height: 50,
                child: Text('index1'),
              ),
              Container(
                height: 50,
                child: Text('index1'),
              ),
              Container(
                height: 50,
                child: Text('index1'),
              ),
              Container(
                height: 50,
                child: Text('index1'),
              ),
              Container(
                height: 50,
                child: Text('index1'),
              ),
              Container(
                height: 50,
                child: Text('index1'),
              ),
              Container(
                height: 50,
                child: Text('index1'),
              ),
              Container(
                height: 50,
                child: Text('index1'),
              ),
            ],
          ),
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
