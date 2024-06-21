import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

class AccessTokenFirebase{
  // url endpoint

  static String firebaseMessagingScope = "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccessToken()async{
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(
            {
              "type": "service_account",
              "project_id": "tomatiopianote",
              "private_key_id": "df35f7c73689cb21067f67f8ade79fab792d9648",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCc5y5hY+Yxuhez\n7fqUK0bxHDFxiqy1tUIfFKZG0igMdEzs26AsytniQxsZ6OqRAbQ5rd+LjeYugWjM\nxuOpQzMkl6eoO6t/SrV9ZCLJfheZ+rbxEFp+7nAXftNotbVKVQtNnVGVaWcC0RBO\ncKZLfEqiQ38dExgHIPgx0K6TN6z+3t+d0ApdujXdXvYto1bpSGV1XLOOtjlKGRmH\ngMuSn0eGrcz9GrgpYh+mnf9oVk4reYKHdvmjoYHIcXr1N8sd0h+kS+Sh0fAA3HsE\npduNAMdpuMotLGMKh+wPFFgPea7CbWd5ewNkxo1+taLX6d+YZbq2D7o7zv6tW+lW\nb7M6JFzhAgMBAAECggEAAKtHMjozniC/zwrRHlk2D5s59j9xQlfu0N9c4KaELh5q\nVrm5MSu0b2UExvDhxthvI8Oof/8M8oPnK0q0p+Z96mESVtLZ+xGvBwUlP/70xo7a\n7Bml4HlE5YLAenIzlFOFwsZXQFf6AkPw31FsEhxqRzlwCl2SxQgDKuzhAQbJdZpC\nZeEENE1ljtgTpT84LxAl4vhy+bMdjZZgiS5W6Qn9jT/IHSli+37v2KQPg/NsRR+P\nB79UGK2U6+Y3LH/TIDxD795AIGMFv2KCJrI3MjtbJk5/+4uojjYKkJuyy9V3eYbU\nCrfkiCvXC7Q6a3QK6edxsEMvEbWoVxWW3yx5BWIloQKBgQDVEow8PrDGMTG6ZdzQ\nGzkNSFqZm1VFoQJU/Z8Sgf4mTrPRo6couqtNBEb6MIn34XVVUk1RMqBeXYwSnQE0\nW7mWxmS8qhEj+n7zTFMft6v/lIAgBMcJ1a5TZ9ocnasRwOlshBJQreer6Ou66pAP\nFyKVPM4iMMS4PF+yIEZ5voK+UQKBgQC8g6IVNJYQhoh3maNl6Vop67ylIavCu5as\ng+OMNou/jbRCA5vPqgbHauOlDz4lUGUPzeRfHNTFYuhk50W0IagBx1NyWRm46SkX\nUMcr8iOc5XV4Yb/Uw8fmdSMwdeEcHXHm1sfuAjgc0kPH7Ym5WNGfgHj6lCotVWCQ\ncFvPnoRBkQKBgQDShtsNA5xCl4Tc+Zyt+tfqKd1q/LHKdIYLV/T+onZtf0HpF1wo\nwBhVpq5CsgcAZ0I5pXJDklQmKSQnl/4Cr8a2FRyf1SHOfMlGt9lB84b8psvZ1x6a\ntwjh3DEEKT1H82YwFGbMVKgdkaypKO5iGqfO8R9zZOBacTzUkVNRI02noQKBgQCx\n+NQckPjbwSc1Qqcwn42v5g7DF3bA8bjeReWdiiGFRpLXf/CprSuZOSCRxEI3mB7R\nPOBNqzp031vnZzA3T0793uC5I8VU/Ur96BUhOAjHJxov/JjOlcczm4MNTTyo/mN6\nO2ulGBNBooC7T1am1WOR4ghVCWyIQAJaWrlS2aSjAQKBgEtVUWyRqZihkaxZwpS7\n5PJYR/gSTpWnURTAmu1Xx+SR5F+zjQD3ZMJQTR80kHxsZwcVwBAqGMh0GHgUAZob\nW+Pll4NlXlX2SRQt8mhmX2raCz5ygGWJzBACYQgShoWAzw96ZUN6hTKhBtcPHPRK\nJaDmoDy+Q9rsMtu3GbdC+jqg\n-----END PRIVATE KEY-----\n",
              "client_email": "firebase-adminsdk-ff0et@tomatiopianote.iam.gserviceaccount.com",
              "client_id": "117988647489770412788",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-ff0et%40tomatiopianote.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }
        ),

        [firebaseMessagingScope],
    );

    // extract access token from the credentials

    final accessToken = client.credentials.accessToken.data;

    return accessToken;
  }
}