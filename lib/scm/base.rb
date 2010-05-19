module SCM
  class Base
    cattr_accessor :logger

=begin
This is what I need to do...

No ssh-agent
pedzan@newtoy<1> on ttyp0
irb
irb(main):001:0> foo = Tempfile.new
foo = Tempfile.new
NameError: uninitialized constant Tempfile
	from (irb):1
	from /usr/local/bin/irb:12:in `<main>'
irb(main):002:0> require 'tempfile'
require 'tempfile'
=> true
irb(main):003:0> foo = Tempfile.new
foo = Tempfile.new
ArgumentError: wrong number of arguments (0 for 1)
	from (irb):3:in `new'
	from (irb):3
	from /usr/local/bin/irb:12:in `<main>'
irb(main):004:0> foo = Tempfile.new("condor")
foo = Tempfile.new("condor")
=> #<File:/var/folders/Wk/Wk6I+wuWHcanZeQ0UPNsRU+++TQ/-Tmp-/condor20100514-64292-1klr8ph-0>
irb(main):005:0> foo.path
foo.path
=> "/var/folders/Wk/Wk6I+wuWHcanZeQ0UPNsRU+++TQ/-Tmp-/condor20100514-64292-1klr8ph-0"
irb(main):006:0> f = IO.popen("/tmp/squack 2> #{foo.path}")
f = IO.popen("/tmp/squack 2> #{foo.path}")
=> #<IO:0x8098ac>
irb(main):007:0> l = f.readlines
l = f.readlines
=> ["stdout\n"]
irb(main):008:0> f.close
f.close
=> nil
irb(main):009:0> j = $?
j = $?
=> #<Process::Status: pid 64321 exit 2>
irb(main):010:0> foo.open
foo.open
=> #<File:/var/folders/Wk/Wk6I+wuWHcanZeQ0UPNsRU+++TQ/-Tmp-/condor20100514-64292-1klr8ph-0>
irb(main):011:0> e = foo.readlines
e = foo.readlines
=> ["strerr\n"]
irb(main):012:0> foo.close(true)
foo.close(true)
=> nil
irb(main):013:0> pedzan@newtoy<1> on ttyp0
=end
    
  end
end
  
