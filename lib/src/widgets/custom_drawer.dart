import 'dart:io';

import 'package:drug_dictionary/config/size_config.dart';
import 'package:drug_dictionary/src/screens/favourite_drugs.dart';
import 'package:drug_dictionary/src/screens/history_list.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    _showAbout() {
      return showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext, Animation animation,
              Animation secondaryAnimation) {
            return Center(
              child: Container(
                width: SizeConfig.screenWidth - 30,
                height: SizeConfig.screenHeight - 70,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      color: Theme.of(context).primaryColor,
                      height: (SizeConfig.screenHeight - 10) / 3,
                      child: Column(
                        children: <Widget>[],
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).accentColor,
                    )
                  ],
                ),
              ),
            );
          });
    }

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Drug Dictinary - Pharmacy Helper',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            accountEmail: Text("Version 1.0.0"),
            currentAccountPicture:
                Image(image: AssetImage('assets/icons/dictionary.png')),
          ),
          ListTile(
            title: Text('Favourites'),
            leading: Icon(Icons.favorite),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavouriteDrugs(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('History'),
            leading: Icon(Icons.history),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryDrugs(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('About'),
            leading: Icon(Icons.info),
            onTap: _showAbout,
          ),
          Divider(
            height: 10.0,
          ),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => exit(0),
          ),
        ],
      ),
    );
  }
}
