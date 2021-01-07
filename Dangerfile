
# Warn when there is a big PR
warn('This PR is too big! Consider breaking it down into smaller PRs.') if git.lines_of_code > 600

# Checks for changelog entry
if git.modified_files.include?("CHANGELOG.md")
  fail("Please, revert the file [CHANGELOG.md](https://github.com/TouchInstinct/LeadKit/blob/master/CHANGELOG.md).  
It's automatically updated with your commits. For more, see - [Conventional Commits](https://wanago.io/2020/08/17/generating-changelog-standard-version/)", sticky: false)
end

# Check for commits style
valid_commit_style = /^(build|chore|ci|docs|feat|fix|perf|refactor|revert|style)(\(\S+\))?\!?: .+/
merge_commit_style = /^(m|M)erge .+/

unless git.commits.all? { |c| c.message =~ valid_commit_style || c.message =~ merge_commit_style }
  fail("Make sure, your commits confirm rules - [config-conventional](https://github.com/conventional-changelog/commitlint/tree/master/%40commitlint/config-conventional#rules).  
Please, rename your commits. For more, see - [Changing a commit message](https://docs.github.com/en/free-pro-team@latest/github/committing-changes-to-your-project/changing-a-commit-message).", sticky: false)
end