# -*- coding: utf-8 -*-

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
  def initialize(real_writer)
    @real_writer = real_writer
  end

  def write_line(line)
    @real_writer.write_line(line)
  end

  def pos
    @real_writer.pos
  end

  def rewind
    @real_writer.rewind
  end

  def close
    @real_writer.close
  end
end

# Decorator: ベースとなるオブジェクトに機能を追加する
# NumberingWriter: 行番号出力機能を装飾する
class NumberingWriter < WriterDecorator

  def initialize(real_writer)
    super(real_writer)
    @line_number = 1
  end

  def write_line(line)
    @real_writer.write_line("#{@line_number} : #{line}")
  end
end

# Decorator: ベースとなるオブジェクトに機能を追加する
# TimeStampingWriter: タイムスタンプ出力機能を装飾する
class TimeStampingWriter < WriterDecorator
  def write_line(line)
    @real_writer.write_line("#{Time.new} : #{line}")
  end
end

# ===========================================
f = NumberingWriter.new(SimpleWriter.new("file1.txt"))
f.write_line("Hello out there")
f.close
# file1.txtに以下の内容が出力される
#1 : Hello world

f = TimeStampingWriter.new(SimpleWriter.new("file2.txt"))
f.write_line("Hello out there")
f.close
# file2.txtに以下の内容が出力される
#2012-12-09 12:55:38 +0900 : Hello out there

f = TimeStampingWriter.new(NumberingWriter.new(SimpleWriter.new("file3.txt")))
f.write_line("Hello out there")
f.close
# file3.txtに以下の内容が出力される
#1 : 2012-12-09 12:55:38 +0900 : Hello out there