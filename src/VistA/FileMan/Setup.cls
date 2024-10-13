Class VistA.FileMan.Setup
{

ClassMethod Setup() As %Status
{
	Set tSC = $$$OK
	Set objFile = ##class(File).%New()
	Set objFile.FileNo = 123
	Set objFile.Filename = "REQUEST/CONSULTATION"
	Set tSC = objFile.%Save()
	Set objField = ##class(Field).%New()
	Set objField.File = objFile
	Set objField.FieldNo = 20
	Set objField.Name = "REASON FOR REQUEST"
	Set objField.Loc = "20;0"
	Set objField.Type = "WORD-PROCESSING #123.01"
	Set tSC = objField.%Save()
	Set objFile = ##class(File).%New()
	Set objFile.FileNo = 668
	Set objFile.Filename = "PROSTHETIC SUSPENSE"
	Set tSC = objFile.%Save()
	Set objField = ##class(Field).%New()
	Set objField.File = objFile
	Set objField.FieldNo = 5
	Set objField.Name = "COMPLETION DATE"
	Set objField.Loc = "0;5"
	Set objField.Type = "DATE"
	Set tSC = objField.%Save()
	Quit tSC
}

}
