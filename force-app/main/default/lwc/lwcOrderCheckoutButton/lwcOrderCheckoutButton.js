import { LightningElement, api, wire } from 'lwc';
import { getRecord } from "lightning/uiRecordApi";
import getCheckoutOrderDetails from "@salesforce/apex/StripeApexCallouts.getCheckoutOrderDetails";

export default class LwcOrderCheckoutButton extends LightningElement {

    @api recordId; 
    @wire(getRecord, { recordId: '$recordId' }) order;

    handleClick() {
        console.log('orderid--->'+this.recordId);
        getCheckoutOrderDetails({orderId: this.recordId})
        .then(result => {
            console.log('Checkout session ---> ' +JSON.parse(JSON.stringify(result)));
            this.strCheckoutURL = JSON.parse(result).url;
            console.log('Payment url ----> ' + this.strCheckoutURL);
            window.open(this.strCheckoutURL);
        }).catch(error=>{
            console.log('getCheckoutOrderDetails error ---> ' + error);
        });
    }

}