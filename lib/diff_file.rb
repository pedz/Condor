#
# This is currently not used.  When I first toyed with the diff
# processing, I put each line into a string table which I assumed
# would make the diff faster since it was just comparing integers.  I
# may go back to this at some point.
#
class DiffFile
  include Diff::LCS

  def initialize(filename)
    @lines = []
    File.open(filename, "r") do |f|
      f.each_line do |line|
        @lines.push StringTable.add_string(line)
      end
    end
  end

  def [](i)
    @lines[i]
  end

  def length
    @lines.length
  end

  def size
    @lines.size
  end

  def each
    @lines.each do |l|
      yield StringTable.lookup(l)
    end
  end
end
