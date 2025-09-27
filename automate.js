#!/usr/bin/env node

/**
 * Accessibility LLM Benchmark - Node.js Automation Script
 * This script provides automated execution of common testing operations
 */

const { execSync, spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

class AccessibilityAutomator {
    constructor() {
        this.platforms = {
            web: ['angular', 'react', 'vue', 'svelte', 'sveltekit', 'nuxt', 'nextjs'],
            mobile: ['android-compose', 'android-views', 'ios-swiftui', 'ios-uikit', 'react-native', 'flutter', 'xamarin', 'ionic'],
            desktop: ['windows-wpf', 'windows-winui', 'macos-swiftui', 'macos-appkit', 'linux-gtk', 'linux-qt'],
            'cross-platform': ['electron', 'tauri', 'flutter']
        };
        
        this.complexities = ['basic', 'moderate', 'advanced'];
    }

    log(message, type = 'info') {
        const colors = {
            info: '\x1b[36m',
            success: '\x1b[32m',
            warning: '\x1b[33m',
            error: '\x1b[31m',
            reset: '\x1b[0m'
        };
        
        const icons = {
            info: 'ℹ️',
            success: '✅',
            warning: '⚠️',
            error: '❌'
        };
        
        console.log(`${colors[type]}${icons[type]} ${message}${colors.reset}`);
    }

    async runCommand(command, cwd = process.cwd(), silent = false) {
        try {
            this.log(`Executing: ${command}`, 'info');
            
            if (silent) {
                execSync(command, { 
                    cwd, 
                    stdio: 'pipe',
                    shell: true 
                });
            } else {
                execSync(command, { 
                    cwd, 
                    stdio: 'inherit',
                    shell: true 
                });
            }
            
            this.log(`Command completed successfully`, 'success');
            return true;
        } catch (error) {
            this.log(`Command failed: ${error.message}`, 'error');
            return false;
        }
    }

    async installDependencies(platform, complexity, framework = 'all') {
        this.log(`Installing dependencies for ${platform} ${complexity}...`, 'info');
        
        const frameworks = framework === 'all' ? this.platforms[platform] : [framework];
        
        for (const fw of frameworks) {
            const basePath = platform === 'web' ? 
                `scenarios/${complexity}/web/${fw}` : 
                `frameworks/${platform}/${fw}`;
            
            if (fs.existsSync(basePath)) {
                this.log(`Installing ${fw}...`, 'info');
                
                // Check if it's a Node.js project
                if (fs.existsSync(path.join(basePath, 'package.json'))) {
                    await this.runCommand('npm install', basePath);
                }
                // Check if it's a Flutter project
                else if (fs.existsSync(path.join(basePath, 'pubspec.yaml'))) {
                    await this.runCommand('flutter pub get', basePath);
                }
                // Check if it's a .NET project
                else if (fs.existsSync(path.join(basePath, '*.csproj'))) {
                    await this.runCommand('dotnet restore', basePath);
                }
            }
        }
    }

    async buildProjects(platform, complexity, framework = 'all') {
        this.log(`Building projects for ${platform} ${complexity}...`, 'info');
        
        const frameworks = framework === 'all' ? this.platforms[platform] : [framework];
        
        for (const fw of frameworks) {
            const basePath = platform === 'web' ? 
                `scenarios/${complexity}/web/${fw}` : 
                `frameworks/${platform}/${fw}`;
            
            if (fs.existsSync(basePath)) {
                this.log(`Building ${fw}...`, 'info');
                
                if (fs.existsSync(path.join(basePath, 'package.json'))) {
                    await this.runCommand('npm run build', basePath);
                }
                else if (fs.existsSync(path.join(basePath, 'pubspec.yaml'))) {
                    await this.runCommand('flutter build', basePath);
                }
                else if (fs.existsSync(path.join(basePath, '*.csproj'))) {
                    await this.runCommand('dotnet build', basePath);
                }
            }
        }
    }

    async runTests(platform, complexity, framework = 'all') {
        this.log(`Running tests for ${platform} ${complexity}...`, 'info');
        
        const frameworks = framework === 'all' ? this.platforms[platform] : [framework];
        
        for (const fw of frameworks) {
            const basePath = platform === 'web' ? 
                `scenarios/${complexity}/web/${fw}` : 
                `frameworks/${platform}/${fw}`;
            
            if (fs.existsSync(basePath)) {
                this.log(`Testing ${fw}...`, 'info');
                
                if (fs.existsSync(path.join(basePath, 'package.json'))) {
                    await this.runCommand('npm test', basePath);
                }
                else if (fs.existsSync(path.join(basePath, 'pubspec.yaml'))) {
                    await this.runCommand('flutter test', basePath);
                }
            }
        }
    }

    async startDevServers(platform, complexity, framework = 'all') {
        this.log(`Starting development servers for ${platform} ${complexity}...`, 'info');
        
        const frameworks = framework === 'all' ? this.platforms[platform] : [framework];
        
        for (const fw of frameworks) {
            const basePath = platform === 'web' ? 
                `scenarios/${complexity}/web/${fw}` : 
                `frameworks/${platform}/${fw}`;
            
            if (fs.existsSync(basePath)) {
                this.log(`Starting ${fw}...`, 'info');
                
                if (fs.existsSync(path.join(basePath, 'package.json'))) {
                    // Start in background
                    spawn('npm', ['start'], { 
                        cwd: basePath, 
                        detached: true, 
                        stdio: 'ignore' 
                    });
                }
            }
        }
    }

    async runFullTestSuite() {
        this.log('Running full accessibility test suite...', 'info');
        
        for (const complexity of this.complexities) {
            for (const platform of Object.keys(this.platforms)) {
                this.log(`Testing ${platform} ${complexity}...`, 'info');
                await this.installDependencies(platform, complexity);
                await this.buildProjects(platform, complexity);
                await this.runTests(platform, complexity);
            }
        }
    }
}

// CLI Interface
async function main() {
    const args = process.argv.slice(2);
    const command = args[0];
    const platform = args[1];
    const complexity = args[2];
    const framework = args[3] || 'all';

    const automator = new AccessibilityAutomator();

    switch (command) {
        case 'install':
            await automator.installDependencies(platform, complexity, framework);
            break;
        case 'build':
            await automator.buildProjects(platform, complexity, framework);
            break;
        case 'test':
            await automator.runTests(platform, complexity, framework);
            break;
        case 'start':
            await automator.startDevServers(platform, complexity, framework);
            break;
        case 'full':
            await automator.runFullTestSuite();
            break;
        default:
            console.log(`
Usage: node automate.js <command> [platform] [complexity] [framework]

Commands:
  install    Install dependencies
  build      Build projects
  test       Run tests
  start      Start development servers
  full       Run full test suite

Platforms: web, mobile, desktop, cross-platform
Complexities: basic, moderate, advanced
Frameworks: all, or specific framework name

Examples:
  node automate.js install web advanced
  node automate.js build mobile moderate
  node automate.js test web basic react
  node automate.js full
            `);
    }
}

if (require.main === module) {
    main().catch(console.error);
}

module.exports = AccessibilityAutomator;
