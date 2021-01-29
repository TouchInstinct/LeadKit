# Semantic Commit Messages

The repository has adopted the following style of commits:  
  `<type>(<scope>): <subject>` | `<type>: <subject>`

---  
   
If a commit contains *Breaking Changes*, use `!` to show it:   
  `<type>(<scope>)!: <subject>` | `<type>!: <subject>`

## Example

```sh
feat: add Cocoapods support
^--^  ^------------^
|     |
|     +-> Summary in present tense.
|
+-------> Commit type.
```

## Available commit types

- `feat`: A new feature. Correlates with MINOR in SemVer
- `fix`: A bug fix. Correlates with PATCH in SemVer
- `build`: Changes that affect the build system or external dependencies
- `ci`: Changes to our CI configuration files and scripts
- `docs`: Documentation only changes
- `perf`: A code change which improves performance
- `refactor`: A code change that neither fixes
- `revert`: A revert to previous commit
- `style`: Changes that do not affect the meaning of the code (white-space, formatting, etc).

## Changelog

Each release's Changelog is made up of commits that are either feat, fix or contain Breaking Changes, so you should be naming things carefully.

## References

- https://www.conventionalcommits.org/
- https://seesparkbox.com/foundry/semantic_commit_messages
- http://karma-runner.github.io/1.0/dev/git-commit-msg.html