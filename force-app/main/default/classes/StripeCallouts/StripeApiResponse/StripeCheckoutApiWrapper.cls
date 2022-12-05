public with sharing class StripeCheckoutApiWrapper {
    public class checkout{
        public String id;	
        public String stripe_object;
        public cls_after_expiration after_expiration;
        public cls_allow_promotion_codes allow_promotion_codes;
        public cls_amount_subtotal amount_subtotal;
        public cls_amount_total amount_total;
        public cls_automatic_tax automatic_tax;
        public cls_billing_address_collection billing_address_collection;
        public String cancel_url;
        public cls_client_reference_id client_reference_id;
        public cls_consent consent;
        public cls_consent_collection consent_collection;
        public Integer created;	
        public cls_currency stripe_currency;
        public cls_customer customer;
        public cls_customer_creation customer_creation;
        public cls_customer_details customer_details;
        public cls_customer_email customer_email;
        public Integer expires_at;	
        public boolean livemode;
        public cls_locale locale;
        public cls_metadata metadata;
        public String mode;	
        public String payment_intent;	
        public cls_payment_link payment_link;
        public cls_payment_method_collection payment_method_collection;
        public cls_payment_method_options payment_method_options;
        public cls_payment_method_types[] payment_method_types;
        public String payment_status;
        public cls_phone_number_collection phone_number_collection;
        public cls_recovered_from recovered_from;
        public cls_redaction redaction;
        public cls_setup_intent setup_intent;
        public cls_shipping_address_collection shipping_address_collection;
        public cls_shipping_cost shipping_cost;
        public cls_shipping_details shipping_details;
        public cls_shipping_options[] shipping_options;
        public String status;	
        public cls_submit_type submit_type;
        public cls_subscription subscription;
        public String success_url;	
        public cls_total_details total_details;
        public cls_url url;
    }
    class cls_after_expiration {
    }
    class cls_allow_promotion_codes {
    }
    class cls_amount_subtotal {
    }
    class cls_amount_total {
    }
    class cls_automatic_tax {
        public boolean enabled;
        public cls_status status;
    }
    class cls_status {
    }
    class cls_billing_address_collection {
    }
    class cls_client_reference_id {
    }
    class cls_consent {
    }
    class cls_consent_collection {
    }
    class cls_currency {
    }
    class cls_customer {
    }
    class cls_customer_creation {
    }
    class cls_customer_details {
    }
    class cls_customer_email {
    }
    class cls_locale {
    }
    class cls_metadata {
    }
    class cls_payment_link {
    }
    class cls_payment_method_collection {
    }
    class cls_payment_method_options {
    }
    class cls_payment_method_types {
        public String card;
    }
    class cls_phone_number_collection {
        public boolean enabled;
    }
    class cls_recovered_from {
    }
    class cls_redaction {
    }
    class cls_setup_intent {
    }
    class cls_shipping_address_collection {
    }
    class cls_shipping_cost {
    }
    class cls_shipping_details {
    }
    class cls_shipping_options {
    }
    class cls_submit_type {
    }
    class cls_subscription {
    }
    class cls_total_details {
    }
    class cls_url {
    }
}
