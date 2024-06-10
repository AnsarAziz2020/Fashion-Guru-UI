import 'package:string_validator/string_validator.dart';

String emailValidate(value){
  if(value.isEmpty){
    return "Enter your email address";
  } else if(!isEmail(value)){
    return "Enter a valid email address";
  }
  return "";
}

String passwordValidator(value){
  if(value.isEmpty){
    return "You must enter a password";
  } else if(value.length<6){
    return "Enter a password with more than 6 character";
  }
  return "";
}

String aplhaCharacter(value){
  if(value.isEmpty){
    return "You have not enter this field";
  } else if(!RegExp(r"^[a-zA-Z ]+$").hasMatch(value)){
    return "Field must contain only alphabets";
  }
  return "";
}

String onlyNumeric(value){
  if(value.isEmpty){
    return "You have not enter this field";
  } else if(!isNumeric(value)){
    return "Enter only number from 0-9";
  }
  return "";
}

String alphaNumeric(value){
  if(value.isEmpty){
    return "You have not enter this field";
  } else if(!RegExp(r"^[a-zA-Z0-9 ]+$").hasMatch(value)){
    return "Only Aplhabets and Number are allowed";
  } else {
    return "";
  }
}

String phoneNoValidator(value){
  if(value.isEmpty){
    return "You have not enter this field";
  } else if(!isNumeric(value)){
    return "Enter only number from 0-9";
  } else if(!RegExp(r"^03[0-9]{9}").hasMatch(value)){
    return "Enter a valid phone number";
  }
  return "";
}

String isNotEmpty(value){
  if(value.isEmpty || value==null){
    return "You have not enter this field";
  }
  return "";
}