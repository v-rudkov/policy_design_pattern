public class PolicyResult {

    public Boolean success;
    public List<String> errors = new List<String>();

    public Boolean failed {
        get {
            return ! this.success;
        }
    }

    public MessageForAdmin__e getErrorMessage(SObject record) {
        return Monitoring.getErrorMessage(
            new Map<String, Object>{
                'record' => record,
                'errors' => this.errors
            },
            new BillieException('POLICY_EXCEPTION', 'Policy requirements not met')
        );
    }
}
