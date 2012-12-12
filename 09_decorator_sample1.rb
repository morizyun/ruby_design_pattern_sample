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

# ===========================================

writer = SimpleWriter.new('sample1.txt')
writer.write_line('飾り気のない一行')
writer.close