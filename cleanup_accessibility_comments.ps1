# PowerShell script to remove accessibility-related comments from all moderate scenario files
# This ensures fair testing by removing obvious accessibility violation indicators

Write-Host "Starting cleanup of accessibility comments from moderate scenarios..."

# Get all relevant files
$files = Get-ChildItem -Path "scenarios/moderate" -Recurse -Include "*.jsx","*.js","*.ts","*.tsx","*.vue","*.svelte","*.html","*.py","*.swift","*.kt","*.java","*.dart","*.cpp","*.cs","*.xaml" | Where-Object { $_.Name -notlike "*cleanup*" }

$totalFiles = $files.Count
$processedFiles = 0
$modifiedFiles = 0

Write-Host "Found $totalFiles files to process..."

foreach ($file in $files) {
    $processedFiles++
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    # Remove common accessibility violation comments
    $patterns = @(
        '(?i)//\s*MISSING:.*',
        '(?i)//\s*TODO:.*accessibility.*',
        '(?i)//\s*FIXME:.*accessibility.*',
        '(?i)//\s*BUG:.*accessibility.*',
        '(?i)//\s*HACK:.*accessibility.*',
        '(?i)//\s*NOTE:.*accessibility.*',
        '(?i)/\*.*MISSING:.*\*/',
        '(?i)/\*.*TODO:.*accessibility.*\*/',
        '(?i)/\*.*FIXME:.*accessibility.*\*/',
        '(?i)/\*.*BUG:.*accessibility.*\*/',
        '(?i)/\*.*HACK:.*accessibility.*\*/',
        '(?i)/\*.*NOTE:.*accessibility.*\*/',
        '(?i)#\s*MISSING:.*',
        '(?i)#\s*TODO:.*accessibility.*',
        '(?i)#\s*FIXME:.*accessibility.*',
        '(?i)#\s*BUG:.*accessibility.*',
        '(?i)#\s*HACK:.*accessibility.*',
        '(?i)#\s*NOTE:.*accessibility.*'
    )
    
    foreach ($pattern in $patterns) {
        $content = $content -replace $pattern, ''
    }
    
    # Remove documentation sections that explain accessibility issues
    $docPatterns = @(
        '(?s)<h3>Accessibility Issues:</h3>.*?</ul>',
        '(?s)<h3>How to Fix:</h3>.*?</ul>',
        '(?s)<h3>Issues:</h3>.*?</ul>',
        '(?s)<h3>Problems:</h3>.*?</ul>',
        '(?s)<h3>Violations:</h3>.*?</ul>',
        '(?s)Accessibility Issues:.*?How to Fix:.*?</ul>',
        '(?s)Issues:.*?Solutions:.*?</ul>'
    )
    
    foreach ($pattern in $docPatterns) {
        $content = $content -replace $pattern, ''
    }
    
    # Remove empty lines that might be left behind
    $content = $content -replace '(?m)^\s*$\n', ''
    
    # Only write if content changed
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        $modifiedFiles++
        Write-Host "Modified: $($file.Name)"
    }
    
    if ($processedFiles % 50 -eq 0) {
        Write-Host "Processed $processedFiles/$totalFiles files..."
    }
}

Write-Host "Cleanup complete! Modified $modifiedFiles out of $totalFiles files."
