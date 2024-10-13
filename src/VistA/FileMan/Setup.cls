Class VistA.FileMan.Setup
{

ClassMethod Setup() As %Status
{
	Set tSC = $$$OK
	Set objFile = ##class(File).%New()
	Set objFile.FileNo = 123
	Set objFile.Filename = "REQUEST/CONSULTATION"
	Set tSC = objFile.%Save()
	Set objFile = ##class(File).%New()
	Set objFile.FileNo = 668
	Set objFile.Filename = "PROSTHETIC SUSPENSE"
	Set tSC = objFile.%Save()
	Quit tSC
}

}
