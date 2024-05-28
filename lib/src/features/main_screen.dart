import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController zipController = TextEditingController();
  Future<String>? cityFuture;

  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: zipController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Postleitzahl"),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    cityFuture = getCityFromZip(zipController.text);
                  });
                },
                child: const Text("Suche"),
              ),
              const SizedBox(height: 32),
              FutureBuilder<String>(
                future: cityFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Fehler: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Text('Ergebnis: ${snapshot.data}',
                        style: Theme.of(context).textTheme.labelLarge);
                  } else {
                    return Text('Ergebnis: Noch keine PLZ gesucht',
                        style: Theme.of(context).textTheme.labelLarge);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    zipController.dispose();
    super.dispose();
  }

  Future<String> getCityFromZip(String zip) async {
    await Future.delayed(const Duration(seconds: 3));

    switch (zip) {
      case "13156":
      case "13403":
        return 'Berlin';
      case "20075":
        return 'Hamburg';
      case "80530":
        return 'München';
      case "50777":
        return 'Köln';
      case "60430":
      case "60313":
        return 'Frankfurt am Main';
        case "":
        return "Bitte plz Eingeben";
      default:
        return 'Unbekannte Stadt';
      
    }
  }
}
