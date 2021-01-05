
# Warn when there is a big PR
warn('This PR is too big! Consider breaking it down into smaller PRs.') if git.lines_of_code > 600

# Checks for changelog entry
unless git.modified_files.include?("CHANGELOG.md")
  fail("Please update a [CHANGELOG.md](https://github.com/TouchInstinct/LeadKit/blob/master/CHANGELOG.md).", sticky: false)
end