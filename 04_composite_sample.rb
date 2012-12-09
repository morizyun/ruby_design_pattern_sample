# -*- coding: utf-8 -*-

# Component
class Entry
  def get_name; end

  def ls_entry(prefix) end

  def remove; end
end

# Leaf (中身)
class FileEntry < Entry
  def initialize(name)
    @title = name
  end

  def get_name
    @title
  end

  def ls_entry(prefix)
    puts(prefix + "/" + get_name)
  end

  def remove
    puts @title + "を削除しました"
  end
end

# Composite
class DirEntry < Entry
  def initialize(name)
    @title = name
    @directory = Array.new
  end

  def get_name
    @title
  end

  def add(entry)
    @directory.push(entry)
  end

  def ls_entry(prefix)
    puts(prefix + "/" + get_name)
    @directory.each do |e|
      e.ls_entry(prefix + "/" + @title)
    end
  end

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

root.remove
#/root
#/root/tmp
#/root/tmp/conf
#/root/tmp/data
#confを削除しました
#dataを削除しました
#tmpを削除しました
#rootを削除しました