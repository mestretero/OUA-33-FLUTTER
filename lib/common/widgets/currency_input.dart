import 'package:flutter/material.dart';

class CurrencyInputWidget extends StatefulWidget {
  final String title;
  final String selectedCurrency;
  final TextEditingController priceController;
  final Function(String currency, String price) onChanged;

  const CurrencyInputWidget({
    Key? key,
    required this.title,
    required this.selectedCurrency,
    required this.priceController,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CurrencyInputWidget> createState() => _CurrencyInputWidget();
}

class _CurrencyInputWidget extends State<CurrencyInputWidget> {
  String dropdownValue = 'USD';

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.selectedCurrency;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    dropdownValue = newValue; // dropdown değerini güncelliyoruz
                  });
                  widget.onChanged(newValue, widget.priceController.text);
                }
              },
              items: <String>[
                'USD',
                'EUR',
                'GBP',
                'JPY',
                'TL'
              ] // Örnek para birimleri
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: widget.priceController,
                decoration: InputDecoration(
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  hintText: widget.title,
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12,
                  ),
                  counterText: "",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent.shade700),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  alignLabelWithHint: true,
                ),
                onChanged: (value) {
                  widget.onChanged(widget.selectedCurrency, value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
