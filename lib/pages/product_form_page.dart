import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // Fazendo analogia ao React, esse _formData seria um, const [formData, setFormData] = useState({nome: '', preco: 0})
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();

    _imageUrlFocus.addListener(updateImageUrl);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImageUrl);
  }

  void updateImageUrl() {
    setState(() {});
  }

  void _submitForm() {
    _formKey.currentState?.save();
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      name: _formData['name'] as String,
      price: _formData['price'] as double,
      description: _formData['description'] as String,
      imageUrl: _formData['imageUrl'] as String,
    );
    print(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitted,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
            child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nome'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocus);
              },
              onSaved: (name) => _formData['name'] = name ?? '',
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Preço'),
              textInputAction: TextInputAction.next,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              focusNode: _priceFocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocus);
              },
              onSaved: (price) => _formData['price'] = double.parse(price ?? '0.0'),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descrição',
              ),
              textInputAction: TextInputAction.next,
              focusNode: _descriptionFocus,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_imageUrlFocus);
              },
              onSaved: (description) => _formData['description'] = description ?? '',
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Url da Imagem'),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.url,
                    focusNode: _imageUrlFocus,
                    controller: _imageUrlController,
                    onSaved: (urlImage) => _formData['urlImage'] = urlImage ?? '',
                    onFieldSubmitted: (_) => _submitted(),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  alignment: Alignment.center,
                  child: _imageUrlController.text.isEmpty
                      ? const Text('Informe a Url')
                      : Image.network(_imageUrlController.text),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
