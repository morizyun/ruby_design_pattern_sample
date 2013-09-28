class Minitest
  include AbstractTestCase

  def test_start
    puts %!setup { @title = '%s' }\n! % title
  end

  def test_line(line)
    puts %!def test_assert_title;  assert @title.%s; end! % line
  end
end
