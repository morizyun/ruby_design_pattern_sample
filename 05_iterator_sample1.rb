# -*- coding: utf-8 -*-

# 集約オブジェクト中の要素
class Article
  def initialize(title)
    @title = title
  end

  # 記事のタイトル
  attr_reader :title
end

# 集約オブジェクト(ブログ/blog)
class Blog
  def initialize
    @articles = []
  end

  # 指定インデックスの要素を返す
  def get_article_at(index)
    @articles[index]
  end

  # 要素(Article)を追加する
  def add_article(article)
    @articles << article
  end

  # 要素(Article)の数を返す
  def length
    @articles.length
  end

  # イーテレータの生成
  def iterator
    BlogIterator.new(self)
  end
end

# 外部イーテレータ
class BlogIterator
  def initialize(blog)
    @blog = blog
    @index = 0
  end

  # 次のindexの要素が存在するかをtrue/falseで返す
  def has_next?
    @index < @blog.length
  end

  # indexを1つ進めて、次のArticleクラスを返す
  def next_article
    article = self.has_next? ? @blog.get_article_at(@index) : nil
    @index = @index + 1
    article
  end
end

# ===========================================
blog = Blog.new
blog.add_article(Article.new("デザインパターン1"))
blog.add_article(Article.new("デザインパターン2"))
blog.add_article(Article.new("デザインパターン3"))
blog.add_article(Article.new("デザインパターン4"))

iterator = blog.iterator
while iterator.has_next?
  article = iterator.next_article
  puts article.title
end
#デザインパターン1
#デザインパターン2
#デザインパターン3
#デザインパターン4