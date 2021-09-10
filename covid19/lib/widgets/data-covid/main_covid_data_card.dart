import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttercovid19/models/data-covid/covid.dart';
import 'package:fluttercovid19/widgets/data-covid/card_covid_data_detail.dart';
import 'package:fluttercovid19/widgets/shared/pill_widget.dart';
import 'package:fluttercovid19/widgets/shared/roundend_card.dart';
import 'package:fluttercovid19/widgets/shared/show_bottom_scheet.dart';

class DataCovidCard extends StatefulWidget {
  DataCovidCard(
      {Key? key,
      required this.color,
      required this.dataCovid,
      required this.viewDetail})
      : super(key: key);
  final Color color;
  final DataCovid dataCovid;
  ViewCovidCardDetail viewDetail;

  @override
  _DataCovidCardState createState() => _DataCovidCardState();
}

class _DataCovidCardState extends State<DataCovidCard> {
  @override
  Widget build(BuildContext context) {
    var dataLayout = MediaQuery.of(context);
    var date = formatDate(
      DateTime.parse(widget.dataCovid.data),
      [dd, ' ', MM, ' ', yyyy],
      locale: ItalianDateLocale(),
    );
    return Container(
      margin: EdgeInsets.all(20),
      child: RoundedCard(
        backgroundColor: Theme.of(context).primaryColor,
        content: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: PillWidget(
                    text: date,
                    color: Theme.of(context).secondaryHeaderColor,
                    colorText: Colors.white,
                    internalPadding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      right: 25,
                      left: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            CardDetailData(
              data: this
                  .widget
                  .dataCovid
                  .nuovi_positivi
                  .toString()
                  .replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},'),
              title: 'Contagiati Oggi',
              backgroundColor: Theme.of(context).primaryColor,
              margin: EdgeInsets.all(10),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                GestureDetector(
                  onTap: () {
                    /*setState(() {
                      if (widget.viewDetail == ViewCovidCardDetail.view) {
                        widget.viewDetail = ViewCovidCardDetail.notView;
                      } else {
                        widget.viewDetail = ViewCovidCardDetail.view;
                      }
                    });*/
                  },
                  child: PillWidget(
                    text: '...',
                    textSize: 30,
                    color: Colors.transparent,
                    colorText: Colors.white,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            widget.viewDetail == ViewCovidCardDetail.view
                ? detailCard(
                    context: context, dataLayout: dataLayout, date: date)
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget detailCard(
      {required BuildContext context,
      required MediaQueryData dataLayout,
      required String date}) {
    return Column(
      children: [
        CardDetailData(
            data: this
                .widget
                .dataCovid
                .terapia_intensiva
                .toString()
                .replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]},'),
            title: 'Terapia Intensiva'),
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PillWidget(
                actions: () => bottomScheetcontent(
                  context: context,
                  date: date,
                  dataLayout: dataLayout,
                ),
                text: 'view more...',
                color: Theme.of(context).secondaryHeaderColor,
                colorText: Colors.white,
                internalPadding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 25,
                  left: 25,
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ],
    );
  }

  bottomScheetcontent({
    required String date,
    required BuildContext context,
    required MediaQueryData dataLayout,
  }) {
    BottomScheet.show(
      color: Color.fromRGBO(225, 190, 231, 1).withOpacity(0.7),
      context: context,
      widget: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: PillWidget(
                    text: date,
                    color: Theme.of(context).secondaryHeaderColor,
                    colorText: Colors.white,
                    internalPadding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      right: 25,
                      left: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            CardDetailData(
              data: this
                  .widget
                  .dataCovid
                  .ricoverati_con_sintomi
                  .toString()
                  .replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},'),
              title: 'Ricoverati Con Sintomi',
            ),
            CardDetailData(
              data: this.widget.dataCovid.deceduti.toString().replaceAllMapped(
                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]},'),
              title: 'Deceduti',
            ),
            CardDetailData(
              data: this.widget.dataCovid.tamponi.toString().replaceAllMapped(
                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]},'),
              title: 'Tamponi Giornalieri',
            ),
            CardDetailData(
              title: 'Dimessi Guariti',
              data: this
                  .widget
                  .dataCovid
                  .dimessi_guariti
                  .toString()
                  .replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},'),
            ),
          ],
        ),
      ),
    );
  }
}

enum ViewCovidCardDetail { view, notView }
