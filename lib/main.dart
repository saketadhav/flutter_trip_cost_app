import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trip Cost Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FuelFormState();

}

class _FuelFormState extends State<FuelForm>{

  final double _formDistance = 5.0;
  
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
  String _currency = 'Dollars';
  TextEditingController distanceController = new TextEditingController();
  TextEditingController avgController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  String result = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Cost Calculator"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: TextField(
              controller: distanceController,
              decoration: InputDecoration(
                labelText: "Distance",
                hintText: "e.g. In Kms",
                labelStyle: textstyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
              keyboardType: TextInputType.number
            )
            ),
            Padding(
              padding: EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child:TextField(
              controller: avgController,
              decoration: InputDecoration(
                labelText: "Distance per Unit",
                hintText: "e.g. Kms/litre",
                labelStyle: textstyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
              keyboardType: TextInputType.number
            )
            ),
            Padding(
              padding: EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child:Row(
                children: <Widget>[
              Expanded(
              child: TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: "Price of fuel",
                hintText: "e.g Dollars/litre",
                labelStyle: textstyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
              keyboardType: TextInputType.number
            )
            ),
            Container(width: _formDistance * 5),
            Expanded(
            child: DropdownButton<String>(
              items: _currencies.map((String itemValue){
                return DropdownMenuItem<String>(
                  value: itemValue,
                  child: Text(itemValue),
                );
              }
              ).toList(), 
              value: _currency,
              onChanged: (String value) {
                _onDropdownChanged(value);
              },
            )
            )
            ],
            )
            ),
            Row(
              children: <Widget>[
              
              Expanded(
                child:RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  'Submit',
                  textScaleFactor: 1.5,
                ),
                onPressed: (){
                  setState(() {
                    result = _calculate();
                  });
                },
              )
              ),
              Expanded(
              child:RaisedButton(
                color: Theme.of(context).buttonColor,
                textColor: Theme.of(context).primaryColorDark,
                child: Text(
                  'Reset',
                  textScaleFactor: 1.5,
                ),
                onPressed: (){
                  _reset();
                },
              )
              )
              ],
            ),
            Text(result)
          ],
        ),
      ),
    );
  }

  _onDropdownChanged(String selectedValue){
    setState(() {
     this._currency = selectedValue; 
    });
  }

  String _calculate(){
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalCost = _distance / _consumption * _fuelCost;
    return "The total cost of your trip is " + _totalCost.toStringAsFixed(2) + " " + _currency;
  }

  _reset(){
    distanceController.text = "";
    avgController.text = "";
    priceController.text = "";
    setState(() {
     result = ""; 
    });
  }

}