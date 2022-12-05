public with sharing class StripeCustomersApiWrapper {

    public class customers{
        public String id;	//cus_9BoKyB2Km2T7TE
        public String stripe_object;	//customer
        public cls_address address;
        public Integer balance;	//0
        public Integer created;	//1473810745
        public String stripe_currency;	//usd
        public String default_source;	//card_18tQhR2eZvKYlo2CuNh554KH
        public boolean delinquent;
        public cls_description description;
        public cls_discount discount;
        public String email;	//sadfdsf@sdaf.daf
        public String invoice_prefix;	//2ACFF7A
        public cls_invoice_settings invoice_settings;
        public boolean livemode;
        public cls_metadata metadata;
        public String name;	//sdafsdf sdf
        public Integer next_invoice_sequence;	//85268
        public String phone;	//+995315324234
        public cls_preferred_locales[] preferred_locales;
        public cls_shipping shipping;
        public String tax_exempt;	//none
        public cls_test_clock test_clock;
    }
    class cls_address {
        public String city;	//Tbilisi
        public String country;	//GE
        public String line1;	//212134
        public String line2;	//124234
        public String postal_code;	//12343
        public String state;
    }
    // class cls_state {
    // }
    class cls_description {
    }
    class cls_discount {
    }
    class cls_invoice_settings {
        public cls_custom_fields custom_fields;
        public cls_default_payment_method default_payment_method;
        public cls_footer footer;
        public cls_rendering_options rendering_options;
    }
    class cls_custom_fields {
    }
    class cls_default_payment_method {
    }
    class cls_footer {
    }
    class cls_rendering_options {
    }
    class cls_metadata {
        public String order_id;	//6735
        public String organizationId;	//are7v9tZeZXY1gKQ1GmHX6
    }
    class cls_preferred_locales {
    }
    class cls_shipping {
    }
    class cls_test_clock {
    }
    public static customers parse(String json){
        return (customers) System.JSON.deserialize(json, customers.class);
    }
    
}
