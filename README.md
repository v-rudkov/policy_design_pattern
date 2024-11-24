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

Problems:
    - filtering logic is not isolated (in the example above, part of it is in the selecting, another part is in the filtering)
    - if a record doesn't meet the filtering criteria it's not obvious why
    - this approach doesn't support bypassing filtering logic in an edge case scenario (where we deliberately want the service to process a record that formally doesn't meet the filtering criteria)
