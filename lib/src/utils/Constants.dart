import 'package:amazon_cognito_identity_dart/cognito.dart';

class Constants{

// Setup AWS User Pool Id & Client Id settings here:

static const awsUserPoolId = "";
static const awsClientId = "";

static const identityPoolId = "";

// Setup endpoints here:
static const region = 'us-east-1';
//static const endpoint = 'https://xxxxxxxxxx.execute-api.ap-southeast-1.amazonaws.com/dev';

static final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);


//static const endpoint = 'https://xxxxxxxxxx.execute-api.ap-southeast-1.amazonaws.com/dev';

//static final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);


}