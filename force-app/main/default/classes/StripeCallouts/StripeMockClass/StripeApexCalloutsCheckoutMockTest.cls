@isTest
global class StripeApexCalloutsCheckoutMockTest implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String body = '{'
            + '"customer": "cus_00000000000000",'
            + '"mode": "payment",'
            + '"line_items": {'
            + '  "0": {'
            + '    "price_data": {'
            + '      "unit_amount": "50000",'
            + '      "currency": "usd",'
            + '      "product_data": {'
            + '        "name": "GenWatt Propane 500kW"'
            + '      }'
            + '    },'
            + '    "quantity": "2"'
            + '  },'
            + '  "1": {'
            + '    "price_data": {'
            + '      "unit_amount": "25000",'
            + '      "currency": "usd",'
            + '      "product_data": {'
            + '        "name": "GenWatt Diesel 200kW"'
            + '      }'
            + '    },'
            + '    "quantity": "5"'
            + '  }'
            + '},'
            + '"cancel_url": "https://example.com/cancel",'
            + '"success_url": "https://example.com/success",'
            + '"payment_method_types": {'
            + '  "0": "card"'
            + '}'
          + '}';
        // response.setBody(body);
        response.setBody('{"example":"test"}');
        response.setStatusCode(200);
        return response; 
    }
}