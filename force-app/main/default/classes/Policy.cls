public interface Policy {

    Boolean isValid(SObject record);

    PolicyResult validate(SObject record);

}
