# -*- coding: utf-8 -*-
require "forwardable"

# ConcreteComponent: ベースとなる処理をもつ
# SimpleWrite: ファイルへの単純な出力を行うクラス
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

# Decorator: ベースとなるオブジェクトに機能を追加する
# WriterDecorator: タイムスタンプを追加する機能を持つ
class WriterDecorator
  extend Forwardable

  # forwardableで以下のメソッドの処理を委譲している
  def_delegators :@real_writer, :write_line, :pos, :rewind, :close

  def initialize(real_writer)
    @real_writer = real_writer
  end
end

# Decorator: ベースとなるオブジェクトに機能を追加する
# NumberingWriter: 行番号出力機能を装飾する
module NumberingWriter
  attr_reader :line_number

  def write_line(line)
    @line_number = 1 unless @line_number
    super("#{@line_number} : #{line}")
    @line_number += 1
  end
end

# Decorator: ベースとなるオブジェクトに機能を追加する
# TimeStampingWriter: タイムスタンプ出力機能を装飾する
module TimeStampingWriter
  def write_line(line)
    super("#{Time.new} : #{line}")
  end
end

# ===========================================
f = SimpleWriter.new("file3.txt")
f.extend TimeStampingWriter
f.extend NumberingWriter
f.write_line("Hello out there")
f.close
# file3.txtに以下の内容が出力される
#2012-12-09 13:26:27 +0900 : 1 : Hello out there
