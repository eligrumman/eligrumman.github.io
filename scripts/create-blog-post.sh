#!/bin/bash

# Professional Blog Post Creation Pipeline
# Usage: ./create-blog-post.sh "Topic Title" "primary-keyword"

set -e

TOPIC="$1"
KEYWORD="$2"
DATE=$(date +%Y-%m-%d)
SLUG=$(echo "$TOPIC" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
POST_FILE="_posts/${DATE}-${SLUG}.md"

if [ -z "$TOPIC" ]; then
    echo "Usage: $0 'Blog Post Topic' 'primary-keyword'"
    echo "Example: $0 'Understanding React Hooks' 'react-hooks'"
    exit 1
fi

echo "🚀 Starting Professional Blog Creation Pipeline"
echo "Topic: $TOPIC"
echo "Keyword: $KEYWORD"
echo "Output: $POST_FILE"
echo ""

# Create feature branch for this blog post
BRANCH_NAME="blog/$(echo "$SLUG" | head -c 50)"
echo "🌿 Creating feature branch: $BRANCH_NAME"
git checkout main 2>/dev/null || git checkout master 2>/dev/null
git checkout -b "$BRANCH_NAME"
echo ""

# Create working directory
mkdir -p _drafts
DRAFT_FILE="_drafts/${DATE}-${SLUG}-draft.md"

echo "📋 Phase 1: Research & Planning (20% of workflow)"
echo "=================================================================="

echo "🔍 Step 1.1: Topic Discovery & Validation"
claude-code --agent search-specialist \
    "Research current trends and discussions about '$TOPIC' in 2025. 
     Find recent articles, statistics, GitHub trends, and identify content gaps. 
     Focus on what developers are actually asking about and struggling with.
     Provide 3-5 key angles that would be valuable to cover."

read -p "Continue with content brief creation? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Stopping pipeline."
    exit 1
fi

echo "🎯 Step 1.2: SEO & Keyword Research"
if [ -n "$KEYWORD" ]; then
    claude-code --agent search-specialist \
        "Find high-value keywords related to '$KEYWORD' and '$TOPIC'.
         Include search volume estimates, keyword difficulty, and related long-tail keywords.
         Suggest primary keyword and 3-5 secondary keywords for SEO optimization.
         Focus on keywords that developers actually search for."
fi

echo "📝 Step 1.3: Content Brief Creation"
claude-code --agent content-marketer \
    "Create a comprehensive content brief for '$TOPIC'.
     Include:
     - Target audience (skill level, interests)
     - Key messages and learning objectives
     - Detailed outline with H2/H3 structure
     - Tone and style guidelines
     - Success metrics and call-to-action
     Make it specific to developers and technical professionals."

read -p "Proceed with content creation? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Review the brief and run the script again when ready."
    exit 1
fi

echo ""
echo "✍️ Phase 2: Content Creation (40% of workflow)"
echo "=================================================================="

echo "🔬 Step 2.1: Technical Research & Fact-Checking"
claude-code --agent search-specialist \
    "Conduct deep research on '$TOPIC' for technical accuracy.
     Verify current best practices, version compatibility, and recent changes.
     Find authoritative sources, official documentation, and expert opinions.
     Flag any controversial or rapidly-changing aspects that need extra verification."

echo "📄 Step 2.2: Content Writing"
claude-code --agent content-marketer \
    "Write a comprehensive, engaging blog post on '$TOPIC'.
     Follow the approved brief and ensure:
     - Strong hook in the introduction
     - Clear, logical flow between sections
     - Practical, actionable advice
     - Professional yet approachable tone
     - Proper conclusion with next steps
     
     Format as Jekyll markdown with proper frontmatter for $_POST_FILE"

# Create the initial post file
cat > "$DRAFT_FILE" << EOF
---
layout: single
title: "$TOPIC"
date: $DATE
categories: [development, tutorial]
tags: [$(echo $KEYWORD | tr '-' ' ')]
excerpt: "TODO: Add compelling excerpt"
---

<!-- Content will be added by agents -->
EOF

echo "💻 Step 2.3: Code Examples & Technical Content"
# Determine which technical agent to use based on topic
if [[ $TOPIC =~ [Pp]ython ]]; then
    TECH_AGENT="python-pro"
elif [[ $TOPIC =~ [Jj]ava[Ss]cript|[Rr]eact|[Nn]ode ]]; then
    TECH_AGENT="javascript-pro"
elif [[ $TOPIC =~ [Rr]ust ]]; then
    TECH_AGENT="rust-pro"
elif [[ $TOPIC =~ [Gg]o|[Gg]olang ]]; then
    TECH_AGENT="golang-pro"
else
    TECH_AGENT="general-purpose"
fi

claude-code --agent "$TECH_AGENT" \
    "Create working, tested code examples for '$TOPIC'.
     Ensure examples are:
     - Production-ready and well-commented
     - Following current best practices
     - Properly formatted for markdown
     - Include setup/installation instructions if needed
     - Cover common use cases and edge cases"

echo ""
echo "🔍 Phase 3: Review & Quality Assurance (25% of workflow)"
echo "=================================================================="

echo "⚡ Step 3.1: Technical Accuracy Review"
claude-code --agent code-reviewer \
    "Review the blog post about '$TOPIC' for technical accuracy.
     Verify:
     - All code examples compile and work correctly
     - Technical claims are accurate and current
     - Best practices are properly represented
     - No outdated information or deprecated methods
     - Proper error handling in examples"

echo "✨ Step 3.2: Content Quality & Flow Review"
claude-code --agent content-marketer \
    "Review the '$TOPIC' blog post for content quality and engagement.
     Check:
     - Clear, logical progression of ideas
     - Consistent tone and brand voice
     - Strong introduction and conclusion
     - Proper transitions between sections
     - Actionable takeaways for readers"

echo "🎯 Step 3.3: SEO Optimization Review"
claude-code --agent search-specialist \
    "Optimize the '$TOPIC' blog post for SEO while maintaining readability.
     Ensure:
     - Natural integration of target keywords
     - Proper H1/H2/H3 heading structure
     - Optimized meta title and description
     - Internal linking opportunities
     - External links to authoritative sources"

echo ""
echo "🚀 Phase 4: Final Polish & Publishing (15% of workflow)"
echo "=================================================================="

echo "📝 Step 4.1: Copy Editing & Proofreading"
claude-code --agent content-marketer \
    "Perform final copy editing and proofreading of the '$TOPIC' post.
     Check:
     - Grammar, spelling, and punctuation
     - Formatting consistency
     - Proper citations and attributions
     - Readability and flow
     - Call-to-action effectiveness"

echo "🔧 Step 4.2: Publishing Preparation"
claude-code --agent deployment-engineer \
    "Prepare the '$TOPIC' blog post for Jekyll publication.
     Ensure:
     - Proper Jekyll frontmatter
     - Correct markdown formatting
     - Image optimization (if any)
     - Proper file naming and location
     - All metadata is complete"

echo "✅ Step 4.3: Final Quality Gate"
claude-code --agent architect-reviewer \
    "Conduct final architectural review of the '$TOPIC' blog post.
     Verify:
     - Meets all quality standards
     - Proper structure and organization
     - Brand consistency
     - Technical accuracy
     - Ready for publication"

# Move from draft to posts if everything passes
if [ -f "$DRAFT_FILE" ]; then
    mv "$DRAFT_FILE" "$POST_FILE"
fi

echo ""
echo "🎉 Blog Post Creation Complete!"
echo "=================================================================="
echo "📄 Post file: $POST_FILE"
echo "🌿 Feature branch: $BRANCH_NAME"
echo ""
echo "📊 PR-Based Workflow Next Steps:"
echo "   1. Create Draft PR: git add . && git commit -m 'Draft: $TITLE'"
echo "   2. Push branch: git push origin $BRANCH_NAME"
echo "   3. Open Draft PR on GitHub for initial review"
echo "   4. Run QA script: ./scripts/qa-blog-post.sh $POST_FILE"
echo "   5. Address all review feedback"
echo "   6. Mark PR as Ready for Review"
echo "   7. Final approval and merge to main"
echo ""
echo "🔍 Quality Metrics to Verify:"
echo "   ✓ Technical accuracy: 100%"
echo "   ✓ Fact verification: All claims sourced"
echo "   ✓ SEO optimization: Target keyword naturally integrated"
echo "   ✓ Readability: Clear structure with scannable sections"
echo "   ✓ Code examples: All tested and working"
echo ""
echo "🚀 Ready for Draft PR creation!"
echo ""
echo "Quick PR creation:"
echo "git add . && git commit -m 'Draft: Add blog post - $TITLE' && git push origin $BRANCH_NAME"