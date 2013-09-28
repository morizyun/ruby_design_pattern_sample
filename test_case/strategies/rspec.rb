class Rspec
  include AbstractTestCase
  def test_start
    puts %!before { @title = '%s' }\n! % title
  end

  def test_line(line)
    puts %!it { expect(@title.%s).to be_true }! % line
  end

  def test_end
    puts 'after { exit }'
  end
end
