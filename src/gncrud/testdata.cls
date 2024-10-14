Class gncrud.testdata
{

/// Operation or Statement
ClassMethod MakeAction(pOneOf As %String = "") As gncrud.model.Action
{
	If (pOneOf = "Statement") {
		
	} Else {
		Quit ..MakeOperation()
	}
	Quit ""
}

ClassMethod MakeCall(pFlag As %String = 0) As gncrud.model.Call
{
	Set call = ##class(gncrud.model.Call).%New()
	Set pAction = "Operation"
	Set call.actions = ##class(%Library.ListOfDataTypes).%New()
	Do call.actions.Insert(..MakeAction(pAction))
	Set call.correlationid = "111111111"
	If pFlag {
		Set call.istransactional = 1
	} Else {
		Set call.istransactional = 0
	}
	Quit call
}

ClassMethod MakeField(pFile As %String = "") As gncrud.model.Field
{
	//Set field = ##class(gncrud.model.Field).%New()
	Set field = ##class(VistA.FileMan.Utility).GetField(pFile)
	//Set field.id = 12
	//Set field.name = "COMPLETION NOTE"
	Set field.primitiveValue = "My masterful comment."
	//Set field.valuetype = "WORD-PROCESSING"
	If (field.valuetype ? 1"WORD-PROCESSING".E) { Set field.valuetype = "WORD-PROCESSING" }
	Quit field
}

ClassMethod MakeOperation() As gncrud.model.Operation
{
	Set operation = ##class(gncrud.model.Operation).%New()
	Set operation.entitytype = "Operation"
	Set operation.operation = "CREATE"
	Set operation.record = ..MakeRecord()
	Quit operation
}

ClassMethod MakeRecord() As gncrud.model.VistaResponserecords
{
	Set tFileManFileNo = 123  // REQUEST/CONSULTATION
	Set tFileManFileNo = 668  // PROSTHETIC SUSPENSE
	Set record = ##class(gncrud.model.VistaResponserecords).%New()
	//Set record.id = 668
	Set record.id = ##class(VistA.FileMan.Utility).GetFileNo(.f)
	Set record.fields = ##class(%Library.ListOfDataTypes).%New()
	Do record.fields.Insert(..MakeField(record.id))
	Quit record
}

ClassMethod test() As %Status
{
	Set dynObj = {}
	Set dynObj.calls = []
	Set call = ..MakeCall()
	//zw call
	do call.%JSONExportToString(.pCallStr)
	Do dynObj.calls.%Push({}.%FromJSON(pCallStr))
	Set dynObj."site_id" = "12345"
	//zw dynObj.%ToJSON()
	zw dynObj
	Quit $$$OK
}

}
