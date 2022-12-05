@isTest
private class NewsAPIcontrollerTest {
    @isTest static  void NewsAPIcontrollerTest() {
        String demoEndpoint = 'test';
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetNewsApiResource');
        mock.setStatusCode(200);
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        // HttpResponse result = NewsAPIcontroller.getSearchedNews(demoEndpoint);
        // // Verify mock response is not null
        // System.assertNotEquals(null,result, 'The callout returned a null response.');
        // // Verify status code
        // System.assertEquals(200,result.getStatusCode(), 'The status code is not 200.');
        // // Verify content type   
        // //System.assertEquals('application/json;charset=UTF-8', result.getHeader('Content-Type'),'The content type value is not expected.');  
        // // Verify the array contains 3 items     
        // Map<String, Object> results = (Map<String, Object>) 
        //     JSON.deserializeUntyped(result.getBody());
        // List<Object> articles = (List<Object>) results.get('articles');
        // System.assertEquals(3, articles.size(), 'The array should only contain 3 items.');  
    }
}
