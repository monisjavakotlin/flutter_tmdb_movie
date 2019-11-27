import 'package:flutter/material.dart';

import '../models/upcoming_model.dart';

class UpcomingPosterShow extends StatefulWidget {
  final Results results;
  final String apikey;
  final String imageURL;
  final String baseURL;
  final String size;

  UpcomingPosterShow(
      {this.results, this.apikey, this.imageURL, this.baseURL, this.size});

  @override
  _UpcomingPosterShowState createState() => _UpcomingPosterShowState();
}

class _UpcomingPosterShowState extends State<UpcomingPosterShow> {
  @override
  void initState() {
    super.initState();
    print(widget.results);
    print(widget.apikey);
    print(widget.imageURL);
    print(widget.baseURL);
    print(widget.size);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            /*child: Hero(
              tag:
                  '${widget.imageURL}${widget.size}${widget.results.posterPath}?api_key=${widget.apikey}',
            ),*/
            height: MediaQuery.of(context).size.height / 1.0,
            width: MediaQuery.of(context).size.width / 1.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: NetworkImage(
                    '${widget.imageURL}${widget.size}${widget.results.posterPath}?api_key=${widget.apikey}'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
