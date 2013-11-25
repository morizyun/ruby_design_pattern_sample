class Minitest
  include AbstractTestCase

  def test_start
    puts %!setup { @title = '%s' }\n! % title
  end

  def test_line(line)
    puts %!test { assert @title.%s }! % line
  end
end
