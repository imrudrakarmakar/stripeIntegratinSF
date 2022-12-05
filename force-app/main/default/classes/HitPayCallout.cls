public with sharing class HitPayCallout {

    // public static string storeAmount;
    // public static string storeCurrency;

    // @AuraEnabled(cacheable=true)
    // public static void postPaymentRequest(String reqAmount, String reqCurrency){
    //     try {
    //         storeAmount = reqAmount;
    //         storeCurrency = reqCurrency;

    //         System.debug('Request -------> Amount: ' + storeAmount +' Currency: ' + storeCurrency);
    //         System.debug('System.Label.HitPayBusinessKey ---> ' + System.Label.HitPayBusinessKey);

    //         makePostPaymentCallout();
    //     } catch (Exception e) {
    //         throw new AuraHandledException(e.getMessage());
    //     }
    // }

    public static HttpResponse makePostPaymentCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.sandbox.hit-pay.com/v1/payment-requests');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('X-BUSINESS-API-KEY', System.Label.HitPayBusinessKey);
        request.setBody('{"amount": "2500", "currency": "USD"}');
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }
}
