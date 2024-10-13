Class VistA.FileMan.Utility
{

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
