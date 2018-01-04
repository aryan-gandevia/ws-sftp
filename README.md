# ws-sftp
Wrapper for `net/sftp` to easily communicate with an SFTP server

## Configure
Require the gem:
```ruby
require 'ws-sftp'
```

Create an initializer:

```ruby
Ws::SFTP.configure do |config|
  config.host = 'sftp.domain.com'
  config.username = 'username'
  config.password = 'password'
end
```

## Usage
### Read a file
```ruby
Ws::SFTP::Client.read('/file1.txt')  # => '<contents of file1.txt>'
```

### Write a file
```ruby
Ws::SFTP::Client.write('/new_file.txt', 'contents to write to new_file.txt')
```

### List files in a given directory
```ruby
Ws::SFTP::Client.ls('/')  # => ['directory1/', 'directory2/', 'file1.txt']
Ws::SFTP::Client.ls('/directory1')  # => ['file2.txt', 'file3.txt']
```

### `yield` over a list of files
```ruby
Ws::SFTP::Client.each_file(['/file1.txt', '/directory1/file2.txt']) do |path, contents|
  path  # => '/file1.txt', 'directory1/file2.txt'
  content  # => '<contents of file1.txt>', '<contents of directory1/file2.txt>'
end
```
