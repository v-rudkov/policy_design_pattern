public without sharing class NoPolicy implements Policy {

    public Boolean isValid(SObject record) {
        return true;
    }

    public PolicyResult validate(SObject record) {
        PolicyResult result = new PolicyResult();
        result.success = true;
        return result;
    }
}
