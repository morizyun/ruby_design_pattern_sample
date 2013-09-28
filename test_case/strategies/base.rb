##
# TemplateMethodクラス
class Base
  def title
    @title ||= "タイトル"
  end

  def text
    @text ||= %w(foo? bar? hoge?)
  end

  # レポートの出力手順を規定
  def execute
    test_start
    test_each
    test_end
  end

  # レポートの先頭に出力
  def test_start; end

  # レポートの本文の管理
  def test_each
    text.each do |line|
      test_line(line)
    end
  end

  # 本文内のLINE出力部分
  # 今回は個別クラスに規定するメソッドとする。規定されてなければエラーを出す
  def test_line(line)
    raise 'Called abstract method !!'
  end

  # レポートの末尾に出力
  def test_end; end
end

