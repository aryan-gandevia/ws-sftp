# ws-sftp
Wrapper for `net/sftp` to easily communicate with an SFTP server

## Configure
Require the gem:
```ruby
require 'ws-sftp'
```

Pass in the configuration:

```ruby
client = Ws::SFTP::Client.new(
  host: 'sftp.domain.com',
  username: 'username',
  password: 'password'
)
```

## Usage
### Read a file
```ruby
client = Ws::SFTP::Client.new
client.read('/file1.txt')  # => '<contents of file1.txt>'
```

### Write a file
```ruby
client = Ws::SFTP::Client.new
client.write('/new_file.txt', 'contents to write to new_file.txt')
```

### List files in a given directory
```ruby
client = Ws::SFTP::Client.new
client.ls('/')  # => ['directory1/', 'directory2/', 'file1.txt']
client.ls('/directory1')  # => ['file2.txt', 'file3.txt']
```

### `yield` over a list of files
```ruby
client = Ws::SFTP::Client.new
client.each_file(['/file1.txt', '/directory1/file2.txt']) do |path, contents|
  path  # => '/file1.txt', 'directory1/file2.txt'
  content  # => '<contents of file1.txt>', '<contents of directory1/file2.txt>'
end
```
