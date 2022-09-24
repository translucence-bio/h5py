# Download pre-compiled, zlib-compatible zlib-ng binaries

$ProgressPreference = 'SilentlyContinue'

$version = if ($Env:ZLIB_NG_VERSION -eq $null) {"2.0.6"} else {$Env:ZLIB_NG_VERSION}
$arch = "x86-64"
$filename = "zlib-ng-win-$($arch)-compat"

Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/zlib-ng/zlib-ng/releases/download/$($version)/$($filename).zip" -Outfile "$($filename).zip"
Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("$PWD/$($filename).zip", "$Env:ZLIB_ROOT")

# Wheels build script expects a "_release" suffix
Rename-Item -Path "$($Env:ZLIB_ROOT)\bin" -NewName "bin_release"
Rename-Item -Path "$($Env:ZLIB_ROOT)\lib" -NewName "lib_release"
