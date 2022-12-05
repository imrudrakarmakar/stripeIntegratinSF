@isTest
private class StripeCalloutsTest {
    private class StripeCallouts_HCM_TGN_TEST implements HttpCalloutMock{
        protected Integer code;
        protected String status;
        protected String body;
        protected Map<String,String> headers;
        public StripeCallouts_HCM_TGN_TEST(Integer code,String status,String body,Map<String,String> headers){
            this.code=code;
            this.status=status;
            this.body=body;
            this.headers=headers;
        }
        public HTTPResponse respond(HTTPRequest req){
            HttpResponse res=new HttpResponse();
            res.setStatusCode(this.code);
            res.setStatus(this.status);
            res.setBody(this.body);
            if(this.headers!=null){
                for(String key:this.headers.keySet()){
                    res.setHeader(key,this.headers.get(key));
                }
            }
            return res;
        }
    }
    @isTest
    private static void createStripeCustomer_TGN_TEST(){
        Test.startTest();
        StripeCallouts_HCM_TGN_TEST httpMock;
        httpMock=new StripeCallouts_HCM_TGN_TEST(200,'Complete','"a"',null);
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeCallouts.createStripeCustomer('a','a','a','a','a');
        httpMock=new StripeCallouts_HCM_TGN_TEST(200,'Complete','"a"',null);
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeCallouts.createStripeCustomer('','','','','');
        Test.stopTest();
    }
    @isTest
    private static void createPostCustomerCallout_TGN_TEST(){
        Test.startTest();
        StripeCallouts_HCM_TGN_TEST httpMock;
        httpMock=new StripeCallouts_HCM_TGN_TEST(200,'Complete','{}',null);
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeCallouts.createPostCustomerCallout();
        Test.stopTest();
    }
    @isTest
    private static void makePaymentMethod_TGN_TEST(){
        Test.startTest();
        StripeCallouts_HCM_TGN_TEST httpMock;
        httpMock=new StripeCallouts_HCM_TGN_TEST(200,'Complete','"a"',null);
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeCallouts.makePaymentMethod('a','a','a','a');
        httpMock=new StripeCallouts_HCM_TGN_TEST(200,'Complete','"a"',null);
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeCallouts.makePaymentMethod('','','','');
        Test.stopTest();
    }
    @isTest
    private static void createPostPaymentMethodCallout_TGN_TEST(){
        Test.startTest();
        StripeCallouts_HCM_TGN_TEST httpMock;
        httpMock=new StripeCallouts_HCM_TGN_TEST(200,'Complete','{}',null);
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeCallouts.createPostPaymentMethodCallout();
        Test.stopTest();
    }
    @isTest
    private static void attatchCustomerPaymentMethod_TGN_TEST(){
        Test.startTest();
        StripeCallouts_HCM_TGN_TEST httpMock;
        httpMock=new StripeCallouts_HCM_TGN_TEST(200,'Complete','"a"',null);
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeCallouts.attatchCustomerPaymentMethod('a','a');
        httpMock=new StripeCallouts_HCM_TGN_TEST(200,'Complete','"a"',null);
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeCallouts.attatchCustomerPaymentMethod('','');
        Test.stopTest();
    }
    @isTest
    private static void attatchPostCustomerPaymentMethodCallout_TGN_TEST(){
        Test.startTest();
        StripeCallouts_HCM_TGN_TEST httpMock;
        httpMock=new StripeCallouts_HCM_TGN_TEST(200,'Complete','{}',null);
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeCallouts.attatchPostCustomerPaymentMethodCallout();
        Test.stopTest();
    }
    @isTest
    private static void makeStripeCheckoutSession_TGN_TEST(){
        Test.startTest();
        StripeCallouts_HCM_TGN_TEST httpMock;
        httpMock=new StripeCallouts_HCM_TGN_TEST(200,'Complete','"a"',null);
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeCallouts.makeStripeCheckoutSession('a','a','a','a');
        httpMock=new StripeCallouts_HCM_TGN_TEST(200,'Complete','"a"',null);
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeCallouts.makeStripeCheckoutSession('','','','');
        Test.stopTest();
    }
    @isTest
    private static void makePostCheckoutSessionCallout_TGN_TEST(){
        Test.startTest();
        StripeCallouts_HCM_TGN_TEST httpMock;
        httpMock=new StripeCallouts_HCM_TGN_TEST(200,'Complete','{}',null);
        Test.setMock(HttpCalloutMock.class,httpMock);
        StripeCallouts.makePostCheckoutSessionCallout();
        Test.stopTest();
    }
    @isTest
    private static void StripeCallouts_TGN_TEST(){
        StripeCallouts obj = new StripeCallouts();
    }
}