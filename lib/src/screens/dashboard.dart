import 'package:drug_dictionary/src/models/drug_model.dart';
import 'package:drug_dictionary/src/screens/drug_details.dart';
import 'package:drug_dictionary/src/widgets/custom_drawer.dart';
import 'package:drug_dictionary/utils/database_helper.dart';
import 'package:flutter/material.dart';

import 'favourite_drugs.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  DatabaseStatus _dbStatus;

  DatabaseHelper db = DatabaseHelper();

  List<Drug> drugList;

  bool isEntered = false;

  List<String> drugNames = [];
  List<String> filteredList = [];

  void _onSearch(value) {
    setState(() {
      isEntered = true;
      filteredList =
          drugNames.where((item) => item.contains('$value')).toList();
    });
  }

  _getAllDrugs() async {
    try {
      drugList = await db.getAllDrugs();
      for(int i = 0; i < drugList.length; i++){
        print(drugList[i].name);
        drugNames.add(drugList[i].name);
      }

      setState(() {
        filteredList = drugNames;
        _dbStatus = DatabaseStatus.COMPLETE;
      });
    } catch (e) {
      print("Database error occured : " + e);
      setState(() {
        _dbStatus = DatabaseStatus.FAILED;
      });
    }
  }

  @override
  void initState() {
    _dbStatus = DatabaseStatus.LOADING;
    _getAllDrugs();
    super.initState();
  }

  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drug Dictionary"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 8.0),
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Search here...',
                    hintStyle: Theme.of(context).textTheme.caption,
                    suffixIcon: isEntered
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                isEntered = false;
                                filteredList = drugNames;
                              });
                            })
                        : null,
                  ),
                  onChanged: ((value) => _onSearch(value)),
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite), onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavouriteDrugs(),
              ),
            );
          }),
        ],
      ),
      drawer: CustomDrawer(),
      body: _showDrugsList(),
    );
  }

  Widget _showDrugsList() {
    switch (_dbStatus) {
      case DatabaseStatus.LOADING:
        return Center(
          child: CircularProgressIndicator(),
        );
      case DatabaseStatus.COMPLETE:
        return ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(filteredList[index]),
                onTap: () {
                  db.addHistoryItem(filteredList[index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DrugDetails(drugName: filteredList[index]),
                    ),
                  );
                },
              ),
            );
          },
        );
      case DatabaseStatus.FAILED:
        return Center(
          child: Text("Loading from database failed!"),
        );
    }
  }
}

enum DatabaseStatus { LOADING, COMPLETE, FAILED }
