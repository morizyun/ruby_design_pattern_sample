# -*- coding: utf-8 -*-

# 集約オブジェクト中の要素
class Article
  def initialize(title)
    @title = title
  end

  attr_reader :title
end

# 集約オブジェクト
class Blog
  def initialize
    @articles = []
  end

  def get_article_at(index)
    @articles[index]
  end

  def add_article(article)
    @articles << article
  end

  def length
    @articles.length
  end

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

  def has_next?
    @index < @blog.length
  end

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