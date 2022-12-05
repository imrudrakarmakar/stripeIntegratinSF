import { LightningElement, api, track } from 'lwc';
import createStripeCustomer from "@salesforce/apex/StripeCallouts.createStripeCustomer";
import makePaymentMethod from "@salesforce/apex/StripeCallouts.makePaymentMethod";
import attatchCustomerPaymentMethod from "@salesforce/apex/StripeCallouts.attatchCustomerPaymentMethod";
import makeStripeCheckoutSession from "@salesforce/apex/StripeCallouts.makeStripeCheckoutSession";

const options= [
    {label:'USD',value:'USD'},
    {label:'EUR',value:'EUR'},
    {label:'CAD',value:'CAD'},
    {label:'GBP',value:'GBP'},
    {label:'INR',value:'INR'}
];

export default class LwcStripeCreateCustomer extends LightningElement {
    strCustomerID;
    strPaymentMethodID;
    
    @track options=options;
    strCheckoutURL;
    productPriceWithDecimal;

    storeHandleChange(event) {
        if (event.target.name == 'customerName') {
            this.storeCustomerName = event.target.value;
        }
        if (event.target.name == 'customerPhone') {
            this.storeCustomerPhone = event.target.value;
        }
        if (event.target.name == 'customerEmail') {
            this.storeCustomerEmail = event.target.value;
        }
        if (event.target.name == 'customerCity') {
            this.storeCustomerCity = event.target.value;
        }
        if (event.target.name == 'customerCountry') {
            this.storeCustomerCountry = event.target.value;
        }

        // Card details 
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

        // Checkout
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

    customerHandleClick() {

        console.log("-----> " + this.storeCustomerName);
        console.log("-----> " + this.storeCustomerPhone);
        console.log("-----> " + this.storeCustomerEmail);
        console.log("-----> " + this.storeCustomerCity);
        console.log("-----> " + this.storeCustomerCountry);
        
        console.log("-----> " + this.storeCustomerCardNumber);
        console.log("-----> " + this.storeExpMonth);
        console.log("-----> " + this.storeExpYear);
        console.log("-----> " + this.storeCVV);

        console.log("-----> " + this.productName);
        console.log("-----> " + this.productPrice);
        console.log("-----> " + this.productQty);
        console.log("-----> " + this.productCurrency);
        this.productPriceWithDecimal = this.productPrice*100;
        
        // Create customer get customer id
        createStripeCustomer({cName: this.storeCustomerName, cPhone: this.storeCustomerPhone, cEmail: this.storeCustomerEmail, cCity: this.storeCustomerCity, cCountry: this.storeCustomerCountry})
        .then(customerResult => {
            console.log('Customer created ---> ' +JSON.parse(JSON.stringify(customerResult)));
            console.log('Customer ID ---> ' +JSON.parse(customerResult).id);
            this.strCustomerID = JSON.parse(customerResult).id;

            // create payment method get payment id
            makePaymentMethod({ cCardNum: this.storeCustomerCardNumber, cExpMonth: this.storeExpMonth, cExpYear: this.storeExpYear, cCVV: this.storeCVV})
            .then(paymentResult => {
                console.log('Payment Method created ---> ' +JSON.parse(JSON.stringify(paymentResult)));
                console.log('Payment Method ID ---> ' +JSON.parse(paymentResult).id);
                this.strPaymentMethodID = JSON.parse(paymentResult).id;

                // Attatch Customer Payment method
                attatchCustomerPaymentMethod({ cusAttCustomerID: this.strCustomerID, cusAttCardId: this.strPaymentMethodID })
                .then(result => {
                    console.log('Customer Payment Method attached ---> ' +JSON.parse(JSON.stringify(result)));

                }).catch(error=>{
                    console.log('attatchCustomerPaymentMethod error ---> ' + error);
                });
            }).catch(error=>{
                console.log('makePaymentMethod error ---> ' + error);
            });

            // Checkout section
            makeStripeCheckoutSession({pName: this.productName, pPrice: this.productPriceWithDecimal, pQty: this.productQty, pCurr: this.productCurrency, pCustomerId: this.strCustomerID})
            .then(result => {
                console.log('Checkout session ---> ' +JSON.parse(JSON.stringify(result)));
                this.strCheckoutURL = JSON.parse(result).url;
                console.log('Payment url ----> ' + this.strCheckoutURL);
                // location.replace(this.strCheckoutURL);
                window.open(this.strCheckoutURL);
            }).catch(error=>{
                console.log('makeStripeCheckoutSession error ---> ' + error);
            });


        }).catch(error=>{
            console.log('createStripeCustomer error ---->  '+ error);
        });

       

       
    }
}