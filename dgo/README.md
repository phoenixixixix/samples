Examples of scripts that were written using TDD technology:

1. `minimizer` - script which replaces ranges in the given string with the shortened form. e. g. `'abcdab987612' => 'a-dab9-612`

2. `multiliner` - script which wraps the long lines in the given text to the given length. Example:
  ```
    'To be or not to be that is the question', 5 =>
    To be
    or
    not
    to be
    that
    is
    the
    quest
    ion
  ```

3. `yaml_formatter` - library which transform the translations from simple format into a YAML file that can be used in the rails application.

``` yml
# translations_simple.yml
'en.pets.types.cat': Cat
'en.pets.types.dog': Dog
'en.pets.title': My lovely pets
'en.actions.add': Add
'en.actions.remove': Remove
'en.language': <strong>Language</strong>

# translations.yml - resulting file
en:
  pets:
    types:
      cat: Cat
        dog: Dog
    title: My lovely pets
  actions:
    add: Add
    remove: Remove
  language: <strong>Language</strong>
```

Main code you can find in: `/yaml_formatter/lib/yaml_formatter.rb`

Tests in `/yaml_formatter/spec/lib/yaml_formatter_spec.rb`
