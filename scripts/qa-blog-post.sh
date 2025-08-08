#!/bin/bash

# Blog Post Quality Assurance Pipeline
# Usage: ./qa-blog-post.sh path/to/blog-post.md

set -e

POST_FILE="$1"

if [ -z "$POST_FILE" ] || [ ! -f "$POST_FILE" ]; then
    echo "Usage: $0 path/to/blog-post.md"
    echo "Example: $0 _posts/2025-01-08-react-hooks-guide.md"
    exit 1
fi

echo "🔍 Running Comprehensive QA on: $POST_FILE"
echo "=================================================================="

# Extract title from the post for context
TITLE=$(grep "^title:" "$POST_FILE" | sed 's/title: *["\x27]*//' | sed 's/["\x27]*$//')

echo "📄 Post Title: $TITLE"
echo ""

echo "⚡ Technical Accuracy Review"
echo "----------------------------------------"
claude-code --agent code-reviewer \
    "Review this blog post for technical accuracy and code quality:
     
     $(cat $POST_FILE)
     
     Check:
     - All code examples compile and work correctly
     - Technical claims are accurate and sourced
     - Best practices are properly followed
     - No deprecated methods or outdated information
     - Proper error handling in code examples
     - Version compatibility is addressed
     
     Provide specific feedback on any issues found."

echo ""
echo "📝 Content Quality & Brand Alignment Review"
echo "----------------------------------------"
claude-code --agent content-marketer \
    "Review this blog post for content quality and brand consistency:
     
     $(cat $POST_FILE)
     
     Evaluate:
     - Clear, logical flow and structure
     - Engaging and professional tone
     - Key messages are focused and clear
     - Strong introduction and conclusion
     - Actionable takeaways for readers
     - Consistent with developer blog standards
     - Proper transitions between sections
     
     Rate overall quality and suggest improvements."

echo ""
echo "🎯 SEO & Discoverability Review"  
echo "----------------------------------------"
claude-code --agent search-specialist \
    "Review this blog post for SEO optimization and discoverability:
     
     $(cat $POST_FILE)
     
     Analyze:
     - Keyword integration and density
     - Title and heading optimization
     - Meta description effectiveness
     - Internal and external linking strategy
     - Content structure for featured snippets
     - Readability and scanability
     - Image alt text and optimization
     
     Suggest specific SEO improvements."

echo ""
echo "🔧 Technical Implementation Review"
echo "----------------------------------------"
claude-code --agent deployment-engineer \
    "Review this blog post for technical implementation and publishing readiness:
     
     $(cat $POST_FILE)
     
     Verify:
     - Jekyll frontmatter is complete and correct
     - Markdown formatting is proper
     - File naming follows conventions
     - Categories and tags are appropriate
     - Date format is correct
     - All required metadata is present
     - No formatting issues that would break Jekyll
     
     Confirm readiness for publication."

echo ""
echo "🏗️ Final Architectural Review"
echo "----------------------------------------"
claude-code --agent architect-reviewer \
    "Conduct final architectural review of this blog post:
     
     $(cat $POST_FILE)
     
     Assess:
     - Overall structure and organization
     - Meets established quality standards
     - Consistency with existing blog content
     - Appropriate depth and scope for topic
     - Value proposition for target audience
     - Completeness of coverage
     
     Give final recommendation for publication readiness."

echo ""
echo "📊 Quality Metrics Check"
echo "----------------------------------------"

# Basic metrics we can calculate
WORD_COUNT=$(cat "$POST_FILE" | wc -w)
LINE_COUNT=$(cat "$POST_FILE" | wc -l)
CODE_BLOCKS=$(grep -c '```' "$POST_FILE" || echo "0")
HEADINGS=$(grep -c '^#' "$POST_FILE" || echo "0")
LINKS=$(grep -o '\[.*\](.*)'  "$POST_FILE" | wc -l || echo "0")

echo "📈 Automated Metrics:"
echo "   Word count: $WORD_COUNT"
echo "   Line count: $LINE_COUNT" 
echo "   Code blocks: $CODE_BLOCKS"
echo "   Headings: $HEADINGS"
echo "   Links: $LINKS"

# Quality gates
echo ""
echo "🚦 Quality Gates Status:"

if [ "$WORD_COUNT" -gt 800 ]; then
    echo "   ✅ Word count: $WORD_COUNT (>800)"
else
    echo "   ❌ Word count: $WORD_COUNT (<800 - consider expanding)"
fi

if [ "$HEADINGS" -gt 3 ]; then
    echo "   ✅ Structure: $HEADINGS headings (good organization)"
else
    echo "   ⚠️  Structure: $HEADINGS headings (consider more sections)"
fi

if [ "$CODE_BLOCKS" -gt 0 ]; then
    echo "   ✅ Examples: $CODE_BLOCKS code blocks included"
else
    echo "   ⚠️  Examples: No code blocks (consider adding examples)"
fi

echo ""
echo "📋 Manual Review Checklist"
echo "----------------------------------------"
echo "Please verify manually:"
echo "   □ All code examples tested and working"
echo "   □ All external links are valid and current"
echo "   □ Screenshots/images are optimized and have alt text"
echo "   □ Call-to-action is clear and relevant"
echo "   □ Post provides genuine value to readers"
echo "   □ Tone matches target audience expertise level"
echo "   □ No sensitive information or credentials exposed"
echo "   □ Copyright compliance for any external content"

echo ""
echo "🎯 Pre-Publication Checklist"
echo "----------------------------------------"
echo "Before publishing, ensure:"
echo "   □ Jekyll preview works correctly (bundle exec jekyll serve)"
echo "   □ All agent feedback has been addressed"
echo "   □ Post has been proofread by human reviewer"
echo "   □ Social media promotional content prepared"
echo "   □ Newsletter content drafted (if applicable)"
echo "   □ Internal team has been notified of publication"

echo ""
if [ "$WORD_COUNT" -gt 800 ] && [ "$HEADINGS" -gt 3 ]; then
    echo "✅ QA PASSED: Blog post meets basic quality gates"
    echo "   Review agent feedback above and address any issues"
    echo "   Complete manual checklist items"
    echo "   Post is likely ready for publication"
else
    echo "⚠️  QA REVIEW NEEDED: Blog post may need improvements"
    echo "   Address the quality gate issues above"
    echo "   Review agent feedback carefully"
    echo "   Consider expanding content or improving structure"
fi

echo ""
echo "🚀 Next Steps:"
echo "   1. Address all agent feedback points"
echo "   2. Complete manual review checklist"
echo "   3. Test Jekyll compilation locally"
echo "   4. Get final human approval"
echo "   5. Commit and push to publish"
echo ""
echo "📊 QA Report completed for: $TITLE"