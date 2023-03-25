import 'package:flutter/material.dart';
import 'package:app/model/venue.dart';
import 'package:app/view/pages/map_page.dart';

class VenuePage extends StatefulWidget {
  const VenuePage({Key? key}) : super(key: key);

  @override
  State<VenuePage> createState() => _VenuePageState();
}

class _VenuePageState extends State<VenuePage> {

  Venue venue = Venue(id: 0, name: 'Estadio do Dragao', address: 'Via Futebol Clube do Porto', city: 'Porto', capacity: 50033, surface: 'n sei', image: 'assets/estadiodragao.jpeg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text('Estádio',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      centerTitle: true,
      elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                venue.name,
              style: TextStyle(
                color: Colors.green[700],
                letterSpacing: 1.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0,),
            CircleAvatar(
              backgroundImage: AssetImage(venue.image),
              radius: 80.0,
            ),
            SizedBox(height: 10.0,),
            Text(
              "Endereço: ${venue.address}\nCidade: ${venue.city}\nCapacidade: ${venue.capacity}",
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: MapPage(),
                width: 1000.0,
                height: 400.0,
            ),
          ],
        ),
      ),
    );
  }
}
