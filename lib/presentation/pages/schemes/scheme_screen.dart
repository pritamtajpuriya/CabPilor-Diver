import 'package:flutter/material.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';

class SchemeDetailsScreen extends StatelessWidget {
  final Map<String, String> schemeDetails;

  SchemeDetailsScreen({Key? key, required this.schemeDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(schemeDetails['title']!),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: schemeDetails['title']!,
              child: Image.network(
                schemeDetails['image']!,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    schemeDetails['title']!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    schemeDetails['description']!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Benefits:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '''

- Reduced carbon emissions.
- Enhanced environmental sustainability.
- Alignment with global green energy goals.
- Increased market competitiveness through eco-friendly practices.

''',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
