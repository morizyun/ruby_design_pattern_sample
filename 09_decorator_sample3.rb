# -*- coding: utf-8 -*-
require "forwardable"

# ファイルへの単純な出力を行う (ConcreteComponent)
class SimpleWriter
  def initialize(path)
    @file = File.open(path, "w")
  end

  # データを出力する
  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  # ファイル出力位置
  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  # ファイル出力を閉じる
  def close
    @file.close
  end
end

# 複数のデコレータの共通部分(Decorator)
class WriterDecorator
  extend Forwardable

  # forwardableで以下のメソッドの処理を委譲している
  def_delegators :@real_writer, :write_line, :pos, :rewind, :close

  def initialize(real_writer)
    @real_writer = real_writer
  end
end

# 行番号出力機能を装飾する(Decorator)
module NumberingWriter
  attr_reader :line_number

  def write_line(line)
    @line_number = 1 unless @line_number
    super("#{@line_number} : #{line}")
    @line_number += 1
  end
end

# タイムスタンプ出力機能を装飾する(Decorator)
module TimeStampingWriter
  def write_line(line)
    super("#{Time.new} : #{line}")
  end
end

# ===========================================
f = SimpleWriter.new("09_test_data_dir/file3.txt")
f.extend TimeStampingWriter
f.extend NumberingWriter
f.write_line("Hello out there")
f.close
# file3.txtに以下の内容が出力される
#2012-12-09 13:26:27 +0900 : 1 : Hello out there
