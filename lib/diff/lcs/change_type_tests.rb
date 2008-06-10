# Centralises the change test code in Diff::LCS::Change and
# Diff::LCS::ContextChange, since it's the same for both classes.
module Diff::LCS::ChangeTypeTests
  def deleting?
    @action == '-'
  end

  def adding?
    @action == '+'
  end

  def unchanged?
    @action == '='
  end

  def changed?
    @changed == '!'
  end

  def finished_a?
    @changed == '>'
  end

  def finished_b?
    @changed == '<'
  end
end
