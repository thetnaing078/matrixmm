import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matrixmm/models/product.dart';

import '../api_service.dart';

class WidgetHomeProducts extends StatefulWidget {
  WidgetHomeProducts({Key key, this.labelName, this.tagId}) : super(key: key);
  String labelName;
  String tagId;

  @override
  _WidgetHomeProductsState createState() => _WidgetHomeProductsState();
}

class _WidgetHomeProductsState extends State<WidgetHomeProducts> {
  APIService apiService;

  @override
  void initState() {
    apiService = new APIService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffcfd8dc),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  this.widget.labelName,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent[700]),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4),
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
          _productsList(),
        ],
      ),
    );
  }

  Widget _productsList() {
    return new FutureBuilder(
      future: apiService.getProducts(tagName: this.widget.tagId),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> model) {
        if (model.hasData) {
          return _buildList(model.data);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildList(List<Product> items) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          var data = items[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                width: 130,
                height: 120,
                alignment: Alignment.center,
                child: Image.network(
                  data.images[0].src,
                  height: 120,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 15,
                    )
                  ],
                ),
              ),
              Container(
                width: 130,
                alignment: Alignment.centerLeft,
                child: Text(
                  data.name,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4, left: 4),
                width: 130,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      '${data.regularPrice}Ks',
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${data.salePrice}Ks',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
