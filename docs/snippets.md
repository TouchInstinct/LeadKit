# Snippets

- [⚡ Cocoapods](#cocoapods)
	- [Bump version in podspecs](#bump-version-in-podspecs)
	- [Push changes to podspecs repo](#push-changes-to-podspecs-repo)

## Cocoapods

### Bump version in podspecs

1. Install nmp: `brew install node`
2. Install podspec-bump: `npm install -g podspec-bump`
3. Run command in project folder:   
```sh
find . -name '*.podspec' \
	-not -path "./Carthage/*" \
	-not -path "./*/Carthage/*" \
	-not -path "./Pods/*" \
	-not -path "./*/Pods/*" \
	| xargs -I% npx podspec-bump -i "Version - x.y.z" -w -p %
```

### Push changes to podspecs repo

1. Add repo: `pod repo add touchinstinct git@github.com:TouchInstinct/Podspecs`
2. Run command in project folder: 
```sh
find . -name '*.podspec' \
	-not -path "./Carthage/*" \
	-not -path "./*/Carthage/*" \
	-not -path "./Pods/*" \
	-not -path "./*/Pods/*" \
	| xargs -I% pod repo push git@github.com:TouchInstinct/Podspecs % --allow-warnings
```



