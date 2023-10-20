class ProductModel {
  String? categoty;
  String? date;
  String? description;
  String? id;
  String? img;
  double? price;
  String? productid;
  String? productname;
  String? sale;
  num? timestamp;

  ProductModel(
      {this.categoty,
        this.date,
        this.description,
        this.id,
        this.img,
        this.price,
        this.productid,
        this.productname,
        this.sale,
        this.timestamp});

  ProductModel.fromJson(Map<String, dynamic> json) {
    categoty = json['categoty'];
    date = json['date'];
    description = json['description'];
    id = json['id'];
    img = json['img'];
    price = double.parse(json['price'].toString());
    productid = json['productid'];
    productname = json['productname'];
    sale = json['sale'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoty'] = this.categoty;
    data['date'] = this.date;
    data['description'] = this.description;
    data['id'] = this.id;
    data['img'] = this.img;
    data['price'] = this.price;
    data['productid'] = this.productid;
    data['productname'] = this.productname;
    data['sale'] = this.sale;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
