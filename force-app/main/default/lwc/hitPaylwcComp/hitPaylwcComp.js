import { LightningElement, track, api } from 'lwc';
import makePaymentPostRequest from "@salesforce/apex/HitPayCallout.postPaymentRequest";

const options= [
    {label:'USD',value:'USD'},
    {label:'EUR',value:'EUR'},
    {label:'CAD',value:'CAD'},
    {label:'GBP',value:'GBP'},
    {label:'INR',value:'INR'}
];

export default class HitPaylwcComp extends LightningElement {
    
    @track options=options;

    storeHandleChange(event) {
        if (event.target.name == 'paymentAmount') {
            this.paymentAmount = event.target.value;
        }
        if (event.target.name == 'paymentCurrency') {
            this.paymentCurrency = event.target.value;
        }
    }

    handlePaymentClick(event) {
        console.log("this.paymentAmount -----> " + this.paymentAmount);
        console.log("this.paymentCurrency -----> " + this.paymentCurrency);
        postPaymentRequest({String: this.paymentAmount, String: this.paymentCurrency });
    }
}