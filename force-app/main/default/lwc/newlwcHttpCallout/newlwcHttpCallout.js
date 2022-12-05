import { LightningElement, track } from 'lwc';
import getSearchedNews from '@salesforce/apex/NewsAPIcontroller.getSearchedNews';
import NewsAPIkey from '@salesforce/label/c.NewsAPI';
// import newsAPIcontroller from '@salesforce/apex/NewsAPIcontroller.getNews';

const options= [
    {label:'Business',value:'business'},
    {label:'Entertainment',value:'entertainment'},
    {label:'General',value:'general'},
    {label:'Health',value:'health'},
    {label:'Science',value:'science'},
    {label:'Sports',value:'sports'},
    {label:'Technology',value:'technology'}
];

export default class NewlwcHttpCallout extends LightningElement {
    @track result = [];
    @track newsApiData=false;
    
    // get top headline
    handleNewsApi() {
        let endpoint = 'https://newsapi.org/v2/top-headlines?country=in&pageSize=5&page=5&apiKey='+NewsAPIkey;
        getSearchedNews({ strEndPointURL : endpoint })
        .then(data =>{
            window.console.log('jsonresponse ===>'+JSON.stringify(data));
            this.formatNewsData(data.articles)
        })
        this.newsApiData=true;
    }

    // Search function
    @track newsSearchInput;
    handleSearchInput(event) {
        this.newsSearchInput = event.detail.value;
        console.log(' this.newsSearchInput ----> ' +  this.newsSearchInput);
    }
    handleSearch() {
        let endpoint = 'https://newsapi.org/v2/everything?q='+this.newsSearchInput+'&pageSize=5&page=5&apiKey='+NewsAPIkey;
        getSearchedNews({ strEndPointURL : endpoint })
        .then(data =>{
            window.console.log('jsonresponse ===>'+JSON.stringify(data));
            this.formatNewsData(data.articles)
        })
        this.newsApiData=true;
    }
    formatNewsData(res){
        this.result = res.map((item, index)=>{
            let id = `new_${index+1}`;
            let date = new Date(item.publishedAt).toDateString()
            let name = item.source.name;
            let urlToImage = item.urlToImage;
            let content = item.content;
            let description = item.description;
            return { ...item, id: id, name: name, urlToImage: urlToImage, date: date, content: content, description: description}
        })
    }
    

   
    // Category
    @track options=options;
    @track newsByCategoryValue;
    @track newsApiDataByCategory = false;

    handleCategoryNewsName(event) {
        this.newsByCategoryValue = event.detail.value;
        console.log('this.newsByCategoryValue ---> '+ this.newsByCategoryValue);
    }

    handleCategoryNews() {
        let endpoint = 'https://newsapi.org/v2/top-headlines/sources?category='+this.newsByCategoryValue+'&apiKey='+NewsAPIkey;
        getSearchedNews({ strEndPointURL : endpoint })
        .then(data =>{
            window.console.log('jsonresponse ===>'+JSON.stringify(data));
            this.formatNewsDataByCategory(data.sources)
        })
        newsApiDataByCategory = true;
    }

    formatNewsDataByCategory(res){
        this.result = res.map((itemByCategory, index)=>{
            let id = `new_${index+1}`;
            let name = itemByCategory.name;
            let description = itemByCategory.description;
            return { ...itemByCategory, id: id, name: name, description: description}
        })
    }






    // connectedCallback(){
    //     this.fetchNews();
    // }

    // fetchNews(){
    //     newsAPIcontroller().then(response=>{
    //         console.log(response);
    //         this.formatNewsData(response.articles)
    //     }).catch(error=>{
    //         console.error(error);
    //     })
    // }

    // formatNewsData(res){
    //     this.result = res.map((item, index)=>{
    //         let id = `new_${index+1}`;
    //         let date = new Date(item.publishedAt).toDateString()
    //         let name = item.source.name;
    //         // let urlToImage = item.urlToImage;
    //         let content = item.content;
    //         let description = item.description;
    //         return { ...item, id: id, name: name, date: date, content: content, description: description}
    //     })

    // }
    
}