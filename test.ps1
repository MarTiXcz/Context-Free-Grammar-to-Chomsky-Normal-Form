$path = ".stack-work\dist\ca59d0ab\build\flp-fun-xzemek04-exe"
function Run ($mode, $filepath) {
    $test = & $path\flp-fun-xzemek04-exe.exe $mode $filepath 2>&1
    return $test
}

$output = Run("-i", "test.txt")
Write-Output $output