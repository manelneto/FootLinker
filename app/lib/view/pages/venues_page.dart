import 'package:app/view/widgets/venue_widget.dart';
import 'package:flutter/material.dart';
import '../../model/team.dart';
import '../../controller/team_fetcher.dart';

class VenuesPage extends StatefulWidget {
  const VenuesPage({super.key});

  @override
  State<VenuesPage> createState() => _VenuesPageState();
}

class _VenuesPageState extends State<VenuesPage> {
  late Future<Team> futureTeam;

  @override
  void initState() {
    super.initState();
    futureTeam = TeamFetcher().fetchTeam();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text('Estádios',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: TextField(
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            hintText: 'Pesquise um estádio',
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}










/*
ListView(
children: [
const Center(child: Text('Estádio Pesquisado:')),
FutureBuilder<Team>(
future: futureTeam,
builder: (context, snapshot) {
if (snapshot.hasData) {
return VenueWidget(venue: snapshot.data!.venue);
} else if (snapshot.hasError) {
return Text('${snapshot.error}');
}
return const CircularProgressIndicator();
},
),
],
),*/