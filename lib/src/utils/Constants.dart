import 'package:amazon_cognito_identity_dart/cognito.dart';

class Constants {
static const awsUserPoolId = 'us-east-1_dfUNX6DPn';
static const awsClientId = '2lbeh8s6228f1gh7j26vhmt1nm';

static const identityPoolId = 'us-east-1:212026313232:userpool/us-east-1_dfUNX6DPn';

// Setup endpoints here:
static const region = 'us-east-1';
//static const endpoint = 'https://xxxxxxxxxx.execute-api.ap-southeast-1.amazonaws.com/dev';

static final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);

}
