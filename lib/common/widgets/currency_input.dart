import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';

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
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButton<String>(
                elevation: 0,
                underline: const SizedBox(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 14,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 32,
                ),
                value: dropdownValue,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdownValue =
                          newValue; // dropdown değerini güncelliyoruz
                    });
                    widget.onChanged(newValue, widget.priceController.text);
                  }
                },
                items: <String>['USD', 'EUR', 'GBP', 'JPY', 'TL']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: Scaler.width(0.6, context),
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
