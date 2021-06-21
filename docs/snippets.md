# Snippets

- [🔧 Carthage](#Carthage)
	- [Build dependencies for LeadKit.xcodeproj](#Build-dependencies-for-LeadKit.xcodeproj)
- [⚡ Cocoapods](#cocoapods)
	- [Bump version in podspecs](#bump-version-in-podspecs)
	- [Push changes to podspecs repo](#push-changes-to-podspecs-repo)

## Carthage

### Build dependencies for LeadKit.xcodeproj

1. Build xcframeworks for iOS platform, which is usually enough:
```sh
carthage update --use-xcframeworks --cache-builds --platform iOS
```
2. Restart Xcode and clean build folder.
3. You can also run script for another platforms: `--platform tvOS` or `--platform watchOS`.

## Cocoapods

### Bump version in podspecs

1. Install nmp: `brew install node`
2. Install podspec-bump: `npm install -g podspec-bump`
3. Run command in project folder:   
```sh
sh ./project-scripts/bump_version.sh x.y.z
```

### Push changes to podspecs repo

1. Add repo: `pod repo add touchinstinct git@github.com:TouchInstinct/Podspecs`
2. Run command in project folder: 
```sh
sh ./project-scripts/push_to_podspecs.sh
```



