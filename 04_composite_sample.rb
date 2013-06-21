# -*- coding: utf-8 -*-

# FileEntry, DirEntryクラスの共通メソッドを規定(Component)
class Entry
  # ファイル/ディレクトリの名称を返す
  def get_name; end

  # ファイル/ディレクトリのパスを返す
  def ls_entry(prefix) end

  # ファイル/ディレクトリの削除を行う
  def remove; end
end

# ファイルを表す(Leaf)
class FileEntry < Entry
  def initialize(name)
    @name = name
  end

  # ファイルの名称を返す
  def get_name
    @name
  end

  # ファイルのパスを返す
  def ls_entry(prefix)
    puts(prefix + "/" + get_name)
  end

  # ファイルの削除を行う
  def remove
    puts @name + "を削除しました"
  end
end

# ディレクトリを表す(Composite)
class DirEntry < Entry
  def initialize(name)
    @title = name
    @directory = Array.new
  end

  # ディレクトリの名称を返す
  def get_name
    @title
  end

  # ディレクトリにファイルを追加する
  def add(entry)
    @directory.push(entry)
  end

  # ファイル/ディレクトリのパスを返す
  def ls_entry(prefix)
    puts(prefix + "/" + get_name)
    @directory.each do |e|
      e.ls_entry(prefix + "/" + @title)
    end
  end

  # ファイル/ディレクトリの削除を行う
  def remove
    @directory.each do |i|
      i.remove
    end
    puts @title + "を削除しました"
  end
end

# ===========================================
root = DirEntry.new("root")
tmp = DirEntry.new("tmp")
tmp.add(FileEntry.new("conf"))
tmp.add(FileEntry.new("data"))
root.add(tmp)

root.ls_entry("")
#=> /root
#=> /root/tmp
#=> /root/tmp/conf
#=> /root/tmp/data

root.remove
#=> confを削除しました
#=> dataを削除しました
#=> tmpを削除しました
#=> rootを削除しました