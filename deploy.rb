#/usr/bin ruby

# TODO Prompt to copy each of the home directory files into the users home
#      directory so that it recreates it.

COPY_TO_MAPPING = {
  '.vimrc' => '~/.vimrc'
}

root = __dir__
Dir[File.join(root, 'home', '*')].each do |file|
  next unless File.file?(file)
  dest = COPY_TO_MAPPING[file]
  next unless dest
  File.copy(file, dest)
end
