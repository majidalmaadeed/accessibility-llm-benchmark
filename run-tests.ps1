# Accessibility LLM Benchmark - Automated Test Runner
# This script allows automated execution of common testing commands

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("web", "mobile", "desktop", "cross-platform")]
    [string]$Platform,
    
    [Parameter(Mandatory=$true)]
    [ValidateSet("basic", "moderate", "advanced")]
    [string]$Complexity,
    
    [Parameter(Mandatory=$false)]
    [string]$Framework = "all",
    
    [Parameter(Mandatory=$false)]
    [switch]$Install,
    
    [Parameter(Mandatory=$false)]
    [switch]$Build,
    
    [Parameter(Mandatory=$false)]
    [switch]$Test
)

Write-Host "🚀 Starting Accessibility LLM Benchmark Testing" -ForegroundColor Green
Write-Host "Platform: $Platform" -ForegroundColor Cyan
Write-Host "Complexity: $Complexity" -ForegroundColor Cyan
Write-Host "Framework: $Framework" -ForegroundColor Cyan

# Function to run commands safely
function Invoke-SafeCommand {
    param([string]$Command, [string]$WorkingDir = ".")
    
    Write-Host "Executing: $Command" -ForegroundColor Yellow
    try {
        Push-Location $WorkingDir
        Invoke-Expression $Command
        Write-Host "✅ Command completed successfully" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Command failed: $($_.Exception.Message)" -ForegroundColor Red
    }
    finally {
        Pop-Location
    }
}

# Install dependencies if requested
if ($Install) {
    Write-Host "📦 Installing dependencies..." -ForegroundColor Blue
    
    # Web frameworks
    if ($Platform -eq "web" -or $Platform -eq "cross-platform") {
        $webFrameworks = @("angular", "react", "vue", "svelte", "sveltekit", "nuxt", "nextjs")
        
        foreach ($fw in $webFrameworks) {
            if ($Framework -eq "all" -or $Framework -eq $fw) {
                $path = "scenarios\$Complexity\web\$fw"
                if (Test-Path $path) {
                    Invoke-SafeCommand "npm install" $path
                }
            }
        }
    }
    
    # Mobile frameworks
    if ($Platform -eq "mobile") {
        $mobileFrameworks = @("android-compose", "android-views", "ios-swiftui", "ios-uikit", "react-native", "flutter", "xamarin", "ionic")
        
        foreach ($fw in $mobileFrameworks) {
            if ($Framework -eq "all" -or $Framework -eq $fw) {
                $path = "frameworks\mobile\$fw"
                if (Test-Path $path) {
                    if ($fw -like "android*" -or $fw -eq "react-native" -or $fw -eq "ionic") {
                        Invoke-SafeCommand "npm install" $path
                    }
                    elseif ($fw -eq "flutter") {
                        Invoke-SafeCommand "flutter pub get" $path
                    }
                }
            }
        }
    }
}

# Build projects if requested
if ($Build) {
    Write-Host "🔨 Building projects..." -ForegroundColor Blue
    
    if ($Platform -eq "web" -or $Platform -eq "cross-platform") {
        $webFrameworks = @("angular", "react", "vue", "svelte", "sveltekit", "nuxt", "nextjs")
        
        foreach ($fw in $webFrameworks) {
            if ($Framework -eq "all" -or $Framework -eq $fw) {
                $path = "scenarios\$Complexity\web\$fw"
                if (Test-Path $path) {
                    Invoke-SafeCommand "npm run build" $path
                }
            }
        }
    }
}

# Run tests if requested
if ($Test) {
    Write-Host "🧪 Running tests..." -ForegroundColor Blue
    
    if ($Platform -eq "web" -or $Platform -eq "cross-platform") {
        $webFrameworks = @("angular", "react", "vue", "svelte", "sveltekit", "nuxt", "nextjs")
        
        foreach ($fw in $webFrameworks) {
            if ($Framework -eq "all" -or $Framework -eq $fw) {
                $path = "scenarios\$Complexity\web\$fw"
                if (Test-Path $path) {
                    Invoke-SafeCommand "npm test" $path
                }
            }
        }
    }
}

Write-Host "🎉 Automation completed!" -ForegroundColor Green
