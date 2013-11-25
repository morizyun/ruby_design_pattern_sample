class Case
  def initialize
    @title = "タイトル"
    @text = %w(foo? bar? hoge?)
  end

  # レポートの出力手順を規定
  def test_case
    test_start
    test_each
    test_end
  end

  # レポートの先頭に出力
  def test_start
  end

  # レポートの本文の管理
  def test_each
    @text.each do |line|
      test_line(line)
    end
  end

  # 本文内のLINE出力部分
  # 今回は個別クラスに規定するメソッドとする。規定されてなければエラーを出す
  def test_line(line)
    raise 'Called abstract method !!'
  end

  # レポートの末尾に出力
  def test_end
  end
end

class Rspec < Case
  def test_start
    puts %!before { @title = '%s' }\n! % @title
  end

  def test_line(line)
    puts %!it { expect(@title.%s).to be_true }! % line
  end

  def test_end
    puts 'after { exit }'
  end
end

class Minitest < Case
  def test_start
    puts %!setup { @title = '%s' }\n! % @title
  end

  def test_line(line)
    puts %!test { assert @title.%s }! % line
  end
end

# ===========================================
rspec_case = Rspec.new
rspec_case.test_case

3.times { puts ' ' }

minitest_case = Minitest.new
minitest_case.test_case
