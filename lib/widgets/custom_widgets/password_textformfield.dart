import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/custom_validators.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    required TextEditingController controller,
    this.textInputAction = TextInputAction.done,
    this.hint='Password',
    this.readOnly = false,
    Key? key,
  })  : _controller = controller,
        super(key: key);
  final TextEditingController _controller;
  final TextInputAction? textInputAction;
  final String hint;
  final bool readOnly;
  @override
  PasswordTextFormFieldState createState() => PasswordTextFormFieldState();
}

class PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _notVisible = true;
  void _onListener() => setState(() {});
  @override
  void initState() {
    widget._controller.addListener(_onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._controller.removeListener(_onListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.grey[300],
      ),
      child: TextFormField(
        controller: widget._controller,
        obscureText: _notVisible,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: widget.textInputAction,
        readOnly: widget.readOnly,
        cursorColor: Theme.of(context).colorScheme.secondary,
        validator: (String? value) => CustomValidator.password(value),
        decoration: InputDecoration(
          hintText: widget.hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          suffixIcon: IconButton(
            onPressed: () => setState(() {
              _notVisible = !_notVisible;
            }),
            splashRadius: 16,
            icon: (_notVisible == true)
                ? const Icon(CupertinoIcons.eye)
                : const Icon(CupertinoIcons.eye_slash),
          ),
          focusColor: Theme.of(context).primaryColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
