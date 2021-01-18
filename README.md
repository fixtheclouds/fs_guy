# fs-guy
DSL for managing file system

## How it works
### Before
```
dir_2       drwxr-xr-x user users
--text.txt  -rw-r--r-- user users
--text.csv  -rw-r--r-- user users
--trash     -rw-r--r-- user users
old         drwxr-xr-x user users
--file.rb   -rw-r--r-- user users
```

### Write some DSL script
```ruby
FsGuy.run do
  dir 'dir_1' do                            # Create folder and enter
   file 'file.txt'                          # Create blank file
  end

  dir 'dir_2' do                            # Enter existing folder
    move('text.txt').to 'next.txt'          # Move file
    copy('text.csv').to 'dup.csv'           # Copy file
    remove 'trash'                          # Remove file
    own 'dup.csv', 'someguy', 'somegroup'   # Change file owner
    mode 'dup.csv', :all                    # Set file mode
    file('next.txt').mode(:all).own(:other) # Chaining
  end

  remove 'old', force: true # Force remove directory
end
```

### After
```
dir_1       drwxr-xr-x user    users
---file.txt -rwxr--r-- user    users
dir_2       drwxr-xr-x user    users
---next.txt -rwxr--r-- user    users
---text.csv -rwxr--r-- user    users
---dup.csv  -rwxrwxrwx someguy somegroup
```
