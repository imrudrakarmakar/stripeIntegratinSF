trigger StripeApexTrigger on Account (after insert) {
    if(trigger.isInsert || trigger.isAfter) {
        StripeApexCallouts.getAccountDetails(Trigger.new);
    }
}