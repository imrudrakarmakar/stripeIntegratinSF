import { LightningElement, api, track } from 'lwc';
import makeStripeCheckoutSession from "@salesforce/apex/StripeCallouts.makeStripeCheckoutSession";
import { NavigationMixin } from "lightning/navigation";

const options= [
    {label:'USD',value:'USD'},
    {label:'EUR',value:'EUR'},
    {label:'CAD',value:'CAD'},
    {label:'GBP',value:'GBP'},
    {label:'INR',value:'INR'}
];

export default class LwcEcommercePage extends LightningElement {
    @track options=options;
    strCheckoutURL;
    productPriceWithDecimal;

    storeHandleChange(event) {
        if (event.target.name == 'productName') {
            this.productName = event.target.value;
        }
        if (event.target.name == 'productPrice') {
            this.productPrice = event.target.value;
        }
        if (event.target.name == 'productQty') {
            this.productQty = event.target.value;
        }
        if (event.target.name == 'productCurrency') {
            this.productCurrency = event.target.value;
        }
    }

    handleClick(event) {
        console.log("-----> " + this.productName);
        console.log("-----> " + this.productPrice);
        console.log("-----> " + this.productQty);
        console.log("-----> " + this.productCurrency);
        this.productPriceWithDecimal = this.productPrice*100;
        makeStripeCheckoutSession({pName: this.productName, pPrice: this.productPriceWithDecimal, pQty: this.productQty, pCurr: this.productCurrency})
        .then(result => {
            console.log('Checkout session ---> ' +JSON.parse(JSON.stringify(result)));
            this.strCheckoutURL = JSON.parse(result).url;
            console.log('Payment url ----> ' + this.strCheckoutURL);
            // location.replace(this.strCheckoutURL);
            window.open(this.strCheckoutURL);
        }).catch(error=>{
            console.log('makeStripeCheckoutSession error ---> ' + error);
        });

        document.getElementsByName("productName").value = "";
        document.getElementsByName("productPrice").value = "";
        document.getElementsByName("productQty").value = "";
        document.getElementsByName("productCurrency").value = "";
    }
    
}