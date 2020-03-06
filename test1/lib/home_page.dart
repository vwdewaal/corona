import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

 

enum corona_classification { idonothavecorona, ihavecorona }
class _HomePageState extends State<HomePage> {
  Position _currentPosition;

  
  
  corona_classification _character = corona_classification.idonothavecorona;
  bool _imill = false;
  bool _ischecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text(
                  "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
            ListTile(
              title: const Text('I do not have COVID-19'),
              leading: Radio(
                value: corona_classification.idonothavecorona,
                groupValue: _character,
                onChanged: (corona_classification value) {
                  setState(() { _character = value; });
                },
              ),
            ),
            ListTile(
              title: const Text('I have been diagnosed with COVID-19'),
              leading: Radio(
                value: corona_classification.ihavecorona,
                groupValue: _character,
                onChanged: (corona_classification value) {
                  setState(() { _character = value; });
                },
              ),
            ),
            CheckboxListTile(
              title: const Text('I have cold or flu symptoms'),
              value: _ischecked,
              onChanged: (val) {setState(() {
                _ischecked = val;
              });}
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}