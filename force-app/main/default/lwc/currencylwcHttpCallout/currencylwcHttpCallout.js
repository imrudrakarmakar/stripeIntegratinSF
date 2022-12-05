import { LightningElement, track } from 'lwc';
import getCurrencyDataa from '@salesforce/apex/CurrencyConversioncontroller.retrieveCurrencyConversionrates';

const options= [
    {label:'USD',value:'USD'},
    {label:'EUR',value:'EUR'},
    {label:'CAD',value:'CAD'},
    {label:'GBP',value:'GBP'},
    {label:'INR',value:'INR'}
];

export default class CurrencylwcHttpCallout extends LightningElement {
    @track fromCurrencyValue;
    @track toCurrencyValue;
    @track options=options;
    @track toCurrencyOptions=options;
    @track conversionData;

    handleFromCurrencyChange(event)
    {
        this.fromCurrencyValue=event.detail.value;
        console.log('this.fromCurrencyValue=> '+this.fromCurrencyValue);
    }

    handleToCurrencyChange(event)
    {
        this.toCurrencyValue=event.detail.value;
        console.log('this.toCurrencyValue=> '+this.toCurrencyValue);
    }

    handleCurrencyConversion() {
        // fetch('https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency='+this.fromCurrencyValue+'&to_currency='+this.toCurrencyOptions+'&apikey=U4UO3MH7LMMJSGFF', 
        //fetch('https://www.alphavantage.co/query?function=FX_INTRADAY&from_symbol='+this.fromCurrencyValue+'&to_symbol='+this.toCurrencyValue+'&interval=5min&apikey=U4UO3MH7LMMJSGFF', 
        // fetch('https://www.alphavantage.co/query?function=FX_DAILY&from_symbol='+this.fromCurrencyValue+'&to_symbol='+this.toCurrencyValue+'&apikey=U4UO3MH7LMMJSGFF',
        // {
        //     method: "GET",
        //     headers : {
        //         "Content-type" : "application/json",
        //         "Authorization" : "OAuth 00D5g00000FEEfY!AQkAQHfOyT6VuZzmRjUhABu6NJzm5UpST2hIo1Le.uVrfKpqc7MDwLLQ11r5U9LJRoHkWkmjUC3dOMMqfsI3lxMfLwbIsvWa"
        //     }
        // }
        //let endpoint='https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency='+this.fromCurrencyValue+'&to_currency='+this.toCurrencyValue+'&apikey=U4UO3MH7LMMJSGFF';
        let endpoint='https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency='+this.fromCurrencyValue+'&to_currency='+this.toCurrencyValue+'&apikey=T7D99X93HVJPZF9S';
        getCurrencyDataa({strEndPointURL : endpoint})
        .then(data =>{
            let objData={
                From_Currency_Name:'',
                From_Currency_Code:'',
                To_Currency_Name:'',
                To_Currency_Code:'',
                Last_Refreshed:'',
                Exchange_rate:''
            };
            window.console.log('jsonresponse ===>'+JSON.stringify(data));
            let exchangeData=data['Realtime Currency Exchange Rate'];
            window.console.log('exchangeData==>'+JSON.stringify(exchangeData));

            objData.From_Currency_Code=exchangeData['1. From_Currency Code'];
            objData.From_Currency_Name=exchangeData['2. From_Currency Name'];
            objData.To_Currency_Name=exchangeData['4. To_Currency Name'];
            objData.To_Currency_Code=exchangeData['3. To_Currency Code'];
            objData.Last_Refreshed=exchangeData['6. Last Refreshed'];
            objData.Exchange_rate=exchangeData['5. Exchange Rate'];
            this.conversionData=objData;
            window.console.log('objData => '+JSON.stringify(objData));
        }).catch(error => {
            window.console.log('callout error ===>'+JSON.stringify(error));
        })
    }
}