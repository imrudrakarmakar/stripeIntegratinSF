public with sharing class NewsAPIcontroller {
    @AuraEnabled
    public static Map<String, Object> getSearchedNews(String strEndPointURL){
        Map<String, Object> news = new Map<String, Object>();
        String strResponse=null;
        if(string.isNotBlank(strEndPointURL))
        {
            HttpRequest request = new HttpRequest();
            request.setEndpoint(strEndPointURL);
            request.setMethod('GET');
            try {
                Http http = new Http();
                HttpResponse response = http.send(request);
                // Sussess =>
                if(response.getStatusCode() == 200) {
                    strResponse = response.getBody();
                    System.debug('strResponse => ' + strResponse);
                } else {
                    System.debug('response.getBody() => ' + response.getBody());
                    throw new CalloutException(response.getBody());
                }
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        if(!String.isBlank(strResponse)) {
            news = (Map<String,Object>)JSON.deserializeUntyped(strResponse);
            System.debug('news => ' + news);
        }
        // return data
        if(!news.isEmpty()) {
            return news;
        } else {
            return null;
        }
    }
    
    // @AuraEnabled
    // public static Map<String, Object> getNews(){
    //     // Setup callout request
    //     HttpRequest request = new HttpRequest();
    //     String endpointURL = 'https://newsapi.org/v2/top-headlines?country=in&pageSize=5&page=5&apiKey=176b2218090a48a9bce3edaa4ddcd930';
    //     request.setEndpoint(endpointURL);
    //     System.debug('endpointURL => ' + endpointURL);
    //     request.setMethod('GET');
    //     // Create Map to store the data
    //     Map<String, Object> news = new Map<String, Object>();
    //     String strResponse = null;

    //     // try {
    //         // Send request
    //         Http http = new Http();
    //         HttpResponse response = http.send(request);
    //         // Sussess =>
    //         if(response.getStatusCode() == 200) {
    //             strResponse = response.getBody();
    //             System.debug('strResponse => ' + strResponse);
    //         } else {
    //             System.debug('response.getBody() => ' + response.getBody());
    //             throw new CalloutException(response.getBody());
    //         }
    //     // } catch (Exception e) {
    //     //    throw new AuraHandledException(e.getMessage());
    //     // }
    //     // Check is reposne isnot blank then store data in news
    //     if(!String.isBlank(strResponse)) {
    //         news = (Map<String,Object>)JSON.deserializeUntyped(strResponse);
    //         System.debug('news => ' + news);
    //     }
    //     // return data
    //     if(!news.isEmpty()) {
    //         return news;
    //     } else {
    //         return null;
    //     }
    // }

    
}