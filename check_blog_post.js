const { chromium } = require('playwright');

async function checkBlogPost() {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  
  try {
    console.log('Navigating to blog post...');
    await page.goto('https://month-supplier-agree-infants.trycloudflare.com/development/ai-tools/productivity/claude-code-pricing-worth-every-penny/', {
      waitUntil: 'networkidle'
    });
    
    // Take a screenshot
    await page.screenshot({ 
      path: '/home/dev/blog/blog_post_screenshot.png', 
      fullPage: true 
    });
    console.log('Screenshot saved to blog_post_screenshot.png');
    
    // Check the title
    const title = await page.title();
    console.log('Page title:', title);
    
    // Check for the new title in the content
    const h1Title = await page.textContent('h1').catch(() => null);
    console.log('H1 title:', h1Title);
    
    // Check if the page contains the expected content
    const pageContent = await page.textContent('body');
    
    console.log('\n--- Content Verification ---');
    
    // Check for new title
    const hasNewTitle = pageContent.includes('Why Claude Code Max ($100) Is Worth Every Dollar');
    console.log('✓ Has new title "Why Claude Code Max ($100) Is Worth Every Dollar":', hasNewTitle);
    
    // Check for updated opening
    const hasNewOpening = pageContent.includes('I run a development workflow that would be impossible without Claude Code');
    console.log('✓ Has new opening "I run a development workflow...":', hasNewOpening);
    
    // Check for "The Numbers" section
    const hasNumbersSection = pageContent.includes('The Numbers');
    console.log('✓ Has "The Numbers" section:', hasNumbersSection);
    
    // Check for ccusage output
    const hasCcusageOutput = pageContent.includes('ccusage') || pageContent.includes('Total cost:') || pageContent.includes('$');
    console.log('✓ Has ccusage-related content:', hasCcusageOutput);
    
    // Check for any error messages
    const hasErrors = pageContent.includes('404') || pageContent.includes('Not Found') || pageContent.includes('Error');
    console.log('✗ Has error messages:', hasErrors);
    
    console.log('\n--- Raw Page Content Preview (first 1000 chars) ---');
    console.log(pageContent.substring(0, 1000));
    
  } catch (error) {
    console.error('Error checking blog post:', error.message);
    await page.screenshot({ 
      path: '/home/dev/blog/error_screenshot.png', 
      fullPage: true 
    });
  } finally {
    await browser.close();
  }
}

checkBlogPost();