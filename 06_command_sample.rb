require "fileutils"

# コマンドのインターフェース
class Command
  attr_reader :description
  def initialize(description)
    @description = description
  end

  def execute
  end
end

# ファイルを作成する命令
class CreateFile < Command
  def initialize(path, contents)
    super("Create file : #{path}")
    @path = path
    @contents = contents
  end

  def execute
    f = File.open(@path, "w")
    f.write(@contents)
    f.close
  end

  def undo_execute
    File.delete(@path)
  end
end

# ファイルを削除する命令
class DeleteFile < Command
  def initialize(path)
    super("Delete file : #{path}")
    @path = path
  end

  def execute
    if File.exists?(@path)
      @content = File.read(@path)
    end
    File.delete(@path)
  end

  def undo_execute
    f = File.open(@path, "w")
    f.write(@contents)
    f.close
  end
end

# ファイルをコピーする命令
class CopyFile < Command
  def initialize(source, target)
    super("Copy file : #{source} to #{target}")
    @source = source
    @target = target
  end

  def execute
    FileUtils.copy(@source, @target)
  end

  def undo_execute
    File.delete(@target)
    if(@contents)
      f = File.open(@target, "w")
      f.write(@contents)
      f.close
    end
  end
end

# 複数のコマンドをまとめて実行できるようにしたオブジェクト
class CompositeCommand < Command
  def initialize
    @commands = []
  end

  def add_command(cmd)
    @commands << cmd
  end

  def execute
    @commands.each { |cmd| cmd.execute }
  end

  def undo_execute
    @commands.reverse.each { |cmd| cmd.undo_execute }
  end

  def description
    description = ""
    @commands.each { |cmd| description += cmd.description + "\n"}
    description
  end
end

# ===========================================
command_list = CompositeCommand.new
command_list.add_command(CreateFile.new("file1.txt", "hello world\n"))
command_list.add_command(CopyFile.new("file1.txt", "file2.txt"))
command_list.add_command(DeleteFile.new("file1.txt"))

command_list.execute
puts(command_list.description)
#=> Create file : file1.txt
#=> Copy file : file1.txt to file2.txt
#=> Delete file : file1.txt

# 処理を取り消すコマンド
command_list.undo_execute
# file2が消えている