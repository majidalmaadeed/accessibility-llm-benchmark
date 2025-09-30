# Final cleanup to remove all remaining accessibility documentation
Write-Host "Starting final cleanup of accessibility documentation..."

$files = Get-ChildItem -Path "scenarios/moderate" -Recurse -Include "*.jsx","*.js","*.ts","*.tsx","*.vue","*.svelte","*.html","*.py","*.swift","*.kt","*.java","*.dart","*.cpp","*.cs","*.xaml"

$totalFiles = $files.Count
$processedFiles = 0
$modifiedFiles = 0

foreach ($file in $files) {
    $processedFiles++
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    # Remove all documentation sections that mention accessibility
    $patterns = @(
        '(?s)<div[^>]*>.*?<strong>Note:</strong>.*?</div>',
        '(?s)<div[^>]*>.*?<strong>Issues:</strong>.*?</div>',
        '(?s)<div[^>]*>.*?<strong>Problems:</strong>.*?</div>',
        '(?s)<div[^>]*>.*?<strong>Violations:</strong>.*?</div>',
        '(?s)<div[^>]*>.*?<strong>How to Fix:</strong>.*?</div>',
        '(?s)<div[^>]*>.*?<strong>Solutions:</strong>.*?</div>',
        '(?s)<div[^>]*>.*?accessibility.*?</div>',
        '(?s)<h3>.*?Issues.*?</h3>.*?</ul>',
        '(?s)<h3>.*?Problems.*?</h3>.*?</ul>',
        '(?s)<h3>.*?Violations.*?</h3>.*?</ul>',
        '(?s)<h3>.*?How to Fix.*?</h3>.*?</ul>',
        '(?s)<h3>.*?Solutions.*?</h3>.*?</ul>',
        '(?s)Issues:.*?Solutions:.*?</ul>',
        '(?s)Problems:.*?Fixes:.*?</ul>',
        '(?s)Violations:.*?Fixes:.*?</ul>',
        '(?s)Note:.*?accessibility.*?',
        '(?s)Issues:.*?accessibility.*?',
        '(?s)Problems:.*?accessibility.*?',
        '(?s)Violations:.*?accessibility.*?'
    )
    
    foreach ($pattern in $patterns) {
        $content = $content -replace $pattern, ''
    }
    
    # Remove any remaining lines with accessibility keywords
    $lines = $content -split "`n"
    $filteredLines = @()
    foreach ($line in $lines) {
        if ($line -notmatch '(?i)(accessibility|aria|screen reader|keyboard|focus|tab|navigation|semantic|role|label|alt|alt text|alt=""|aria-|role=|tabindex|skip|skip link|live region|announce|announcement)') {
            $filteredLines += $line
        }
    }
    $content = $filteredLines -join "`n"
    
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

Write-Host "Final cleanup complete! Modified $modifiedFiles out of $totalFiles files."
