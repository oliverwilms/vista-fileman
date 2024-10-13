Class VistA.FileMan.Utility
{

ClassMethod ExecuteQueryOneValue(
	pQuery As %String,
	ByRef pResult As %String) As %Status
{
	Set pResult = ""
	Set rs = ##class(%ResultSet).%New()
	Set tSC = rs.Prepare(pQuery)
	If $$$ISOK(tSC) {
		Set tSC = rs.Execute()
		If $$$ISOK(tSC), rs.Next() Set pResult = rs.GetData(1)
	}
	Do rs.Close()
	Set rs = ""
	Quit tSC
}

ClassMethod GetField(pFileNo As %String = "") As gncrud.model.Field
{
	Set tQuery = "SELECT ID FROM VistA_FileMan.File where FileNo="_pFileNo
	Set tSC = ..ExecuteQueryOneValue(tQuery,.file) 
	Kill pFields
	Set tWhere = " WHERE File = "_file
	Set myquery = "SELECT ID, FieldNo, File, Loc, Name, Type FROM VistA_FileMan.Field"_tWhere
	Set tStatement = ##class(%SQL.Statement).%New()
	Set qStatus = tStatement.%Prepare(myquery)
	If qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) quit}
	Set rset = tStatement.%Execute()
	While rset.%Next() {
		Set pFields($Increment(pFields)) = rset.ID
	}
	Set tRandom = $Random(pFields)
	Set tReturn = pFields(tRandom + 1)
	Set objField = ##class(VistA.FileMan.Field).%OpenId(tReturn)
	Set tReturn = ##class(gncrud.model.Field).%New()
	Set tReturn.id = objField.FieldNo
	Set tReturn.name = objField.Name
	Set tReturn.valuetype = objField.Type
	Quit tReturn
}

ClassMethod GetFileNo(ByRef pFileNo) As %String
{
	Set tSC = $$$OK
	Set myquery = "SELECT ID, FileNo, Filename FROM VistA_FileMan.File"
	Set tStatement = ##class(%SQL.Statement).%New()
	Set qStatus = tStatement.%Prepare(myquery)
	If qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) quit}
	Set rset = tStatement.%Execute()
	While rset.%Next() {
		Set pFileNo($Increment(pFileNo)) = rset.FileNo
	}
	Set tRandom = $Random(pFileNo)
	Set tReturn = pFileNo(tRandom + 1)
	Quit tReturn
}

}
