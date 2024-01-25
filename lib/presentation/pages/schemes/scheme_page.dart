import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:readmock/config/size_config.dart';
import 'package:readmock/presentation/pages/schemes/scheme_screen.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';

class Schemepage extends StatelessWidget {
  const Schemepage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text("Schemes"),
      ),
      body: _buildSchemesCards(),
    );
  }

  Widget _buildSchemesCards() {
    // Dummy list of schemes
    List<Map<String, String>> schemes = [
      {
        "title": "Green Steel Initiative",
        "description":
            "A sustainability-driven scheme focused on transitioning to eco-friendly production methods, reducing carbon emissions, and implementing renewable energy sources to create green steel. This initiative aligns with global environmental goals and positions the company as a leader in sustainable steel production.",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4Ns0R3snMGT-yIqQM-Xik4e2MD32H4iSDfeyX3WcMU3igxN4-pl5cN1-dq3SZkOAW5mg&usqp=CAU"
      },
      {
        "title": "Smart Manufacturing Transformation",
        "description":
            "An Industry 4.0 initiative aimed at incorporating advanced technologies, such as IoT sensors, artificial intelligence, and data analytics, to optimize the manufacturing process. The scheme enhances efficiency, minimizes downtime, and improves overall operational productivity.",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7hSm5E4N9jl98NaGgEy5wEnLkPChRy4Vyog&usqp=CAU"
      },
      {
        "title": "Steel Education and Training Program",
        "description":
            "A community-focused scheme that invests in education and training programs for local communities. This initiative aims to empower individuals with relevant skills for employment in the steel industry, fostering economic development and strengthening ties with the community.",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9V-MzpTMZ63pERB7Q4zd-lxkEhWjZxKQCKw&usqp=CAU"
      },
      {
        "title": "Circular Economy Integration",
        "description":
            "A scheme dedicated to implementing circular economy principles within the company's operations. This includes recycling and reusing materials, reducing waste, and developing a closed-loop system to promote sustainable resource management.",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSslU5Q2filkbmR-Sjaip0YjXNRVOx7FhDow&usqp=CAU"
      },
      {
        "title": "Safety First Campaign",
        "description":
            "A comprehensive safety initiative aimed at creating a secure working environment for employees. This scheme includes regular safety training, implementation of safety protocols, and the use of advanced safety technologies to prevent accidents and ensure employee well-being.",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdujwh_aX5lFRekdOlt6WIEOHrHKXsB6aPFg&usqp=CAU"
      },
      {
        "title": "Global Expansion Strategy",
        "description":
            "An internationalization scheme focused on expanding the company's presence in key global markets. This initiative involves strategic partnerships, acquisitions, and market research to ensure sustainable growth and competitiveness on a global scale.",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdujwh_aX5lFRekdOlt6WIEOHrHKXsB6aPFg&usqp=CAU"
      }
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.6

          // Set the height of each card
          ),
      itemCount: schemes.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SchemeDetailsScreen(
                      schemeDetails: schemes[index],
                    )));
          },
          child: Hero(
            tag: schemes[index]['title']!,
            child: Card(
              child: Container(
                width: 160, // Fixed width for each card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      schemes[index]['image']!,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(schemes[index]['title']!,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        schemes[index]['description']!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
