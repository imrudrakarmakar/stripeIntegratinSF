@isTest
private class StripeApexCalloutsTest {

    // Customer Mock
    public class test_StripeApexCalloutsCustomerMockTest implements HttpCalloutMock {
        // Implement this interface method
        public HTTPResponse respond(HTTPRequest request) {
            // Create a fake response
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            response.setBody('{"example":"test"}');
            response.setStatusCode(200);
            return response; 
        }
    }

    // Checkout Mock
    public class test_StripeApexCalloutsCheckoutMockTest implements HttpCalloutMock {
        // Implement this interface method
        public HTTPResponse respond(HTTPRequest request) {
            // Create a fake response
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            response.setBody('{"example":"test"}');
            response.setStatusCode(200);
            return response; 
        }
    }

    @isTest(SeeAllData=true)
    static void test_getAccountDetails() {
        List<Account> accList = new List<Account>();
        Account testAccount;
        for(Integer i=0; i<1 ;i++){
        	testAccount = new Account( Name='Test-Account-Name', Phone='987654321', Email__c='paymenttest@mail.com', BillingStreet='Test-Address', BillingCity='NYC', BillingState='USA', BillingPostalCode='10016', BillingCountry='United States');
        	accList.add(testAccount);
        }
        
        Test.startTest();
        test_StripeApexCalloutsCustomerMockTest httpMock;
        httpMock=new test_StripeApexCalloutsCustomerMockTest();
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeApexCallouts.getAccountDetails(accList);
        Test.stopTest();

        // Test.startTest();
        // test_StripeApexCalloutsCustomerMockTest httpMock;
        // httpMock=new test_StripeApexCalloutsCustomerMockTest();
        // Test.setMock(HttpCalloutMock.class,httpMock);
        // try {
            // StripeApexCallouts.getAccountDetails(new List<Account>{new Account()});
            // StripeApexCallouts.getAccountDetails(new List<Account>{new Account(Id='0015h000012u2EfAAI', Name='Test-Account-Name', Phone='987654321', Email__c='paymenttest@mail.com', BillingStreet='Test-Address', BillingCity='NYC', BillingState='USA', BillingPostalCode='10016', BillingCountry='United States')});
            // StripeApexCallouts.createPostCustomerCallout('0015h000012u2EfAAI', 'Test-Account-Name', '987654321', 'paymenttest@mail.com', 'Test-Address', 'NYC', 'USA', '10016', 'United States');
        // } catch(Exception e) {}
        // httpMock=new test_StripeApexCalloutsCustomerMockTest();
        // Test.setMock(HttpCalloutMock.class,httpMock);
        // StripeApexCallouts.getAccountDetails(null);
        // Test.stopTest();
    }

    @isTest(SeeAllData=true)
    static void test_createPostCustomerCallout(){
        Test.startTest();
        test_StripeApexCalloutsCustomerMockTest httpMock;
        httpMock=new test_StripeApexCalloutsCustomerMockTest();
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeApexCallouts.createPostCustomerCallout('0015h000012u2EfAAI', 'Test-Account-Name', '987654321', 'paymenttest@mail.com', 'Test-Address', 'NYC', 'USA', '10016', 'United States');
        StripeApexCallouts.insertStripeCustomerIdToAccount('0015h000012u2EfAAI', 'cus_0000');
        Test.stopTest();
    }

    @isTest(SeeAllData=true)
    static void test_insertStripeCustomerIdToAccount(){
        Test.startTest();
        Test.stopTest();
    }

    @isTest(SeeAllData=true)
    static void test_getCheckoutOrderDetails() {

        // Database.SaveResult dsr;
        // OrderItem drOrderItem;
        // drOrderItem=new OrderItem(OrderId='802x00000000000AAA',PricebookEntryId='802x00000000000AAA',Quantity=123);
        // dsr=Database.insert(drOrderItem,false);
        // Test.startTest();
        // StripeApexCallouts_HCM_TGN_TEST httpMock;
        // httpMock=new StripeApexCallouts_HCM_TGN_TEST(200,'Complete','"a"',null);
        // Test.setMock(HttpCalloutMock.class,httpMock);
        // StripeApexCallouts.getCheckoutOrderDetails('a');
        // httpMock=new StripeApexCallouts_HCM_TGN_TEST(200,'Complete','"a"',null);
        // Test.setMock(HttpCalloutMock.class,httpMock);
        // StripeApexCallouts.getCheckoutOrderDetails('');
        // Test.stopTest();

        Test.startTest();
        StripeApexCallouts.getCheckoutOrderDetails('8015h000000qE9kAAE');
        Test.stopTest();
    }

    @isTest(SeeAllData=true)
    private static void test_createPostCheckoutOrderCallout(){
        Test.startTest();
        test_StripeApexCalloutsCheckoutMockTest httpMock;
        httpMock=new test_StripeApexCalloutsCheckoutMockTest();
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeApexCallouts.createPostCheckoutOrderCallout('a');
        Test.stopTest();
    }

    // @isTest
    // static void test_createPostCustomerCallout() {
        
        // Set mock callout class 
        // Test.setMock(HttpCalloutMock.class, new StripeApexCalloutsCustomerMockTest());
        
        // Test.startTest();
        // Call method to test.
        // HttpResponse result = StripeApexCallouts.createPostCustomerCallout('0015h000012u2EfAAI', 'Test-Account-Name', '987654321', 'paymenttest@mail.com', 'Test-Address', 'NYC', 'USA', '10016', 'United States');
        // HttpResponse result = StripeApexCallouts.createPostCustomerCallout();
        // StripeApexCallouts.createPostCustomerCallout('0015h000012u2EfAAI', 'Test-Account-Name', '987654321', 'paymenttest@mail.com', 'Test-Address', 'NYC', 'USA', '10016', 'United States');
        // HttpResponse result = StripeApexCallouts.createPostCustomerCallout('0015h000012u2EfAAI', 'Test-Account-Name', '987654321', 'paymenttest@mail.com', 'Test-Address', 'NYC', 'USA', '10016', 'United States');
        // Test.stopTest();
        
        // Verify response received contains fake values
        // String contentType = result.getHeader('Content-Type');
        // System.assert(contentType == 'application/x-www-form-urlencoded');
        // String actualValue = result.getBody();
        // String expectedValue = '{"example":"test"}';
        // System.assertEquals(actualValue, expectedValue);
        // System.assertEquals(200, result.getStatusCode());
        
        // // Verify mock response is not null
        // System.assertNotEquals(null,result, 'The callout returned a null response.');
        // // Verify status code
        // System.assertEquals(200,result.getStatusCode(), 'The status code is not 200.');
        // // Verify content type   
        // System.assertEquals('application/x-www-form-urlencoded, result.getHeader('Content-Type'), 'The content type value is not expected.');
    // }
}