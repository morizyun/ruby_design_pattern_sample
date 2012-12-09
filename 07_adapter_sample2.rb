# アダプティ(Adaptee)
# Targetにはないインターフェイスを持つ
class OldTextObject
  def initialize(string)
    @string = string.dup
  end

  def show_with_bracket
    puts "[#{@string}]"
  end

  def show_with_asterisk
    puts "**#{@string}**"
  end
end

# ターゲット(Target)
# 実行対象
class TextObject
  def initialize(obj)
    @obj = obj
  end

  def print_weak
    @obj.print_weak
  end

  def print_strong
    @obj.print_strong
  end
end

# 利用者(Client)
text = OldTextObject.new("Hello")
def text.print_weak
  show_with_bracket
end
def text.print_strong
  show_with_asterisk
end

# ===========================================
p = TextObject.new(text)
p.print_weak
p.print_strong
#[Hello]
#**Hello**