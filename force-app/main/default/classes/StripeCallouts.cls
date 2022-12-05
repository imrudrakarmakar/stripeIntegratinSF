public with sharing class StripeCallouts {

    private static string accessTokenL = System.Label.StripeAPI;

    // -------------------------------------------------- Create Customer Section ----------------------------------------------------------------

    // Create customer
    public static string cusName;
    public static string cusPhone;
    public static string cusEmail;
    public static string cusCity;
    public static string cusCountry;

    @AuraEnabled(cacheable=true)
    public static String createStripeCustomer(String cName, String cPhone, String cEmail, String cCity, String cCountry){
        try {
            cusName = cName;
            cusPhone = cPhone;
            cusEmail = cEmail;
            cusCity = cCity;
            cusCountry = cCountry;

            System.debug('###### Customer: Fetch Data From LWC ----->'+ cusName +'---'+ cusPhone +'---'+ cusEmail +'---'+ cusCity + '---' + cusCountry);
            String customerResponse = createPostCustomerCallout();
            System.debug('customerResponse-------------> '+customerResponse);
            System.debug('customerResponse.id-------------> '+customerResponse.id);
            return customerResponse;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static String createPostCustomerCallout() {
        System.debug('###### Customer: Pass Data to Stripe Callouts ----->'+ cusName +'---'+ cusPhone +'---'+ cusEmail +'---'+ cusCity + '---' + cusCountry);
        System.debug('System.Label.StripeAPI ---> ' + System.Label.StripeAPI);
        System.debug('accessTokenL ---> ' + accessTokenL);

        // Set Access token, might change it to the custom lable
        // String accessToken = 'sk_test_51Ll6xfSFsoRFE1FWKP1INyor2Lh440gFKOk76hvZsoVps9dfPYMxpp4FyPn7O9W4pShOjY7KTHueeqh94AUQHbSa00YQ3FLapv';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // Set Endpoint & Method
        request.setEndpoint('https://api.stripe.com/v1/customers');
        request.setMethod('POST');
        // Header Section
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization','Bearer '+accessTokenL);
        // Request for Body
        String body = 'name=' + EncodingUtil.urlEncode(cusName,'UTF-8')
            + '&phone=' + EncodingUtil.urlEncode(cusPhone,'UTF-8')
            + '&email=' + EncodingUtil.urlEncode(cusEmail ,'UTF-8')
            + '&address[city]=' + EncodingUtil.urlEncode(cusCity,'UTF-8')
            + '&address[country]=' + EncodingUtil.urlEncode(cusCountry,'UTF-8');
        request.setBody(body);
        // Send http request to the Stripe API
        HttpResponse response = http.send(request);
        String customerResponse = null;
        // Parse the JSON response
        if(response.getStatusCode() != 201) {
            System.debug('The status code returned was expected: ' + response.getStatusCode() + ' ' + response.getStatus());
            System.debug('response.getBody() ----> ' + response.getBody());
            customerResponse = response.getBody();
        } else {
            System.debug(response.getBody());
        }
        System.debug('customerResponse -----> ' + customerResponse);
        return customerResponse;
    } 

    // -------------------------------------------------- Create Payment Method Section ----------------------------------------------------------------

    // Create Payment Method
    public static string cardNumber;
    public static string cardExpMonth;
    public static string cardExpYear;
    public static string cardCVV;

    @AuraEnabled(cacheable=true)
    public static String makePaymentMethod(String cCardNum, String cExpMonth, String cExpYear, String cCVV){
        try {
            cardNumber = cCardNum;
            cardExpMonth = cExpMonth;
            cardExpYear = cExpYear;
            cardCVV = cCVV;

            System.debug('###### Payment Method: Fetch Data From LWC -----> ' + cardNumber +'---'+ cardExpMonth +'---'+ cardExpYear + '---' + cardCVV);
            String customerPaymentMethod = createPostPaymentMethodCallout();
            System.debug('customerPaymentMethod-------------> '+customerPaymentMethod);
            return customerPaymentMethod;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static String createPostPaymentMethodCallout() {
        System.debug('###### Payment Method: Pass Data to Stripe Callouts ----->' + cardNumber +'---'+ cardExpMonth +'---'+ cardExpYear + '---' + cardCVV);
        
        // Set Access token, might change it to the custom lable
        // String accessToken = 'sk_test_51Ll6xfSFsoRFE1FWKP1INyor2Lh440gFKOk76hvZsoVps9dfPYMxpp4FyPn7O9W4pShOjY7KTHueeqh94AUQHbSa00YQ3FLapv';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // Set Endpoint & Method
        request.setEndpoint('https://api.stripe.com/v1/payment_methods');
        request.setMethod('POST');
        // Header Section
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization','Bearer '+accessTokenL);
        // Request for Body
        String body = 'type=card'
            + '&card[number]=' + EncodingUtil.urlEncode(cardNumber,'UTF-8')
            + '&card[exp_month]=' + EncodingUtil.urlEncode(cardExpMonth ,'UTF-8')
            + '&card[exp_year]=' + EncodingUtil.urlEncode(cardExpYear,'UTF-8')
            + '&card[cvc]=' + EncodingUtil.urlEncode(cardCVV,'UTF-8');
        request.setBody(body);
        // Send http request to the Stripe API
        HttpResponse response = http.send(request);
        String strResponse = null;
        // Parse the JSON response
        if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
                strResponse = response.getBody();
        } else {
            System.debug(response.getBody());
        }
        System.debug('strResponse -----> ' + strResponse);
        return strResponse;
    }

    // -------------------------------------------------- Attached Payment Method Section ----------------------------------------------------------------

    // Attatched Payment Method
    public static string customerID;
    public static string payment_methodsID;

    @AuraEnabled(cacheable=true)
    public static String attatchCustomerPaymentMethod(String cusAttCustomerID, String cusAttCardId){
        try {
            customerID = cusAttCustomerID;
            payment_methodsID = cusAttCardId;

            System.debug('###### Attatched Payment Method: Fetch Data From LWC -----> ' + customerID +'---'+ payment_methodsID);
            String customerPaymentMethod = attatchPostCustomerPaymentMethodCallout();
            System.debug('customerPaymentMethod-------------> '+customerPaymentMethod);
            return customerPaymentMethod;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static String attatchPostCustomerPaymentMethodCallout() {
        System.debug('###### Attatched Payment Method: Pass Data to Stripe Callouts ----->' + customerID +'---'+ payment_methodsID);
        
        // Set Access token, might change it to the custom lable
        // String accessToken = 'sk_test_51Ll6xfSFsoRFE1FWKP1INyor2Lh440gFKOk76hvZsoVps9dfPYMxpp4FyPn7O9W4pShOjY7KTHueeqh94AUQHbSa00YQ3FLapv';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // Set Endpoint & Method
        request.setEndpoint('https://api.stripe.com/v1/payment_methods/'+payment_methodsID+'/attach');
        request.setMethod('POST');
        // Header Section
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization','Bearer '+accessTokenL);
        // Request for Body
        String body = 'customer=' + EncodingUtil.urlEncode(customerID,'UTF-8');
        request.setBody(body);
        // Send http request to the Stripe API
        HttpResponse response = http.send(request);
        String strResponse = null;
        // Parse the JSON response
        if(response.getStatusCode() != 201) {
            System.debug('The status code returned: ' +
                response.getStatusCode() + ' ' + response.getStatus());
                strResponse = response.getBody();
        } else {
            System.debug(response.getBody());
        }
        System.debug('strResponse -----> ' + strResponse);
        return strResponse;
    }


    // -------------------------------------------------- checkout Section ----------------------------------------------------------------

    public static string productName;
    public static string productPrice;
    public static string productQty;
    public static string productCurr;
    public static string productCustomerId;

    @AuraEnabled(cacheable=true)
    public static String makeStripeCheckoutSession(String pName, String pPrice, String pQty, String pCurr, String pCustomerId){
        try {
            productName = pName;
            productPrice = pPrice;
            productQty = pQty;
            productCurr = pCurr;
            productCustomerId = pCustomerId;

            System.debug('###### Checkout Section: Fetch Data From LWC ----->'+ productName +'---'+ productPrice +'---'+ productQty +'---'+ productCurr);
            makePostCheckoutSessionCallout();
            String makePostCheckoutSessionCallout = makePostCheckoutSessionCallout();
            System.debug('makePostCheckoutSessionCallout-------------> '+makePostCheckoutSessionCallout);
            return makePostCheckoutSessionCallout;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static String makePostCheckoutSessionCallout() {
        System.debug('###### Checkout Section: Pass Data to Stripe Callouts ----->'+ productName +'---'+ productPrice +'---'+ productQty +'---'+ productCurr);
        
        // String accessToken = 'sk_test_51Ll6xfSFsoRFE1FWKP1INyor2Lh440gFKOk76hvZsoVps9dfPYMxpp4FyPn7O9W4pShOjY7KTHueeqh94AUQHbSa00YQ3FLapv';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.stripe.com/v1/checkout/sessions');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization','Bearer '+accessTokenL);
        // Request for Body
        String body = 'success_url=' + EncodingUtil.urlEncode('https://example.com/success','UTF-8')
            + '&cancel_url=' + EncodingUtil.urlEncode('https://example.com/cancel','UTF-8')
            + '&line_items[0][price_data][product_data][name]=' + EncodingUtil.urlEncode(productName ,'UTF-8')
            + '&line_items[0][price_data][unit_amount]=' + EncodingUtil.urlEncode(productPrice ,'UTF-8')
            + '&line_items[0][quantity]=' + EncodingUtil.urlEncode(productQty ,'UTF-8')
            + '&line_items[0][price_data][currency]=' + EncodingUtil.urlEncode(productCurr ,'UTF-8')
            + '&mode=payment'
            + '&payment_method_types[0]=card'
            + '&customer=' +EncodingUtil.urlEncode(productCustomerId ,'UTF-8');
        request.setBody(body);

        // Send http request to the Stripe API
        HttpResponse response = http.send(request);
        String strResponse = null;
        // Parse the JSON response
        if(response.getStatusCode() != 201) {
            System.debug('The status code returned: ' +
                response.getStatusCode() + ' ' + response.getStatus());
                strResponse = response.getBody();
        } else {
            System.debug(response.getBody());
        }
        System.debug('strResponse -----> ' + strResponse);
        return strResponse;
    }  


}