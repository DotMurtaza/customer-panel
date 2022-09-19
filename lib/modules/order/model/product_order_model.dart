import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'product_model.dart';

class OrderedProductModel extends Equatable {
  final int id;
  final int quantity;
  final String orderNumber;
  final String name;
  final String trakignNumber;
  final String orderDate;
  final String orderDeliveryTime;
  final String invoice;
  final String paymentType;
  final double price;
  final String status;
  final String image;
  final List<ProductModel> productList;
  const OrderedProductModel(
      {required this.id,
      required this.quantity,
      required this.orderNumber,
      required this.name,
      required this.trakignNumber,
      required this.orderDate,
      required this.orderDeliveryTime,
      required this.invoice,
      required this.paymentType,
      required this.price,
      required this.status,
      required this.image,
      required this.productList});

  OrderedProductModel copyWith(
      {int? id,
      int? quantity,
      String? orderNumber,
      String? name,
      String? trakignNumber,
      String? orderDate,
      String? orderDeliveryTime,
      String? invoice,
      String? paymentType,
      double? price,
      String? status,
      String? image,
      List<ProductModel>? productList}) {
    return OrderedProductModel(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      orderNumber: orderNumber ?? this.orderNumber,
      name: name ?? this.name,
      trakignNumber: trakignNumber ?? this.trakignNumber,
      orderDate: orderDate ?? this.orderDate,
      orderDeliveryTime: orderDeliveryTime ?? this.orderDeliveryTime,
      invoice: invoice ?? this.invoice,
      paymentType: paymentType ?? this.paymentType,
      price: price ?? this.price,
      status: status ?? this.status,
      image: image ?? this.image,
      productList: productList ?? this.productList,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'quantity': quantity});
    result.addAll({'orderNumber': orderNumber});
    result.addAll({'name': name});
    result.addAll({'trakignNumber': trakignNumber});
    result.addAll({'orderDate': orderDate});
    result.addAll({'orderDeliveryTime': orderDeliveryTime});
    result.addAll({'invoice': invoice});
    result.addAll({'paymentType': paymentType});
    result.addAll({'price': price});
    result.addAll({'status': status});
    result.addAll({'image': image});
    result.addAll({'productList': productList.map((e) => e.toJson()).toList()});

    return result;
  }

  factory OrderedProductModel.fromMap(Map<String, dynamic> map) {
    return OrderedProductModel(
      id: map['id']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      orderNumber: map['orderNumber'] ?? '',
      name: map['name'] ?? '',
      trakignNumber: map['trakignNumber'] ?? '',
      orderDate: map['orderDate'] ?? '',
      orderDeliveryTime: map['orderDeliveryTime'] ?? '',
      invoice: map['invoice'] ?? '',
      paymentType: map['paymentType'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      status: map['status'] ?? '',
      image: map['image'] ?? '',
      productList: map['productList'] != null
          ? (map['productList'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderedProductModel.fromJson(String source) =>
      OrderedProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderedProductModel(id: $id, quantity: $quantity, orderNumber: $orderNumber, name: $name, trakignNumber: $trakignNumber, orderDate: $orderDate, orderDeliveryTime: $orderDeliveryTime, invoice: $invoice, paymentType: $paymentType, price: $price, status: $status, image: $image)';
  }

  @override
  List<Object> get props {
    return [
      id,
      quantity,
      orderNumber,
      name,
      trakignNumber,
      orderDate,
      orderDeliveryTime,
      invoice,
      paymentType,
      price,
      status,
      image,
    ];
  }
}
