#!/usr/bin/env ruby

require "bundler/setup"
Bundler.require(:default)

require "gir_ffi-gtk3"
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

puts "FFF done -----------------"

Gtk.init

draw_area = Gtk::DrawingArea.new
GObject.signal_connect(draw_area, "draw") do |widget, ctx|
  begin
    width = widget.get_allocated_width
    height = widget.get_allocated_height
    ctx.arc(width / 2.0, height / 2.0, [width, height].min / 2.0, 0, 2 * Math::PI)
    ctx.set_source_rbga(1, 1, 0, 0.5)
    ctx.fill
  rescue => e
    puts e
  end
  false
end

draw_area.set_size_request(100, 100)

win = Gtk::Window.new :toplevel
win.add(draw_area)
win.show_all
GObject.signal_connect(win, "destroy") { Gtk.main_quit }

Gtk.main
