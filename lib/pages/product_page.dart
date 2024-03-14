import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/models/products_model.dart';
import 'package:storeapp_flutter/provider/products_provider.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/back_widget.dart';
import 'package:storeapp_flutter/widgets/empty_prodcuts_widget.dart';
import 'package:storeapp_flutter/widgets/product_items_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final TextEditingController? _searchController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  late List<ProductModel> listProdcutSearch = [];
  @override
  void dispose() {
    _searchController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final util = Utils(context);
    
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productsProvider.getProducts;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: "Productos",
          color: util.color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  style: TextStyle(
                    color: util.color,
                  ),
                  focusNode: _searchTextFocusNode,
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      listProdcutSearch = productsProvider.searchQuery(value);
                      print(listProdcutSearch.length);
                    });
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.greenAccent,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.greenAccent,
                          width: 1,
                        ),
                      ),
                      hintText: " Que deseas buscar?...",
                      prefix: Padding(
                        padding: const EdgeInsets.only(right: 10, top: 10),
                        child: Icon(IconlyLight.search),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _searchController!.clear();
                          _searchTextFocusNode.unfocus();
                        },
                        icon: Icon(
                          Icons.close,
                          color: _searchTextFocusNode.hasFocus
                              ? Colors.red
                              : util.color,
                        ),
                      )),
                ),
              ),
            ),
            _searchController!.text.isNotEmpty && listProdcutSearch.isEmpty
                ? const EmptyProdWidget(text: 'Productos no encontrado  ')
                : GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    padding: EdgeInsets.zero,
                    // crossAxisSpacing: 10,
                    childAspectRatio: 260 / 310,
                    children: List.generate(
                        _searchController.text.isNotEmpty
                            ? listProdcutSearch.length
                            : allProducts.length, (index) {
                      print(listProdcutSearch.length);

                      return ChangeNotifierProvider.value(
                        value: _searchController.text.isNotEmpty
                            ? listProdcutSearch[index]
                            : allProducts[index],
                        child: ProductItemWidget(),
                      );
                    }),
                  ),
          ],
        ),
      ),
    );
  }
}
