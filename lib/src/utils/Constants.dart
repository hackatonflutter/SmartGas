import 'package:amazon_cognito_identity_dart/cognito.dart';

class Constants {
  static const awsUserPoolId = '';
  static const awsClientId = '';

  static const identityPoolId =
      '';

// Setup endpoints here:
  static const region = '';
//static const endpoint = 'https://xxxxxxxxxx.execute-api.ap-southeast-1.amazonaws.com/dev';

  static final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);
}
