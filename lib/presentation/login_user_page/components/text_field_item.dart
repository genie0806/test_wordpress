import 'package:flutter/material.dart';
import 'package:virtue_test/presentation/login_user_page/login_user_event.dart';
import 'package:virtue_test/presentation/login_user_page/login_user_state.dart';
import 'package:virtue_test/presentation/login_user_page/login_user_view_model.dart';

InputDecoration textInputDeco(String hint) {
  return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(15, 29, 0, 0),
      hintText: hint,
      hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade400),
      enabledBorder: activeInputBorder(),
      focusedBorder: activeInputBorder(),
      errorBorder: errorInputBorder(),
      focusedErrorBorder: errorInputBorder(),
      errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 13));
}

OutlineInputBorder errorInputBorder() {
  return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 0.5,
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(0));
}

OutlineInputBorder activeInputBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade500, width: 0.5),
      borderRadius: BorderRadius.circular(0));
}

InputDecoration passwordInputDeco(
    LoginUserViewModel viewModel, LoginUserState state) {
  return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(15, 29, 0, 0),
      hintText: "비밀번호",
      hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade400),
      enabledBorder: activeInputBorder(),
      focusedBorder: activeInputBorder(),
      errorBorder: errorInputBorder(),
      focusedErrorBorder: errorInputBorder(),
      errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 13),
      suffixIcon: IconButton(
          color: Colors.grey.shade500.withOpacity(.4),
          onPressed: () {
            viewModel.onEvent(const TogglePasswordVisibility());
          },
          icon: state.hidePassword
              ? const Icon(Icons.visibility_off, size: 23)
              : const Icon(Icons.visibility, size: 23)));
}
