package com.acq;
public enum AcqStatusDefination
{
		ClientError("", 1),
		ServerError("Server Error", 2),
		RollBackError("Rollback Error", 100),
		UserValidationError("Users Validation Errors", 102),
		UserAccessError("Invalid Users", 101),
		NotFound("Not Found", 101),
		UserNotFound("Users Not Found", 101),
		RecordNotFound("Records Not Found", 0),
		PGError("Payment gateway Connection Errors", 301),
		PGUserCredentialsError("Users Card details Error", 302),
		OK("OK", 0),
		PayoutNotFound("Payout Not found for given date", 100),
		InvalidSession("Session Expired", 111),
		InvalidCrediential("Invalid Crediential", 100);
	
	private String Details;
	private int Identifier;
	private AcqStatusDefination(String Details, int Identifier)
	{
		this.Details = Details;
		this.Identifier = Identifier;
	}
	public String getDetails()
	{
		return Details;
	}
	public int getIdentifier()
	{
		return Identifier;
	}
}