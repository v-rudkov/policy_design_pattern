public without sharing class LeadPolicy implements Policy {

    public Boolean isValid(SObject record) {
        return this.validate(record).success;
    }

    public PolicyResult validate(SObject record) {

        PolicyResult result = new PolicyResult();
        Lead lead = (Lead) record;

        if (lead.Industry != 'Finance') result.errors.add('Industry is not Finance');
        if (String.isBlank(lead.Email)) result.errors.add('Email is blank');
        if (lead.AnnualRevenue <= 1000000) result.errors.add('AnnualRevenue is less or equal 1_000_000');

        result.success = result.errors.isEmpty();

        return result;
    }
}
