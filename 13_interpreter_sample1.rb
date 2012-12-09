# -*- coding: utf-8 -*-
require 'find'

# 命令・抽象的な表現(AbstractExpression)
class Expression
  def |(other)
    Or.new(self, other)
  end

  def &(other)
    And.new(self, other)
  end
end

# 終端となる表現(構造木の葉) (TerminalExpression)
class FileName < Expression
  def initialize(pattern)
    @pattern = pattern
  end

  def evaluate(dir)
    results= []
    Find.find(dir) do |p|
      next unless File.file?(p)
      name = File.basename(p)
      results << p if File.fnmatch(@pattern, name)
    end
    results
  end
end

# 終端となる表現(構造木の葉) (TerminalExpression)
class All < Expression
  def evaluate(dir)
    results= []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p
    end
    results
  end
end

# 終端となる表現(構造木の葉) (TerminalExpression)
class Not < Expression
  def initialize(expression)
    @expression = expression
  end

  def evaluate(dir)
    All.new.evaluate(dir) - @expression.evaluate(dir)
  end
end

# 終端となる表現(構造木の葉) (TerminalExpression)
class Bigger < Expression
  def initialize(size)
    @size = size
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p if( File.size(p) > @size)
    end
    results
  end
end

# 終端となる表現(構造木の葉) (TerminalExpression)
class Writable < Expression
  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p if( File.writable?(p) )
    end
    results
  end
end

# 終端以外の表現(構造木の節) NonterminalExpression
class Or < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    (result1 + result2).sort.uniq
  end
end

# 終端以外の表現(構造木の節) NonterminalExpression
class And < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    (result1 & result2)
  end
end

# ===========================================
complex_expression1 = And.new(FileName.new('*.mp3'), FileName.new('big*'))
puts complex_expression1.evaluate('13_test_data_dir')
#13_test_data_dir/big.mp3
#13_test_data_dir/big2.mp3

complex_expression2 = Bigger.new(1024)
puts complex_expression2.evaluate('13_test_data_dir')
# 以下出力結果
#13_test_data_dir/big.mp3
#13_test_data_dir/big2.mp3
#13_test_data_dir/subdir/other.mp3

complex_expression3 = FileName.new('*.mp3') & FileName.new('big*')
puts complex_expression3.evaluate('13_test_data_dir')
#13_test_data_dir/big.mp3
#13_test_data_dir/big2.mp3

complex_expression4 = All.new
puts complex_expression4.evaluate('13_test_data_dir')
#13_test_data_dir/big.mp3
#13_test_data_dir/big2.mp3
#13_test_data_dir/small.mp3
#13_test_data_dir/small1.txt
#13_test_data_dir/small2.txt
#13_test_data_dir/subdir/other.mp3
#13_test_data_dir/subdir/small.jpg