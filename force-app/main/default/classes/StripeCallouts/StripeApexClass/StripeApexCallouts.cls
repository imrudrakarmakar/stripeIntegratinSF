public with sharing class StripeApexCallouts {

    private static string accessToken = System.Label.StripeAPI;

    // -------------------------------------------------- Create Customer Section ----------------------------------------------------------------

    // Get details from Trigger
    public static void getAccountDetails(List<Account> listOfAccount) {
        try {
            For(Account ac : listOfAccount){
                System.debug(ac.Id +' - '+ ac.Name +' - '+ ac.Phone +' - '+ ac.Email__c +' - '+ ac.BillingStreet +' - '+ ac.BillingCity +' - '+ ac.BillingState +' - '+ ac.BillingPostalCode +' - '+ ac.BillingCountry);
                // Call the Customer Post Callout by passing the parameter
                createPostCustomerCallout(ac.Id, ac.Name, ac.Phone, ac.Email__c, ac.BillingStreet, ac.BillingCity, ac.BillingState, ac.BillingPostalCode, ac.BillingCountry);
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    } 
    
    // Create customer in Stripe POST Callout
	@future (callout=true)
    public static void createPostCustomerCallout(String accountId, String customerName, String customerPhone, String customerEmail, String customerBillingStreet, String customerBillingCity, String customerBillingState, String customerBillingPostalCode, String customerBillingCountry) {
        System.debug('Call createPostCustomerCallout method');
        // Http request
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // Set Endpoint & Method
        request.setEndpoint('https://api.stripe.com/v1/customers');
        request.setMethod('POST');
        // Header Section
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization','Bearer '+ accessToken);
        // Request for Body
        String body = 'name=' + EncodingUtil.urlEncode(customerName,'UTF-8')
            + '&phone=' + EncodingUtil.urlEncode(customerPhone,'UTF-8')
            + '&email=' + EncodingUtil.urlEncode(customerEmail ,'UTF-8')
            + '&address[line1]=' + EncodingUtil.urlEncode(customerBillingStreet,'UTF-8')
            + '&address[city]=' + EncodingUtil.urlEncode(customerBillingCity,'UTF-8')
            + '&address[state]=' + EncodingUtil.urlEncode(customerBillingState,'UTF-8')
            + '&address[postal_code]=' + EncodingUtil.urlEncode(customerBillingPostalCode,'UTF-8')
            + '&address[country]=' + EncodingUtil.urlEncode(customerBillingCountry,'UTF-8');
        System.debug('body------> ' + body);
        request.setBody(body);
        // Send http request to the Stripe API
        HttpResponse response = http.send(request);
        // String customerResponse = null;
        String stripeCustomerId = null;
        // Parse the JSON response
        if(response.getStatusCode() != 201) {
            System.debug('### Status code ---> ' + response.getStatusCode() + '  ### Status --->  ' + response.getStatus());
            System.debug('response.getBody() ----> ' + response.getBody());

            // Store response in a wrapper class
            StripeCustomersApiWrapper.customers customerApiResponse = (StripeCustomersApiWrapper.customers)JSON.deserialize(response.getBody(), StripeCustomersApiWrapper.customers.class);
            System.debug('customerApiResponse ----> ' + customerApiResponse);
            System.debug('customerApiResponse.id ----> ' + customerApiResponse.id);
            stripeCustomerId = customerApiResponse.id;
            System.debug('stripeCustomerId ----> ' + stripeCustomerId);

            // System.debug('customerApiResponse.name --->' + customerApiResponse.name );
            // customerResponse = response.getBody();
            // System.debug('customerResponse ---> ' + customerResponse);
        } else {
            System.debug(response.getBody());
        }
        System.debug('accountId -----> ' + accountId + '---    stripeCustomerId ---->' + stripeCustomerId);
        // insertStripeCustomerIdToAccount(accountId, customerResponse);
        insertStripeCustomerIdToAccount(accountId, stripeCustomerId);
    } 

    public static void insertStripeCustomerIdToAccount(String accountId, String customerId) {
        try{
            System.debug('accountId---> '+ accountId +'   customerId response ---> '+ customerId);
            // Map<String, Object> storeCustomerResponse = new Map<String, Object>();
            if(!String.isBlank(customerId)) {
                // Fetch Account details and Update Stripe Customer Id
                Account a = [SELECT Name, StripeCustomerId__c  FROM Account WHERE Id=:accountId];
                // string stripeCustomerId = storeCustomerResponse.get('id').toString();
                a.StripeCustomerId__c = customerId;
                System.debug('Name --> ' + a.Name + ' StripeCustomerId__c --> ' + a.StripeCustomerId__c);
                update a;
                // Check Stripe Customer Id is updated or not
                Account aTest = [SELECT Name, StripeCustomerId__c  FROM Account WHERE Id=:accountId];
                System.debug('<----Check Stripe Customer Id is updated or not----->');
                System.debug('Name --> ' + aTest.Name + ' StripeCustomerId__c --> ' + aTest.StripeCustomerId__c);
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        } 
    }

    // public static void insertStripeCustomerIdToAccount(String accountId, String customerResponse) {
    //     try{
    //         System.debug('accountId---> '+accountId +'   json response ---> '+ customerResponse);
    //         Map<String, Object> storeCustomerResponse = new Map<String, Object>();
    //         if(!String.isBlank(customerResponse)) {
    //             // Deserialize the response and store into a variable
    //             storeCustomerResponse = (Map<String,Object>)JSON.deserializeUntyped(customerResponse);
    //             // System.debug('storeCustomerResponse => ' + storeCustomerResponse);
    //             System.debug('Stripe Customer Id => ' + storeCustomerResponse.get('id'));
    //         }
    //         if(!storeCustomerResponse.isEmpty()) {
    //             // Fetch Account details and Update Stripe Customer Id
    //             Account a = [SELECT Name, StripeCustomerId__c  FROM Account WHERE Id=:accountId];
    //             string stripeCustomerId = storeCustomerResponse.get('id').toString();
    //             a.StripeCustomerId__c = stripeCustomerId;
    //             System.debug('Name --> ' + a.Name + ' StripeCustomerId__c --> ' + a.StripeCustomerId__c);
    //             update a;
    //             // Check Stripe Customer Id is updated or not
    //             Account aTest = [SELECT Name, StripeCustomerId__c  FROM Account WHERE Id=:accountId];
    //             System.debug('<----Check Stripe Customer Id is updated or not----->');
    //             System.debug('Name --> ' + aTest.Name + ' StripeCustomerId__c --> ' + aTest.StripeCustomerId__c);
    //         }
    //     } catch (Exception e) {
    //         throw new AuraHandledException(e.getMessage());
    //     } 
    // }



    // -------------------------------------------------- Order Checkout Section Section ----------------------------------------------------------------
    
    // Order Checkout setup
    private static string storeAccountStripeCustomerId;
    private static string productCurr = 'usd';

    @AuraEnabled(cacheable=true)
    public static String getCheckoutOrderDetails(String orderId) {
        try{
            // Get the order record id from LWC Button on Order section "Checkout Order"
            system.debug('Order id ----> ' + orderId);
                    
            // Store Stripe customer id from Order Account ID
            // String storeAccountStripeCustomerId;
            List<Order> newOrderList = new List<Order>([SELECT Account.StripeCustomerId__c FROM Order WHERE id=:orderId ]);
            for(Order ol : newOrderList) {
                System.debug('----> ' + ol.Account.StripeCustomerId__c);
                storeAccountStripeCustomerId = ol.Account.StripeCustomerId__c;
            }
            System.debug('storeAccountStripeCustomerId ----> ' + storeAccountStripeCustomerId);

            // Get all the order product details from Order
            List<OrderItem> newOrderItemList = new List<OrderItem>([SELECT id, Order.AccountId, Product2.Name, Quantity, UnitPrice FROM OrderItem WHERE Order.id=:orderId]);
            System.debug('newOrderItemList ---->' + newOrderItemList);

            for(OrderItem ot : newOrderItemList) {
                System.debug('----> ' + ot.Product2.Name);
                System.debug('----> ' + ot.Quantity);
                System.debug('----> ' + ot.UnitPrice);
            }

            String allProducts = '';
            integer i=0;
            for(OrderItem ot : newOrderItemList) {
                String pName = '&line_items[' + i + '][price_data][product_data][name]=' + EncodingUtil.urlEncode(ot.Product2.Name ,'UTF-8');
                String pUnitPrice = '&line_items[' + i + '][price_data][unit_amount]=' + EncodingUtil.urlEncode( String.valueOf((ot.UnitPrice).round(System.RoundingMode.DOWN)) ,'UTF-8');
                String pQuantity = '&line_items[' + i + '][quantity]=' + EncodingUtil.urlEncode( String.valueOf((ot.Quantity).round(System.RoundingMode.DOWN)) ,'UTF-8');
                String pCurr = '&line_items[' + i +'][price_data][currency]=' + EncodingUtil.urlEncode(productCurr,'UTF-8');

                allProducts += pName + pUnitPrice + pQuantity + pCurr;
                i++;
            }
            System.debug('allProducts ---> ' + allProducts);
            String orderCheckoutResponse = createPostCheckoutOrderCallout(allProducts);
            System.debug('orderCheckoutResponse ---> ' + orderCheckoutResponse);
            return orderCheckoutResponse;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static String createPostCheckoutOrderCallout(String allProducts) {
        System.debug('allProducts in createPostCheckoutOrderCallout ----> ' + allProducts);
        // Http request
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // Set Endpoint & Method
        request.setEndpoint('https://api.stripe.com/v1/checkout/sessions');
        request.setMethod('POST');
        // Header Section
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization','Bearer '+ accessToken);
        // Request for Body
        String body = 'success_url=' + EncodingUtil.urlEncode('https://example.com/success','UTF-8')
            + '&cancel_url=' + EncodingUtil.urlEncode('https://example.com/cancel','UTF-8')
            + allProducts
            + '&mode=payment'
            + '&payment_method_types[0]=' + EncodingUtil.urlEncode( 'card' ,'UTF-8')
            + '&customer=' + EncodingUtil.urlEncode(storeAccountStripeCustomerId ,'UTF-8');
        System.debug('body ---> ' + body);
        request.setBody(body);

        // Send http request to the Stripe API
        HttpResponse response = http.send(request);
        String customerResponse = null;

        // Parse the JSON response
        if(response.getStatusCode() != 201) {
            System.debug('### Status code ---> ' + response.getStatusCode() + '  ### Status --->  ' + response.getStatus());
            // System.debug('response.getBody() ----> ' + response.getBody());
            customerResponse = response.getBody();
        } else {
            System.debug(response.getBody());
        }
        // System.debug('customerResponse -----> ' + customerResponse);
        return customerResponse;
    }
}