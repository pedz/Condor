# Represents a contextual change. Contains the position and values of the
# elements in the old and the new sequenced enumerables as well as the action
# taken.
class Diff::LCS::ContextChange
    # Returns the action this Change represents. Can be '+' (#adding?), '-'
    # (#deleting?), '=' (#unchanged?), # or '!' (#changed?). When
    # created by Diff::LCS#diff or Diff::LCS#sdiff, it may also be '>'
    # (#finished_a?) or '<' (#finished_b?).
  attr_reader :action
  attr_reader :old_position
  attr_reader :old_element
  attr_reader :new_position
  attr_reader :new_element

  include Comparable

  def ==(other)
    (@action == other.action) and
    (@old_position == other.old_position) and
    (@new_position == other.new_position) and
    (@old_element == other.old_element) and
    (@new_element == other.new_element)
  end

  def inspect(*args)
    %Q(#<#{self.class.name}:#{__id__} @action=#{action} positions=#{old_position},#{new_position} elements=#{old_element.inspect},#{new_element.inspect}>)
  end

  def <=>(other)
    r = @action <=> other.action
    r = @old_position <=> other.old_position if r.zero?
    r = @new_position <=> other.new_position if r.zero?
    r = @old_element <=> other.old_element if r.zero?
    r = @new_element <=> other.new_element if r.zero?
    r
  end

  def initialize(action, old_position, old_element, new_position, new_element)
    @action = action
    @old_position = old_position
    @old_element = old_element
    @new_position = new_position
    @new_element = new_element
  end

  def to_a
    [@action, [@old_position, @old_element], [@new_position, @new_element]]
  end

    # Creates a ContextChange from an array produced by ContextChange#to_a.
  def self.from_a(arr)
    if arr.size == 5
      Diff::LCS::ContextChange.new(arr[0], arr[1], arr[2], arr[3], arr[4])
    else
      Diff::LCS::ContextChange.new(arr[0], arr[1][0], arr[1][1], arr[2][0],
                                   arr[2][1])
    end
  end

    # Simplifies a context change for use in some diff callbacks. '<' actions
    # are converted to '-' and '>' actions are converted to '+'. 
  def self.simplify(event)
    ea = event.to_a

    case ea[0]
    when '-'
      ea[2][1] = nil
    when '<'
      ea[0] = '-'
      ea[2][1] = nil
    when '+'
      ea[1][1] = nil
    when '>'
      ea[0] = '+'
      ea[1][1] = nil
    end

    Diff::LCS::ContextChange.from_a(ea)
  end

  include Diff::LCS::ChangeTypeTests
end
