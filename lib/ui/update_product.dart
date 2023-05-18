import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/data/model/product.dart';
import 'package:hello_flutter/data/repository/product_repo_impl.dart';

class UpdateProduct extends StatefulWidget {
  final String productId;

  const UpdateProduct({Key? key, required this.productId}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}
/*
TextEditingController does not need an onChange function, you can directly assign the variable, and extract the value from that variable's .text property.
 */
class _UpdateProductState extends State<UpdateProduct> {
  final repo = ProductRepoImpl();
  final _title = TextEditingController();
  final _brand = TextEditingController();
  final _category = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _discountPercentage = TextEditingController();
  final _rating = TextEditingController();
  final _stock = TextEditingController();
  final _thumbnail = "";
  var _titleError = "";
  var _brandError = "";
  var _categoryError = "";
  var _descriptionError = "";
  var _priceError = "";
  var _discountPercentageError = "";
  var _ratingError = "";
  var _stockError = "";
  late String productId;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  void dispose() {
    _title.dispose();
    _brand.dispose();
    _category.dispose();
    _description.dispose();
    _price.dispose();
    _discountPercentage.dispose();
    _rating.dispose();
    _stock.dispose();
    super.dispose();
  }

  void refresh() async {
    productId = widget.productId;
    final res = await repo.getItemById(productId);
    setState(() {
      if (res != null) {
        _title.text = res.title;
        _brand.text = res.brand;
        _category.text = res.category;
        _description.text = res.description;
        _price.text = res.price.toString();
        _discountPercentage.text = res.discountPercentage.toString();
        _rating.text = res.rating.toString();
        _stock.text = res.stock.toString();
      }
    });
  }

  _onTitleChanged(value) {
    setState(() {
      _title.text = value;
      _title.selection = TextSelection.collapsed(offset: _title.text.length);
    });
  }

  _onBrandChanged(value) {
    setState(() {
      _brand.text = value;
      _brand.selection = TextSelection.collapsed(offset: _brand.text.length);
    });
  }

  _onCategoryChanged(value) {
    setState(() {
      _category.text = value;
      _category.selection =
          TextSelection.collapsed(offset: _category.text.length);
    });
  }

  _onDescriptionChanged(value) {
    setState(() {
      _description.text = value;
      _description.selection =
          TextSelection.collapsed(offset: _description.text.length);
    });
  }

  _onPriceChanged(value) {
    setState(() {
      _price.text = value;
      _price.selection = TextSelection.collapsed(offset: _price.text.length);
    });
  }

  _onDiscountChanged(value) {
    setState(() {
      _discountPercentage.text = value;
      _discountPercentage.selection =
          TextSelection.collapsed(offset: _discountPercentage.text.length);
    });
  }

  _onRatingChanged(value) {
    setState(() {
      _rating.text = value;
      _rating.selection = TextSelection.collapsed(offset: _rating.text.length);
    });
  }

  _onStockChanged(value) {
    setState(() {
      _stock.text = value;
      _stock.selection = TextSelection.collapsed(offset: _stock.text.length);
    });
  }

  _onClickUpdate() {
    setState(() {
      if (_title.text.isEmpty) {
        _titleError = "Title cannot be empty";
      } else {
        _titleError = "";
      }

      if (_brand.text.isEmpty) {
        _brandError = "Brand cannot be empty";
      } else {
        _brandError = "";
      }

      if (_category.text.isEmpty) {
        _categoryError = "Category cannot be empty";
      } else {
        _categoryError = "";
      }

      if (_description.text.isEmpty) {
        _descriptionError = "Description cannot be empty";
      } else {
        _descriptionError = "";
      }

      if (_price.text.isEmpty) {
        _priceError = "Price cannot be 0";
      } else {
        _priceError = "";
      }

      if (_discountPercentage.text.isEmpty) {
        _discountPercentageError = "Discount Percentage cannot be negative";
      } else {
        _discountPercentageError = "";
      }

      if (_rating.text.isEmpty) {
        _ratingError = "Rating cannot be 0";
      } else {
        _ratingError = "";
      }

      if (_stock.text.isEmpty) {
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
        _onUpdateProduct(
            _title.text,
            _brand.text,
            _category.text,
            _description.text,
            double.tryParse(_price.text),
            double.tryParse(_discountPercentage.text),
            double.tryParse(_rating.text),
            int.tryParse(_stock.text));
        context.pop("true");
      } else {
        debugPrint("Failed to add product");
      }
    });
  }

  _onUpdateProduct(title, brand, category, description, price,
      discountPercentage, rating, stock) async {
    final product = Product(
        id: productId,
        title: title,
        brand: brand,
        category: category,
        description: description,
        price: price,
        discountPercentage: discountPercentage,
        rating: rating,
        stock: stock,
        thumbnail: _thumbnail);
    await repo.updateItem(productId, product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product"),
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
                        controller: _title,
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
                        controller: _brand,
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
                        controller: _category,
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
                        controller: _description,
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
                        controller: _price,
                        onChanged: (value) => _onPriceChanged(value),
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.onetwothree),
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
                        controller: _discountPercentage,
                        onChanged: (value) => _onDiscountChanged(value),
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.onetwothree),
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
                        controller: _rating,
                        onChanged: (value) => _onRatingChanged(value),
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.onetwothree),
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
                        controller: _stock,
                        onChanged: (value) => _onStockChanged(value),
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.onetwothree),
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
                  onPressed: () => _onClickUpdate(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text("Update", style: TextStyle(fontSize: 16))),
            ],
          )
        ],
      ),
    );
  }
}
