import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final String? Function(String?)? validator;
  final bool isPassword;
  final IconData? icon;
  final bool hasIcon;

 const MyTextField(
      {Key? key,
      required this.controller,
      this.hint,
      this.label,
      this.validator,
      this.isPassword = false,
      this.icon,
      this.hasIcon = true })
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  IconData visibilityIcon = Icons.visibility_off;
  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
      
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.isPassword ? visibility : false,
        keyboardType: widget.label == "Email"
            ? TextInputType.emailAddress
            : widget.label == "Phone Number"
                ? TextInputType.number
                : TextInputType.text,
        decoration: InputDecoration(
          icon: widget.hasIcon ? Icon(widget.icon) : null,
          border: OutlineInputBorder(
            borderSide: const BorderSide(),
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: widget.hint,
          labelText: widget.label,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      visibility = !visibility;
                      visibilityIcon == Icons.visibility_off
                          ? visibilityIcon = Icons.visibility
                          : visibilityIcon = Icons.visibility_off;
                    });
                  },
                  icon: Icon(visibilityIcon),
                )
              : null,
        ),
      ),
    );
  }
}



// class CachedImage extends StatelessWidget {
//  final String url;
//  const CachedImage(this.url,{ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: url,
//       placeholder: (ctx,url)=>const CircularProgressIndicator(),
//       errorWidget: (ctx,url,error)=>const Icon(Icons.error),
//     );
//   }
// }


// showToast(
//     {required BuildContext context,
//     required String msg,
//     required Color color}) {
//   Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: color,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }
// //   Toast.show(msg, context,
//       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: color);
// }


