param(
    [parameter(Mandatory=$true)]
    [string]$version
)

$root = (split-path -parent $MyInvocation.MyCommand.Definition)
$buildPath = "$root\build"
If(Test-Path $buildPath)
{
	Remove-Item $buildPath -recurse
}
new-item -Path $buildPath -ItemType directory
new-item -Path "$buildPath\tmp" -ItemType directory

$thisYear = get-date -Format yyyy
$floatingVersion = "$($version.Split(".")[0]).$($version.Split(".")[1]).*"

$nugetVersion = (((nuget help | select -First 1).Split(':')) | select -Last 1).Trim()
Write-Host "Nuget's version: $nugetVersion"
if ($nugetVersion -lt '5.3')
    { $xpath = ('/package/metadata/icon') }
else
    { $xpath = ('/package/metadata/iconUrl') }

#For NBi.VisualStudio (dll)
Write-Host "Packaging NBi.VisualStudio"

Write-Host "Setting .nuspec version tag to $version, NBi.Framework dependency version to $floatingVersion and copyright until $thisYear"
$content = (Get-Content $root\NBi.VisualStudio.nuspec -Encoding UTF8) 
$content = $content -replace '\$version\$',$version
$content = $content -replace '\$floatingVersion\$',$floatingVersion
$content = $content -replace '\$thisYear\$',$thisYear

Write-Host "Managing metadata/icon vs metadata/iconUrl"
$xml = New-Object -TypeName System.Xml.XmlDocument
$xml.LoadXml($content)
$iconNode = $xml.SelectSingleNode($xpath)
$iconNode.ParentNode.RemoveChild($iconNode)

$xml.OuterXml | Out-File $buildPath\tmp\NBi.VisualStudio.compiled.nuspec -Encoding UTF8

& NuGet.exe pack $buildPath\tmp\NBi.VisualStudio.compiled.nuspec -Version $version -OutputDirectory $buildPath
Write-Host "Package for NBi.VisualStudio is ready"