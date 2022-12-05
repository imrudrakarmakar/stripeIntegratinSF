import { LightningElement } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import makePaymentMethod from "@salesforce/apex/StripeCallouts.makePaymentMethod";

export default class LwcStripePaymentMethod extends LightningElement { 
    storeHandleChange(event) {
        if (event.target.name == 'customerName') {
            this.storeCustomerName = event.target.value;
        }
        if (event.target.name == 'customerCardNumber') {
            this.storeCustomerCardNumber = event.target.value;
        }
        if (event.target.name == 'customerExpMonth') {
            this.storeExpMonth = event.target.value;
        }
        if (event.target.name == 'customerExpYear') {
            this.storeExpYear = event.target.value;
        }
        if (event.target.name == 'customerCVV') {
            this.storeCVV = event.target.value;
        }
    }

    paymentMethodHandleClick() {
        console.log("-----> " + this.storeCustomerName);
        console.log("-----> " + this.storeCustomerCardNumber);
        console.log("-----> " + this.storeExpMonth);
        console.log("-----> " + this.storeExpYear);
        console.log("-----> " + this.storeCVV);
        makePaymentMethod({cName: this.storeCustomerName, cCardNum: this.storeCustomerCardNumber, cExpMonth: this.storeExpMonth, cExpYear: this.storeExpYear, cCVV: this.storeCVV})
        .then(result => {
            console.log(JSON.stringify(result));
            refreshApex();
        }).catch(error=>{
            console.log(error);
        });
    }
}