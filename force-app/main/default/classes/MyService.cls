public without sharing class MyService {

    public static void process(Set<ID> leadIds) {

        // selecting
        List<Lead> leads = [select Id, Company, FirstName, LastName, Email, AnnualRevenue from Lead where Id in :leadIds and Industry = 'Finance'];

        // filtering
        List<Lead> leadsToProcess = new List<Lead>();
        for (Lead lead : leads) {
            if (lead.Email != null && lead.AnnualRevenue > 1000000) {
                leadsToProcess.add(lead);
            }
        }

        // processing
        Monitoring.log(leadsToProcess, new BillieException('Processing leads'));
    }
}
