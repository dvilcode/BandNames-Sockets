import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Band> bandList = [
    Band( id: '1', name: 'Star', votes: 0 ),
    Band( id: '2', name: 'Circle', votes: 0 ),
    Band( id: '3', name: 'Way', votes: 0 ),
    Band( id: '4', name: 'Sion', votes: 0 ),
  ];

  @override
  Widget build( BuildContext context ) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text( 
          'BandNames',
          style: TextStyle(
            color: Colors.black87
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemBuilder: ( BuildContext context, int index ) {
          return _bandTile( bandList[index] );
        },
        itemCount: bandList.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.add ),
        elevation: 1,
        onPressed: _addNewBand,
      ),
    );
  }

  Widget _bandTile( Band band ) {
    return Dismissible(
      key: Key( band.id ),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ){
        // TODO: llamar el borrado en el server.
      },
      background: Container(
        padding: EdgeInsets.only( left: 8.0 ),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: const Text( 
            'Delete Band',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text( band.name.substring( 0,2 )),
          backgroundColor: Colors.blue[100],
        ),
        title: Text( band.name ),
        trailing: Text( 
          band.votes.toString(),
          style: TextStyle(
            fontSize: 20
          )
        ),
        onTap: (){}
      ),
    );
  }

  void _addNewBand() {

    final textController = TextEditingController();

    if( Platform.isAndroid ) {
      showDialog(
        context: context,
        builder: ( context ) {
          return AlertDialog(
            title: const Text( 'New Band Name' ),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                elevation: 5,
                textColor: Colors.blue,
                child: const Text( 'Add' ),
                onPressed: (){
                  _addBandToList( textController.text );
                },
              ),
            ],
          );
        },

      ); 
    }

    showCupertinoDialog(
      context: context, 
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text( 'New band name' ),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text( 'Add' ),
              onPressed: () {
                _addBandToList( textController.text );
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text( 'Dismiss' ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _addBandToList( String name ) {
    if( name.length > 1 ) {
      this.bandList.add( Band( id: DateTime.now().toString(), name: name, votes: 0 ) );
      setState((){});
    }

    Navigator.pop(context);
  }

}