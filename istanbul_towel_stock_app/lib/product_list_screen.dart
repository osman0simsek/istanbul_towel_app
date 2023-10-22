// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  final _photoController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Listesi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Arama işlemleri burada gerçekleştirilebilir
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddProductOptionsDialog();
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _buildProductListHeader(),
          const Divider(thickness: 2),
          ...products.map((product) => _buildProductListItem(product)).toList(),
        ],
      ),
    );
  }

  Widget _buildProductListHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Fotoğrafı'),
          Text('Barkodu'),
          Text('Ölçüsü'),
          Text('Adeti'),
        ],
      ),
    );
  }

  Widget _buildProductListItem(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(product.photo, width: 50, height: 50),
          Text(product.barcode),
          Text(product.measurement),
          Text(product.quantity.toString()),
        ],
      ),
    );
  }

  void _showAddProductOptionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ürün Ekleme Seçenekleri'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showAddProductDialog();
                },
                child: const Text('Yeni Ürün Ekle'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showAddToExistingProductDialog();
                },
                child: const Text('Mevcut Ürüne Ekle'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yeni Ürün Ekle'),
          content: AddProductForm((newProduct) {
            _addProduct(newProduct);
          }, _photoController),
        );
      },
    );
  }

  void _showAddToExistingProductDialog() {
    // Mevcut ürüne ekleme işlemi için gerekli diyalog penceresi burada oluşturulabilir
  }

  Future<void> _addProduct(Product newProduct) async {
    final user = _auth.currentUser;
    final photoUrl = await _uploadImage(_photoController.text, user?.uid);
    if (photoUrl != null) {
      newProduct.photo = photoUrl;
      setState(() {
        products.add(newProduct);
      });
      Navigator.of(context).pop();
      _saveProductToFirestore(newProduct, user?.uid);
    }
  }

  Future<String?> _uploadImage(String imagePath, String? userId) async {
    final file = File(imagePath);
    if (userId == null) return null;

    try {
      final storage = FirebaseStorage.instance;
      final ref =
          storage.ref().child('product_images/$userId/${DateTime.now()}.jpg');
      await ref.putFile(file);
      final imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Image upload error: $e');
      return null;
    }
  }

  Future<void> _saveProductToFirestore(Product product, String? userId) async {
    if (userId == null) return;
    try {
      final userProductsCollection =
          FirebaseFirestore.instance.collection('users/$userId/products');
      await userProductsCollection.add({
        'photo': product.photo,
        'barcode': product.barcode,
        'name': product.name,
        'measurement': product.measurement,
        'quantity': product.quantity,
      });
    } catch (e) {
      print('Firestore error: $e');
    }
  }
}

class Product {
  late String photo; // Düzenleme burada
  final String barcode;
  final String name;
  final String measurement;
  final int quantity;

  Product({
    required this.photo,
    required this.barcode,
    required this.name,
    required this.measurement,
    required this.quantity,
  });
}

class AddProductForm extends StatefulWidget {
  final Function(Product) onProductAdded;
  final TextEditingController photoController;

  const AddProductForm(this.onProductAdded, this.photoController, {Key? key})
      : super(key: key);

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _measurementController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () async {
            final imageFile = await _pickImage();
            if (imageFile != null) {
              widget.photoController.text = imageFile.path;
              setState(() {});
            }
          },
          child: const Text('Fotoğraf Çek'),
        ),
        if (widget.photoController.text.isNotEmpty)
          Image.file(
            File(widget.photoController.text),
            width: 100,
            height: 100,
          ),
        TextField(
          controller: _barcodeController,
          decoration: const InputDecoration(labelText: 'Ürün Barkodu'),
        ),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Ürün Adı'),
        ),
        TextField(
          controller: _measurementController,
          decoration: const InputDecoration(labelText: 'Ölçüsü'),
        ),
        TextField(
          controller: _quantityController,
          decoration: const InputDecoration(labelText: 'Adeti'),
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          onPressed: () {
            final newProduct = Product(
              photo: widget.photoController.text,
              barcode: _barcodeController.text,
              name: _nameController.text,
              measurement: _measurementController.text,
              quantity: int.tryParse(_quantityController.text) ?? 0,
            );
            widget.onProductAdded(newProduct);

            Navigator.of(context).pop();
          },
          child: const Text('Ekle'),
        ),
      ],
    );
  }

  Future<File?> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);
  }
}
