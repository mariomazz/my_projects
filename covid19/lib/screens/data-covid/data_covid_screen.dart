import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:fluttercovid19/models/data-covid/covid.dart';
import 'package:fluttercovid19/services/data-covid/service_covid.dart';
import 'package:fluttercovid19/widgets/data-covid/main_covid_data_card.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class DataCovidScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response<List<DataCovid>>>(
      future: Provider.of<ServiceDataCovid>(context).getDataCovid(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<DataCovid> dataCovid =
              new List.from(snapshot.data!.body!.reversed);
          return BuildPage(dataCovid: dataCovid);
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xff000000),
                valueColor: AlwaysStoppedAnimation(
                  Color(0xfffd7013),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class BuildPage extends StatefulWidget {
  BuildPage({required this.dataCovid});
  List<DataCovid> dataCovid;
  @override
  State<StatefulWidget> createState() => BuildPageState();
}

class BuildPageState extends State<BuildPage> {
  final pageController = PageController();

  int index = 0;
  @override
  void initState() {
    super.initState();
    pageController.addListener(
      () => setState(() {
        index = pageController.page!.round();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var dataLayout = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'data covid',
          style: TextStyle(
            color: Colors.white,
            fontSize: ((30 * dataLayout.size.width) / 426 < 52)
                ? (30 * dataLayout.size.width) / 426
                : 52,
          ),
        ),
        backgroundColor: Color.fromRGBO(175, 142, 181, 1),
      ),
      body: LiquidPullToRefresh(
        color: Color.fromRGBO(175, 142, 181, 1),
        onRefresh: () => refresh(),
        child: buildPageViewHorizontal(widget.dataCovid),
      ),
      floatingActionButton: index > 5
          ? ElevatedButton(
              onPressed: () {
                pageController.jumpTo(1);
              },
              child: Icon(Icons.arrow_circle_up, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                primary: Color.fromRGBO(175, 142, 181, 1), // <-- Button color
                onPrimary: Colors.white, // <-- Splash color
              ),
            )
          : Container(),
    );
  }

  Widget buildPageViewHorizontal(List<DataCovid> dataCovid) {
    var dataLayout = MediaQuery.of(context);

    return PageView.builder(
      controller: pageController,
      itemCount: dataCovid.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (_, i) {
        return Container(
          margin: EdgeInsets.symmetric(
              vertical: (dataLayout.size.height * 5) / 100),
          child: DataCovidCard(
            viewDetail: ViewCovidCardDetail.view,
            color: Theme.of(context).primaryColor,
            dataCovid: dataCovid[i],
          ),
        );
      },
    );
  }

  Future refresh() async {
    setState(() {});
  }
}
