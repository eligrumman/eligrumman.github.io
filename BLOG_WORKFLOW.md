# Professional Blog Writing Workflow

## Phase 1: Planning & Research (20% of total time)

### Step 1.1: Topic Discovery & Validation
**Agent**: `search-specialist`
**Task**: Research topic relevance, trending discussions, and competitive landscape
```bash
# Example usage
claude-code --agent search-specialist "Research current trends in [topic] for 2025. Find recent discussions, statistics, and identify content gaps in the market."
```
**Deliverable**: Research brief with target audience, trending angles, and content gap analysis

### Step 1.2: SEO & Keyword Research  
**Agent**: `search-specialist` 
**Task**: Identify primary keywords, search volume, and ranking opportunities
```bash
claude-code --agent search-specialist "Find high-value keywords for [topic]. Include search volume, difficulty, and related long-tail keywords for SEO optimization."
```
**Deliverable**: Keyword strategy with primary/secondary keywords and search intent analysis

### Step 1.3: Content Brief Creation
**Agent**: `content-marketer`
**Task**: Create detailed content brief with structure, tone, and requirements
```bash
claude-code --agent content-marketer "Create a content brief for [topic]. Include target audience, key messages, outline structure, and success metrics."
```
**Deliverable**: Comprehensive content brief with outline and messaging strategy

## Phase 2: Content Creation (40% of total time)

### Step 2.1: Technical Research & Fact-Checking
**Agent**: `search-specialist` + relevant technical agent (`python-pro`, `javascript-pro`, etc.)
**Task**: Gather accurate technical information, verify facts, and collect examples
```bash
# Technical accuracy
claude-code --agent python-pro "Research and verify current best practices for [technical topic]. Include code examples and version compatibility."

# Fact verification  
claude-code --agent search-specialist "Fact-check these statistics and claims: [list]. Provide original sources and verify currency of information."
```
**Deliverable**: Fact-checked research with verified sources and accurate technical examples

### Step 2.2: Content Writing
**Agent**: `content-marketer`
**Task**: Write the first draft following the approved brief
```bash
claude-code --agent content-marketer "Write a comprehensive blog post on [topic] following this brief: [brief]. Focus on clarity, engagement, and technical accuracy."
```
**Deliverable**: Complete first draft with proper structure and flow

### Step 2.3: Code Examples & Technical Content
**Agent**: Relevant technical agent (`python-pro`, `javascript-pro`, `rust-pro`, etc.)
**Task**: Create, test, and verify all code examples and technical explanations
```bash
claude-code --agent javascript-pro "Create working code examples for [concept]. Ensure examples are production-ready, well-commented, and follow current best practices."
```
**Deliverable**: Tested, working code examples with explanations

## Phase 3: Review & Quality Assurance (25% of total time)

### Step 3.1: Technical Accuracy Review
**Agent**: `code-reviewer` + domain expert agent
**Task**: Verify technical accuracy, code quality, and best practices
```bash
claude-code --agent code-reviewer "Review this blog post for technical accuracy. Check all code examples, verify claims, and ensure adherence to current best practices."
```
**Quality Gates**: 
- ✅ All code examples compile/run successfully
- ✅ Technical claims are accurate and sourced
- ✅ Best practices are correctly represented

### Step 3.2: Content Quality & Flow Review
**Agent**: `content-marketer`
**Task**: Review for clarity, engagement, message consistency, and brand alignment
```bash
claude-code --agent content-marketer "Review this blog post for content quality. Assess clarity, flow, engagement, and alignment with our brand voice."
```
**Quality Gates**:
- ✅ Clear, logical progression of ideas
- ✅ Consistent tone and voice
- ✅ Strong introduction and conclusion
- ✅ Key messages are clear and focused

### Step 3.3: SEO Optimization Review
**Agent**: `search-specialist`
**Task**: Optimize for search engines while maintaining readability
```bash
claude-code --agent search-specialist "Optimize this blog post for SEO. Ensure proper keyword usage, meta descriptions, and internal linking opportunities."
```
**Quality Gates**:
- ✅ Primary keyword naturally integrated
- ✅ Proper heading structure (H1, H2, H3)
- ✅ Meta title and description optimized
- ✅ Internal and external linking strategy

## Phase 4: Final Polish & Publishing (15% of total time)

### Step 4.1: Copy Editing & Proofreading
**Agent**: `content-marketer`
**Task**: Final grammar, style, and formatting review
```bash
claude-code --agent content-marketer "Perform final copy editing and proofreading. Check grammar, spelling, formatting consistency, and readability."
```
**Quality Gates**:
- ✅ Error-free grammar and spelling
- ✅ Consistent formatting and style
- ✅ Proper citations and attributions

### Step 4.2: Publishing Preparation
**Agent**: `deployment-engineer`
**Task**: Prepare for publication with proper formatting and metadata
```bash
claude-code --agent deployment-engineer "Prepare this blog post for Jekyll publication. Ensure proper frontmatter, formatting, and deployment readiness."
```
**Deliverable**: Publication-ready markdown with all metadata

### Step 4.3: Pre-Publication Review
**Agent**: `architect-reviewer`
**Task**: Final architectural review of the content structure and quality
```bash
claude-code --agent architect-reviewer "Conduct final review of this blog post. Ensure it meets our quality standards and publishing guidelines."
```
**Quality Gates**:
- ✅ Meets all quality standards
- ✅ Proper structure and organization
- ✅ Ready for publication

## Quality Control Checkpoints

### Mandatory Gates (Must Pass All)
1. **Technical Accuracy**: Code works, facts verified, sources cited
2. **Message Clarity**: Key points are clear and focused
3. **Brand Alignment**: Tone and style match brand voice
4. **SEO Compliance**: Optimized for search without keyword stuffing
5. **Readability**: Clear structure with scannable sections

### Review Criteria Matrix

| Aspect | Agent | Criteria | Pass/Fail |
|--------|-------|----------|-----------|
| Technical Accuracy | `code-reviewer` | All code examples work | ⚫ |
| Fact Verification | `search-specialist` | All claims sourced and verified | ⚫ |
| Content Quality | `content-marketer` | Clear, engaging, on-message | ⚫ |
| SEO Optimization | `search-specialist` | Properly optimized for target keywords | ⚫ |
| Brand Consistency | `architect-reviewer` | Matches brand voice and standards | ⚫ |

## Workflow Automation Scripts

### Complete Blog Creation Pipeline
```bash
#!/bin/bash
# blog-pipeline.sh [topic] [target-keyword]

TOPIC=$1
KEYWORD=$2

echo "🔍 Phase 1: Research & Planning"
claude-code --agent search-specialist "Research $TOPIC trends and $KEYWORD opportunities"
claude-code --agent content-marketer "Create content brief for $TOPIC targeting $KEYWORD"

echo "✍️ Phase 2: Content Creation" 
claude-code --agent content-marketer "Write blog post on $TOPIC following approved brief"
claude-code --agent python-pro "Create technical examples for $TOPIC concepts"

echo "🔍 Phase 3: Quality Review"
claude-code --agent code-reviewer "Review technical accuracy of $TOPIC blog post"
claude-code --agent search-specialist "SEO optimize $TOPIC post for $KEYWORD"

echo "🚀 Phase 4: Publishing Preparation"
claude-code --agent deployment-engineer "Prepare $TOPIC post for Jekyll publication"

echo "✅ Blog post ready for final human review and publication"
```

### Quality Assurance Checklist
```bash
#!/bin/bash
# qa-checklist.sh [blog-post-file]

POST_FILE=$1

echo "Running comprehensive QA on $POST_FILE..."

# Technical review
claude-code --agent code-reviewer "QA technical content in $POST_FILE"

# Content review  
claude-code --agent content-marketer "QA content quality and brand alignment in $POST_FILE"

# SEO review
claude-code --agent search-specialist "QA SEO optimization in $POST_FILE"

# Final architectural review
claude-code --agent architect-reviewer "Final QA review of $POST_FILE"

echo "QA complete. Review agent feedback before publishing."
```

## Success Metrics

### Content Quality KPIs
- Technical accuracy: 100% (all code examples must work)
- Fact verification: 100% (all claims sourced and verified)
- Readability score: >70 (Flesch-Kincaid)
- SEO optimization: >80% (Yoast/similar tool score)

### Performance Metrics  
- Time to publish: <5 days from brief to publication
- Revision rounds: <3 major revisions
- Error rate: <1 error per 1000 words in published posts
- Reader engagement: >3 minute average time on page

### Efficiency Metrics
- Research time: <20% of total time
- Writing time: <40% of total time  
- Review time: <25% of total time
- Polish time: <15% of total time

## Tools Integration

### Required Tools
- `ccusage`: Monitor AI usage costs
- Jekyll: Blog platform
- Git: Version control for posts
- Markdown: Content format

### Optional Enhancements
- Grammarly: Additional grammar checking
- Hemingway Editor: Readability analysis
- Google Search Console: SEO performance tracking
- Plausible/GA: Traffic and engagement analytics

This workflow ensures every blog post is technically accurate, well-researched, properly optimized, and professionally polished before publication.