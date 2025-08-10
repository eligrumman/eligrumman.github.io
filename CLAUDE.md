  ## Blog Content Workflow

  ### Blog Post Creation Process

  Blog posts follow the EXACT same workflow as code development:

  #### 1. Issue Creation
  **ALWAYS create a GitHub issue first:**
  Title: "Blog Post: [Topic Title]"
  Labels: blog, content
  Assignee: @eligrumman

  Description:
  - Topic: [Detailed topic description]
  - Target Audience: [Developer level, interests]
  - Key Messages: [Main points to cover]
  - SEO Keywords: [Primary and secondary keywords]
  - Research Requirements: [Specific facts/data needed]

  #### 2. Orchestrator Review
  1. **ALWAYS** invoke Orchestrator Agent first with issue number
  2. Orchestrator analyzes the blog requirements and creates execution plan
  3. Plan posted as comment for user approval
  4. Upon approval, issue body updated with approved plan

  #### 3. Blog Agent Delegation
  **Content Creation Agents:**
  - `content-marketer`: Blog writing, SEO optimization, content strategy
  - `search-specialist`: Research, fact-checking, trend analysis
  - `code-reviewer`: Technical accuracy for code examples
  - `[tech]-pro`: Language-specific examples (python-pro, javascript-pro, etc.)

  #### 4. Branch and PR Management
  **CRITICAL: Same rules as code development:**
  1. Create issue first
  2. Checkout fresh branch: git checkout main && git checkout -b blog/issue-N-title
  3. NEVER push to main/master directly
  4. All work happens in PRs
  5. Each PR gets review and approval

  #### 5. Blog PR Stages

  **Stage 1 - Content Creation (Draft PR):**
  1. DELEGATE to content-marketer for initial draft
  2. DELEGATE to search-specialist for fact-checking
  3. DELEGATE to relevant tech agent for code examples
  4. Create DRAFT PR with initial content
  5. DELEGATE to code-reviewer for technical accuracy

  **Stage 2 - Content Review (Ready PR):**
  6. DELEGATE to content-marketer for content quality review
  7. DELEGATE to search-specialist for SEO optimization
  8. Address all review feedback
  9. Mark PR as "Ready for Review"
  10. Comment: "Content and technical accuracy approved, please review @user"

  #### 6. Blog Quality Gates
  **All blog posts must pass:**
  - Technical accuracy: 100% (all code examples work)
  - Fact verification: All claims sourced and verified
  - SEO optimization: Primary keywords naturally integrated
  - Brand consistency: Professional tone maintained
  - Content quality: Clear structure, actionable advice

  #### 7. Blog Workflow Commands
  Start blog post issue

  /orchestrator review issue #[number] for blog post

  During development blockers

  /orchestrator resolve blocker #[number]

  Final review

  /orchestrator final review #[number]

  ### Blog-Specific Agent Responsibilities

  **content-marketer:**
  - Initial content creation and structure
  - SEO keyword integration
  - Brand voice and tone consistency
  - Content quality and engagement review

  **search-specialist:**
  - Topic research and trend analysis
  - Fact-checking and source verification
  - SEO keyword research and optimization
  - Competitive content analysis

  **code-reviewer:**
  - Technical accuracy of all code examples
  - Best practices validation
  - Code formatting and clarity
  - Version compatibility verification

  **Technical Agents (python-pro, javascript-pro, etc.):**
  - Language-specific code examples
  - Technical concept explanations
  - Current best practices research
  - Working example creation and testing

  ### Blog Complexity Assessment

  **🟢 SIMPLE BLOG POSTS (2-3 PRs)**
  - Personal experience stories
  - Opinion pieces with minimal technical content
  - Updates or announcements
  - **Process**: Content creation → Review → Publish

  **🟡 MEDIUM BLOG POSTS (3-4 PRs)**
  - Technical tutorials with code examples
  - Product comparisons with research
  - How-to guides with multiple steps
  - **Process**: Research → Content → Technical review → SEO optimization

  **🔴 COMPLEX BLOG POSTS (4-6 PRs)**
  - Deep technical analysis with extensive research
  - Comprehensive guides with multiple technologies
  - Industry analysis with data and statistics
  - **Process**: Research → Content → Technical review → Fact-checking → SEO → Final polish