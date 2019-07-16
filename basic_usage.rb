#!/usr/bin/env ruby

require "bundler/setup"
Bundler.require(:default)

# basic usage

puts RUBY_VERSION.to_s

# byebug
# 1 == 1

puts "done ==================="

module Hello
  extend FFI::Library
  ffi_lib FFI::Library::LIBC
  attach_function :puts, [:string], :int
end

Hello.puts("Hello, World")
