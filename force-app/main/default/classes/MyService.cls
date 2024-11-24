public without sharing class MyService {

    public static void process(Set<ID> leadIds) {
        Policy defaultPolicy = new LeadPolicy();
        process(leadIds, defaultPolicy);
    }

    public static void process(Set<ID> leadIds, Policy policy) {

        // selecting
        List<Lead> leads = [select Id, Company, Industry, FirstName, LastName, Email, AnnualRevenue from Lead where Id in :leadIds];

        List<MessageForAdmin__e> errors = new List<MessageForAdmin__e>();

        // filtering
        List<Lead> leadsToProcess = new List<Lead>();
        for (Lead lead : leads) {

            PolicyResult validation = policy.validate(lead);

            if (validation.failed) {
                errors.add(validation.getErrorMessage(lead));
                continue;
            }

            leadsToProcess.add(lead);
        }

        // processing
        Monitoring.log(errors);
        Monitoring.log(leadsToProcess, new BillieException('Processing leads'));
    }
}
