# More comprehensive cleanup script for remaining accessibility comments
Write-Host "Starting comprehensive cleanup of remaining accessibility comments..."

$files = Get-ChildItem -Path "scenarios/moderate" -Recurse -Include "*.jsx","*.js","*.ts","*.tsx","*.vue","*.svelte","*.html","*.py","*.swift","*.kt","*.java","*.dart","*.cpp","*.cs","*.xaml"

$totalFiles = $files.Count
$processedFiles = 0
$modifiedFiles = 0

foreach ($file in $files) {
    $processedFiles++
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    # More comprehensive patterns
    $patterns = @(
        '(?i)//\s*MISSING.*',
        '(?i)//\s*TODO.*',
        '(?i)//\s*FIXME.*',
        '(?i)//\s*BUG.*',
        '(?i)//\s*HACK.*',
        '(?i)//\s*NOTE.*',
        '(?i)/\*.*MISSING.*\*/',
        '(?i)/\*.*TODO.*\*/',
        '(?i)/\*.*FIXME.*\*/',
        '(?i)/\*.*BUG.*\*/',
        '(?i)/\*.*HACK.*\*/',
        '(?i)/\*.*NOTE.*\*/',
        '(?i)#\s*MISSING.*',
        '(?i)#\s*TODO.*',
        '(?i)#\s*FIXME.*',
        '(?i)#\s*BUG.*',
        '(?i)#\s*HACK.*',
        '(?i)#\s*NOTE.*',
        '(?i)<!--.*MISSING.*-->',
        '(?i)<!--.*TODO.*-->',
        '(?i)<!--.*FIXME.*-->',
        '(?i)<!--.*BUG.*-->',
        '(?i)<!--.*HACK.*-->',
        '(?i)<!--.*NOTE.*-->'
    )
    
    foreach ($pattern in $patterns) {
        $content = $content -replace $pattern, ''
    }
    
    # Remove documentation sections
    $docPatterns = @(
        '(?s)<h3>.*Issues.*</h3>.*?</ul>',
        '(?s)<h3>.*Problems.*</h3>.*?</ul>',
        '(?s)<h3>.*Violations.*</h3>.*?</ul>',
        '(?s)<h3>.*How to Fix.*</h3>.*?</ul>',
        '(?s)<h3>.*Solutions.*</h3>.*?</ul>',
        '(?s)Issues:.*?Solutions:.*?</ul>',
        '(?s)Problems:.*?Fixes:.*?</ul>'
    )
    
    foreach ($pattern in $docPatterns) {
        $content = $content -replace $pattern, ''
    }
    
    # Clean up empty lines
    $content = $content -replace '(?m)^\s*$\n', ''
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        $modifiedFiles++
    }
    
    if ($processedFiles % 50 -eq 0) {
        Write-Host "Processed $processedFiles/$totalFiles files..."
    }
}

Write-Host "Comprehensive cleanup complete! Modified $modifiedFiles out of $totalFiles files."
