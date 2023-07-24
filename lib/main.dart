
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_understanding/offices.dart';

void main() => runApp(MyApp()) ;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Networking',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<OfficesList> officesList;

  @override
  void initState() {
    super.initState();
    officesList = getOfficesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Networking JSON'),
        centerTitle: true,
      ),
      body: FutureBuilder<OfficesList>(
        future: officesList,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.offices.length,
              itemBuilder: (context, index) {
                return Card(
                child: ListTile(
                  title: Text('${snapshot.data!.offices[index].name}'),
                  subtitle: Text('${snapshot.data!.offices[index].address}'),
                  leading: Image.network('${snapshot.data!.offices[index].image}'),
                  isThreeLine: true,
                ),
                );
              },
            );
          }else if(snapshot.hasError){
            return Text('ERROR');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
