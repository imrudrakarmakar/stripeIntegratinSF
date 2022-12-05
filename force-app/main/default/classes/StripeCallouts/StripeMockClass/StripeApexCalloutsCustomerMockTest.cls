@isTest
global class StripeApexCalloutsCustomerMockTest implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String body = '{'
            + '"id": "cus_00000000000000",'
            + '"object": "customer",'
            + '"address": {'
            + '  "city": "NYC",'
            + '  "country": "United States",'
            + '  "line1": "Test Address",'
            + '  "line2": null,'
            + '  "postal_code": "10016",'
            + '  "state": "USA"'
            + '},'
            + '"balance": 0,'
            + '"created": 1667228734,'
            + '"currency": null,'
            + '"default_source": null,'
            + '"delinquent": false,'
            + '"description": null,'
            + '"discount": null,'
            + '"email": "paymenttest@mail.com",'
            + '"invoice_prefix": "7A16D506",'
            + '"invoice_settings": {'
            + '  "custom_fields": null,'
            + '  "default_payment_method": null,'
            + '  "footer": null,'
            + '  "rendering_options": null'
            + '},'
            + '"livemode": false,'
            + '"metadata": {'
            + '},'
            + '"name": "Acc Test",'
            + '"next_invoice_sequence": 1,'
            + '"phone": "987654321",'
            + '"preferred_locales": ['
            + '],'
            + '"shipping": null,'
            + '"tax_exempt": "none",'
            + '"test_clock": null'
          + '}';
        response.setBody(body);
        // response.setBody('{"example":"test"}');
        response.setStatusCode(200);
        return response; 
    }
}