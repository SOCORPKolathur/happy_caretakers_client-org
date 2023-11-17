import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    this.icon,
    required this.hint,
    this.value,
    required this.passType,
    required this.controller,
    required this.validator,
    required this.onSubmitted,
    required this.keyboardType,
  });

  final IconData? icon;
  final String hint;
  final TextEditingController? controller;
  bool passType;
  final String? value;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSubmitted;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool isObsecure = false;
  @override
  void initState() {
    if (widget.value != null) {
      widget.controller!.text = widget.value ?? '';
    }
    if(widget.passType){
      isObsecure = true;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(right: 15),
      height: size.height * 0.07,
      width: size.width * 0.9,
      decoration: BoxDecoration(
          color: Constants.primaryWhite,
          borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Constants.lightGrey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(-3,3),
          ),
        ]
      ),
      child: Center(
        child: TextFormField(
          onFieldSubmitted: widget.onSubmitted,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: isObsecure,
          enableSuggestions: !widget.passType,
          autocorrect: !widget.passType,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: widget.icon != null
                ? Icon(
              widget.icon,
              color: Constants.primaryAppColor,
            )
                : const CircleAvatar(backgroundColor: Colors.transparent, radius: 5),
            suffixIcon:widget.passType ? IconButton(
              icon: Icon(isObsecure
                  ? Icons.visibility
                  : Icons.visibility_off,color: const Color(0xff757879)),
              onPressed: () {
                setState(() {
                  isObsecure = !isObsecure;
                },
                );
              },
            ) : null,
            hintText: widget.hint,
            hintStyle: GoogleFonts.poppins(
              color: Constants.lightGrey,
              fontSize: 18,
            ),
            labelStyle: GoogleFonts.poppins(
              color: Constants.lightGrey,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
