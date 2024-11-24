# Policy Design Patten

A typical service class:

```
public class MyService {

    public static void process(Set<ID> leadIds) {

        // selecting
        List<Lead> leads = [select Id, Company, FirstName, LastName, Email, AnnualRevenue from Lead where Industry = 'Finance'];

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
```

```
insert new Lead(
    FirstName = 'John',
    LastName = 'Doe',
    Email = 'j.doe@example.com',
    Company = 'Acme',
    Industry = 'Finance',
    AnnualRevenue = 2500000
);
```

    ID leadId = '00Q9V00000K7KmTUAV';
    MyService.process(new Set<ID>{ leadId });
