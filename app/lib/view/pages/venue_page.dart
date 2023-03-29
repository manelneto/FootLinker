import 'package:flutter/material.dart';
import 'package:app/model/venue.dart';
import 'package:app/view/pages/map_page.dart';

class VenuePage extends StatefulWidget {
  const VenuePage({
    super.key,
    required this.venue,
  });

  final Venue venue;

  @override
  State<VenuePage> createState() => _VenuePageState();
}

class _VenuePageState extends State<VenuePage> {

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
        padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                widget.venue.name.toUpperCase(),
              style: TextStyle(
                color: Colors.green[700],
                letterSpacing: 1.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0,),
            CircleAvatar(
              backgroundImage: AssetImage(widget.venue.image),
              radius: 80.0,
            ),
            SizedBox(height: 10.0,),
            Text(
              "Endereço: ${widget.venue.address}\nCidade: ${widget.venue.city}\nCapacidade: ${widget.venue.capacity}",
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
                fontSize: 16.0
              ),
            ),
            /*Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: MapPage(widget.venue.lat, widget.venue.lng),
                height: 400.0,
            ),*/
          ],
        ),
      ),
    );
  }
}
