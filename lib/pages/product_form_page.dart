import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

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
  final _formData = <String, Object>{};

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

  bool isValidateImageUlr(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFline = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return isValidUrl && endsWithFline;
  }

  void _submitForm() {
    final isValidate = _formKey.currentState?.validate() ?? false;

    if (!isValidate) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<ProductList>(context, listen: false).addProductForm(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
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
                  validator: (value) {
                    final name = value ?? '';

                    if (name.trim().isEmpty) {
                      return 'Nome é obrigatório';
                    }

                    if (name.trim().length < 2) {
                      return 'Nome deve ter no mínimo 3 letras';
                    }

                    return null;
                  },
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
                  onSaved: (price) =>
                      _formData['price'] = double.parse(price ?? '0.0'),
                  validator: (value) {
                    final priceString = value ?? '';
                    final price = double.tryParse(priceString) ?? -1;

                    if (price <= 0) {
                      return 'Informe um preço válido.';
                    }

                    return null;
                  },
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
                  onSaved: (description) =>
                      _formData['description'] = description ?? '',
                  validator: (value) {
                    final description = value ?? '';
                    if (description.trim().isEmpty) {
                      return 'Descrição é obrigatória';
                    }
                    if (description.trim().length < 10) {
                      return 'Descrição deve ter no mínimo 10 caracteres';
                    }

                    return null;
                  },
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
                        onSaved: (urlImage) =>
                            _formData['urlImage'] = urlImage ?? '',
                        validator: (value) {
                          final imageUrl = value ?? '';
                          if (!isValidateImageUlr(imageUrl)) {
                            return 'Informe uma Url válida';
                          }

                          return null;
                        },
                        onFieldSubmitted: (_) => _submitForm(),
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
