import 'package:flutter/material.dart';
import '../../model/team.dart';
import '../../controller/team_fetcher.dart';
import '../../model/venue.dart';
import 'package:app/view/pages/venue_page.dart';

class VenuesPage extends StatefulWidget {
  const VenuesPage({super.key});

  @override
  State<VenuesPage> createState() => _VenuesPageState();
}

class _VenuesPageState extends State<VenuesPage> {
  late Future<Team> futureTeam;

  static List<Venue> main_venue_list = [
    Venue(id: 0, name: 'Estadio do Dragao', address: 'Via Futebol Clube do Porto', city: 'Porto', capacity: 50033, surface: 'n sei', image: 'assets/estadiodragao.jpeg', lat: 41.16177, lng: -8.5857797),
    Venue(id: 1, name: 'Maracana', address: 'Rua Professor Eurico Rabelo', city: 'Rio de Janeiro', capacity: 78838, surface: 'n sei', image: 'assets/maracana.jpeg', lat: -22.9121089, lng: -43.2323445),
  ];

  List<Venue> display_list = List.from(main_venue_list);

  void updateList(String value) {
    setState(() {
      display_list = main_venue_list.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

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
        child: Column(
          children: [
            TextField(
              onChanged: (value) => updateList(value),
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
            SizedBox(height:20.0,),
            Expanded(
                child: ListView.builder(
                  itemCount: display_list.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VenuePage(display_list[index])));
                    },
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(
                        display_list[index].name,
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(display_list[index].address),
                  ),
                ),
            ),
          ],
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