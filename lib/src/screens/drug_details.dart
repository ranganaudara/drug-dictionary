import 'package:drug_dictionary/config/size_config.dart';
import 'package:drug_dictionary/src/models/drug_model.dart';
import 'package:drug_dictionary/utils/database_helper.dart';
import 'package:flutter/material.dart';

class DrugDetails extends StatefulWidget {
  final drugName;
  DrugDetails({this.drugName});

  @override
  _DrugDetailsState createState() => _DrugDetailsState();
}

class _DrugDetailsState extends State<DrugDetails> {
  bool isFavourite = false;
  DatabaseHelper db = DatabaseHelper();
  Drug _drug;

  _checkIsFavourite() async {
    if (_drug.favourite > 0) {
      setState(() {
        isFavourite = true;
      });
    }
  }

  _getDetails() async {
    var res = await db.getDrugDetails(widget.drugName);
    setState(() {
      _drug = res;
    });
    _checkIsFavourite();
  }

  @override
  void initState() {
    _getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Widget _detailsList(Drug d) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                elevation: 3.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      "Maximum Daily Dosage",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      d.maxDose.toString() + " mg",
                      style: Theme.of(context).textTheme.body2,
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              Card(
                elevation: 3.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      "When to take",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      d.whenToTake.toString() + " Meal",
                      style: Theme.of(context).textTheme.body2,
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              Card(
                elevation: 3.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      "Interactions",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      d.interactions.toString(),
                      style: Theme.of(context).textTheme.body2,
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              Card(
                elevation: 3.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      "Instructions",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      d.instructions.toString(),
                      style: Theme.of(context).textTheme.body2,
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.drugName,
                  style: Theme.of(context).textTheme.title,
                ),
                IconButton(
                    icon: Icon(
                      isFavourite ? Icons.star : Icons.star_border,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      db.updateFavourites(widget.drugName);
                      setState(() {
                        isFavourite = !isFavourite;
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
      body: _detailsList(_drug),
    );
  }
}
