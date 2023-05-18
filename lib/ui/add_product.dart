import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/data/model/product.dart';
import 'package:hello_flutter/data/repository/product_repo_impl.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final repo = ProductRepoImpl();
  var _title = "";
  var _brand = "";
  var _category = "";
  var _description = "";
  double _price = 0.0;
  double _discountPercentage = 0.0;
  double _rating = 0.0;
  int _stock = 0;
  var _titleError = "";
  var _brandError = "";
  var _categoryError = "";
  var _descriptionError = "";
  var _priceError = "";
  var _discountPercentageError = "";
  var _ratingError = "";
  var _stockError = "";

  _onTitleChanged(value) {
    setState(() {
      _title = value;
    });
  }

  _onBrandChanged(value) {
    setState(() {
      _brand = value;
    });
  }

  _onCategoryChanged(value) {
    setState(() {
      _category = value;
    });
  }

  _onDescriptionChanged(value) {
    setState(() {
      _description = value;
    });
  }

  _onPriceChanged(value) {
    setState(() {
      _price = double.tryParse(value) ?? 0.0;
    });
  }

  _onDiscountChanged(value) {
    setState(() {
      _discountPercentage = double.tryParse(value) ?? 0.0;
    });
  }

  _onRatingChanged(value) {
    setState(() {
      _rating = double.tryParse(value) ?? 0.0;
    });
  }

  _onStockChanged(value) {
    setState(() {
      _stock = int.tryParse(value) ?? 0;
    });
  }

  _onClickAdd() {
    setState(() {
      if (_title.isEmpty) {
        _titleError = "Title cannot be empty";
      } else {
        _titleError = "";
      }

      if (_brand.isEmpty) {
        _brandError = "Brand cannot be empty";
      } else {
        _brandError = "";
      }

      if (_category.isEmpty) {
        _categoryError = "Category cannot be empty";
      } else {
        _categoryError = "";
      }

      if (_description.isEmpty) {
        _descriptionError = "Description cannot be empty";
      } else {
        _descriptionError = "";
      }

      if (_price.isNaN) {
        _priceError = "Price cannot be 0";
      } else {
        _priceError = "";
      }

      if (_discountPercentage.isNegative) {
        _discountPercentageError = "Discount Percentage cannot be negative";
      } else {
        _discountPercentageError = "";
      }

      if (_rating.isNegative) {
        _ratingError = "Rating cannot be 0";
      } else {
        _ratingError = "";
      }

      if (_stock.isNaN) {
        _stockError = "Stock cannot be 0";
      } else {
        _stockError = "";
      }

      if (_titleError == "" &&
          _brandError == "" &&
          _categoryError == "" &&
          _descriptionError == "" &&
          _priceError == "" &&
          _discountPercentageError == "" &&
          _ratingError == "" &&
          _stockError == "") {
        _onCreateProduct(_title, _brand, _category, _description, _price,
            _discountPercentage, _rating, _stock);
        context.pop("true");
      } else {
        debugPrint("Failed to add product");
      }
    });
  }

  _onCreateProduct(title, brand, category, description, price,
      discountPercentage, rating, stock) async {
    final product = Product(
        title: title,
        brand: brand,
        category: category,
        description: description,
        price: price,
        discountPercentage: discountPercentage,
        rating: rating,
        stock: stock,
        thumbnail: "");
    debugPrint(product.toString());
    await repo.insertItem(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextField(
                        onChanged: (value) => _onTitleChanged(value),
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.abc_sharp),
                            hintText: "Title",
                            errorText: _titleError.isEmpty ? null : _titleError,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextField(
                        onChanged: (value) => _onBrandChanged(value),
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.abc_sharp),
                            hintText: "Brand",
                            errorText: _brandError.isEmpty ? null : _brandError,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextField(
                        onChanged: (value) => _onCategoryChanged(value),
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.abc_sharp),
                            hintText: "Category",
                            errorText:
                                _categoryError.isEmpty ? null : _categoryError,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextField(
                        onChanged: (value) => _onDescriptionChanged(value),
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.abc_sharp),
                            hintText: "Description",
                            errorText: _descriptionError.isEmpty
                                ? null
                                : _descriptionError,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextField(
                        onChanged: (value) => _onPriceChanged(value),
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.abc_sharp),
                            hintText: "Price",
                            errorText: _priceError.isEmpty ? null : _priceError,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextField(
                        onChanged: (value) => _onDiscountChanged(value),
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.abc_sharp),
                            hintText: "Discount Percentage",
                            errorText: _discountPercentageError.isEmpty
                                ? null
                                : _discountPercentageError,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextField(
                        onChanged: (value) => _onRatingChanged(value),
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.abc_sharp),
                            hintText: "Rating",
                            errorText:
                                _ratingError.isEmpty ? null : _ratingError,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextField(
                        onChanged: (value) => _onStockChanged(value),
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.abc_sharp),
                            hintText: "Stock",
                            errorText: _stockError.isEmpty ? null : _stockError,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ]),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => _onClickAdd(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text("Add", style: TextStyle(fontSize: 16))),
            ],
          )
        ],
      ),
    );
  }
}
